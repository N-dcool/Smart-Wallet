// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.15;

contract ExampleMappingWithdrawals{

     mapping(address => uint) public balanceReceived;

    function sendMoney() public payable{
        balanceReceived[msg.sender] += msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawAllMoney(address payable _to) public {
        uint totalBalanceToSend = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(totalBalanceToSend);
    }
}