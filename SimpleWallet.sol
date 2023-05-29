// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Wallet {


    function deposit() public payable {
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawToAddress(address payable to) public {
        to.transfer(address(this).balance);
    }

}
