// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.16;

contract Consumer {
    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function deposit() public payable {}
}

contract SmartContractWallet {

    address payable public owner;
    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;

    mapping(address => bool) public guardians;
    mapping(address => mapping(address => bool)) nextOwnerGuradianVotedBool;
    address payable nextOwner;
    uint guardianResetCount;
    uint public constant confirmationFromGuardianToReset = 3;


    constructor() {
        owner = payable(msg.sender);
    }

    function setGuardian(address _guardian, bool isGuardian) public {
        require(msg.sender == owner, "You are not the owner, aborting");
        guardians[_guardian] = isGuardian;
    }

    function proposeNewOwner(address payable _newOwner) public{
        require(guardians[msg.sender] == true, "You are not the Guardian, aborting!");
        require(nextOwnerGuradianVotedBool[_newOwner][msg.sender] == false, "You have already voted, aborting");
        if(_newOwner != nextOwner){
            nextOwner = _newOwner;
            guardianResetCount = 0;
        }
        
        guardianResetCount++;

        if(guardianResetCount >= confirmationFromGuardianToReset){
            owner = nextOwner;
            nextOwner = payable(address(0));
        }
    }

    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == owner, "You are not the owner, aborting");
        allowance[_for] = _amount;

        if(_amount > 0){
            isAllowedToSend[_for] = true;
        }else{
            isAllowedToSend[_for] = false;
        }
    }

    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns(bytes memory){
        //require(msg.sender == owner, "You are not the owner, aborting");
        if(msg.sender != owner){
            require(allowance[msg.sender] >= _amount, "You do not have sufficient balance, aborting!");
            require(isAllowedToSend[msg.sender], "You are not allowed to send anything from this contract, aborting");

            allowance[msg.sender] -= _amount;
        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(_payload);
        require(success, "Aborting, call was not successful!");

        return returnData;
    }


    receive() external payable {} 
}