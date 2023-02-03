// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.15;

contract MappingStructExample {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
        uint numWithdrawals;
        mapping(uint => Transaction) deposits;
        mapping(uint => Transaction) withdrawals;
    }

    mapping(address => Balance) public balances;

    function depositeMoney() public payable {
        balances[msg.sender].totalBalance += msg.value;
        Transaction memory deposit = Transaction(msg.value, block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].numDeposits] = deposit;

        balances[msg.sender].numDeposits++;
    }
    //getter Function for Transaction deposit:
    function getDepositTransaction(address _from, uint _indexDeposit) public view returns(Transaction memory){
        return balances[_from].deposits[_indexDeposit];
    }
    

    function withdrawMoney(address payable _to, uint _amount) public {
        balances[msg.sender].totalBalance -= _amount;
        Transaction memory withdraw = Transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawals[balances[msg.sender].numWithdrawals] = withdraw;
        balances[msg.sender].numWithdrawals++;
        _to.transfer(_amount);

        balances[msg.sender].numWithdrawals++;
    }

    //getter Functiom for Transaction withdraw:
    function getWithdrawTransaction(address _of, uint _indexWithdraw) public view returns(Transaction memory){
        return balances[_of].withdrawals[_indexWithdraw];
    }

}