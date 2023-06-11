// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


//Simple wallet with guardians
contract SampleWallet {

    address owner;

    mapping(address=>bool) public guardian;//list of guardians
    uint numberGuardians;//counts the number of guardians
    uint votes;//number of votes for the new owner
    address nextOwner;//temporal variable to choose a new owner

    constructor(){
        owner = msg.sender;
    }

    receive() external payable {}


    //function to choose a new owner that is voted by the guardians
    function chooseNewOwner(address _newOwner) public {
        require(guardian[msg.sender], "you are not a guardian");

        if(nextOwner != _newOwner){
            nextOwner = _newOwner;
            votes = 0;
        }

        votes++;

        if(votes >= numberGuardians/2){
            votes = 0;
            owner = nextOwner;
            nextOwner = address(0);
        }
    }

    //owner can set a new guardian
    function setGuardian(address _newGuardian) public {
        require(msg.sender == owner, "you are not the owner");
        guardian[_newGuardian] = true;
        numberGuardians += 1;
    }

    //owner can delete a guardian
    function deleteGuardian(address _delGuardian) public {
        require(msg.sender == owner, "you are not the owner");
        require(numberGuardians > 0,"there are no more guardiasn to delete");
        guardian[_delGuardian] = false;
        numberGuardians -= 1;
    }

    function balanceWallet() public view returns(uint){
        return address(this).balance;
    }

    //function to transfer funds
    function transfer(address payable _to, uint _amount) public {
        require(msg.sender == owner, "you are not the owner");
        require(address(this).balance >= _amount, "not enough funds to send");
        bool success = _to.send(_amount);
        require(success, "transfer failed");
    }

}
