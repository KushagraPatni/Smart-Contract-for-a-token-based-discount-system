// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;


import "./Offer_token.sol"; // Import the ERC20 token contract

contract DiscountContract {
    uint total_supply;
    offer_token private token;
    address payable private company;
    address private unspent;
    struct Buyer {
        uint amount;
        bool tokentoBeIssued;
    }

    mapping(address => uint256) public customerBalances;
    mapping(address => Buyer) public Buyer_Records;
    mapping(address => uint) public Buyer_Discounts;
    uint[] products = [10 ether, 20 ether, 30 ether];
    
    constructor(address _unspent, uint supply) {
        token = new offer_token(supply);
        company = payable(msg.sender);
        unspent = _unspent;
        total_supply = supply;
        token.approve(address(this), total_supply);
    }

    function makePurchase(uint id) payable public {
        require(msg.sender != company, "Company cannot make purchases.");
        require(msg.sender != unspent, "Purchase cannot be made from unspent address. It is designated for dumping used tokens");
        require(id < products.length, "Product does not exist");

        uint amount_required = _getProductPrice(msg.sender, id);
        if(amount_required == msg.value){
              Buyer memory buyer = Buyer(msg.value, true);
              Buyer_Records[msg.sender] = buyer;
              company.transfer(msg.value);
              //issueToken(msg.sender);
              Buyer_Discounts[msg.sender] = 0;
        }
        else{
            revert("Wrong amount sent. Purchase Failed");
        }
        
    }

    function issueToken(address addr) public {
        require(msg.sender == company, "Tokens can be issued only by the company");
        require(Buyer_Records[addr].tokentoBeIssued == true, "Tokens cannot be issued since no valid purchase has been made");
        
        // After the purchase is valid, issue tokens to the customer
        uint256 tokensToIssue = 10; // Adjust the calculation as needed
        require(tokensToIssue > 0, "Not enough purchase for tokens.");
        customerBalances[addr] += tokensToIssue;
        token.transfer(addr, tokensToIssue);  //here
        Buyer_Records[addr].tokentoBeIssued = false;
    }
    
    function redeemDiscount() external {
        require(customerBalances[msg.sender] >= 10, "Insufficient tokens for discount.");
        //discount logic
        uint tokens = customerBalances[msg.sender];
        uint discount_percent = tokens;
        Buyer_Discounts[msg.sender] = discount_percent;
        // Assuming the discount is valid, subtract tokens from the customer
        customerBalances[msg.sender] -= tokens;
        token.approve_transfer(msg.sender, address(this), tokens); //here
        token.transferFrom(msg.sender, unspent, tokens);   //here
    }

    function seeTokenBalance() external view returns(uint) {
       return token.balanceOf(msg.sender);
       // return customerBalances[msg.sender];
    }

    function TotalSupply() external view returns(uint) {
       require(msg.sender == company, "Only the company can access total supply");
       return token.balanceOf(address(this)); //here
       // return customerBalances[msg.sender];
    }

    function checkAllowance() private view returns(uint) {
        return token.allowance(address(this), msg.sender); //here
    }

    function getProductPrice(uint id) public view returns(uint){
        require(id < products.length, "Product does not exist");
         return _getProductPrice(msg.sender, id) / (10 ** 18);   //Price in Ethers
    }

    function _getProductPrice(address addr, uint id) private view returns(uint){
        return products[id - 1] - ((products[id - 1]*Buyer_Discounts[addr])/100);
    }
}