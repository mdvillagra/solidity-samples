// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "./CoffeeToken.sol";

contract TokenSale {

    uint tokenPrice = 1 ether;

    CoffeeToken token;

    constructor(address _token){
        token = CoffeeToken(_token);
    }

    function purchase() public payable{
        require(msg.value >= tokenPrice,"Not enough money sent");

        uint tokensToTransfer = msg.value/tokenPrice;
        uint remainder = msg.value - tokensToTransfer*tokenPrice;

        token.transfer(msg.sender, tokensToTransfer*10**token.decimals());
        payable(msg.sender).transfer(remainder);
    }

}
