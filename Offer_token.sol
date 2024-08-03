// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract offer_token is ERC20 {
     constructor(uint initial_supply) ERC20("Offer Token", "OT") {
        _mint(msg.sender, initial_supply);
     }

     function approve_transfer(address owner, address spender, uint value) public{
         _approve(owner, spender, value);
     }
}