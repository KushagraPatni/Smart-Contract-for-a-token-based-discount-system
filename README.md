Group 14 Participants-

1-Aryan Sharma-2021A4PS2551H
2-Kushagra Patni-2021A3PS2985H
3-Abhishek Kochar-2021A4PS2495H
4-Harshwardhan Bhardwaj-2021A8PS2985H 

# Blockchain Assignment - 2

## Automation of Offer Token Distribution

Title: DiscountContract - A Solidity Smart Contract

### Description

This Solidity smart contract, named `DiscountContract`, is designed to manage a discount system, enabling users to make purchases and redeem discounts using a custom ERC20 token (`offer_token`). It offers a structured framework for handling customer balances, purchases, discounts, and token issuance.

### Functions

Below is a detailed explanation of each function in the `DiscountContract` smart contract.

1. **Constructor - `constructor(address _unspent, uint supply)`:
   - The constructor initializes the contract with the following parameters:
     - `_unspent`: An address designated for disposing of used tokens.
     - `supply`: The total supply of the custom ERC20 token (`offer_token`).
   - It also sets the contract deployer as the company and approves a transfer of the total supply of tokens from the token contract to this contract.

2. **makePurchase - `makePurchase(uint id) payable public`:
   - This function allows users (buyers) to make a purchase by specifying a product ID.
   - It checks several conditions:
     - Ensures that the sender is not the company or the unspent address.
     - Validates the product's existence.
     - Verifies if the sent Ether matches the product's price.
   - If the purchase is valid, it records the purchase, transfers funds to the company, and issues tokens to the buyer.

3. **issueToken - `issueToken(address addr) private`:
   - This internal function is called to issue tokens to a buyer after a valid purchase.
   - It checks if the purchase is valid and then issues a fixed number of tokens (currently set at 10 tokens) to the buyer.

4. **redeemDiscount - `redeemDiscount() external`:
   - Users can call this function to redeem discounts if they have a balance of at least 10 tokens.
   - It calculates a discount based on the number of tokens owned by the caller.
   - If the discount is valid, it transfers tokens to the contract, reducing the customer's balance.

5. **seeTokenBalance - `seeTokenBalance() external view returns(uint)`:
   - This function allows users to check their token balance. It returns the token balance of the caller.

6. **TotalSupply - `TotalSupply() external view returns(uint)`:
   - Restricted to the company, this function returns the total supply of tokens held by the contract.

7. **checkAllowance - `checkAllowance() private view returns(uint)`:
   - This private function checks the allowance of the token contract for the caller.

8. **getProductPrice - `getProductPrice(uint id) public view returns(uint)`:
   - Users can call this function to get the price of a product based on its ID.
   - The price is adjusted according to any discounts.

9. **_getProductPrice - `_getProductPrice(address addr, uint id) private view returns(uint)`:
   - This private function calculates the final price of a product, considering discounts based on the buyer's address and the product's ID.

### Prerequisites

- Ensure that the `offer_token` contract (not provided in this code) is properly deployed and functions as expected.
- Deploy the `DiscountContract` to an Ethereum network.

This README provides a detailed explanation of each function within the `DiscountContract` smart contract. Make sure to customize this README with your project-specific information and requirements.


