// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.15;

contract ContractOne {
    mapping(address => uint) public addressBalance;

    function deposit() public payable {
        addressBalance[msg.sender] += msg.value;
    }

    receive() external payable {
        deposit();
    }
}

contract ContractTwo {

    function depositeOnContractOne(address payable _contractOne) public {
        //#METHOD 1:
        // ContractOne one = ContractOne(_contractOne);
        // one.deposit{value: 10, gas: 100000}();
        //#METHOD 2:
        // bytes memory payload = abi.encodeWithSignature("deposit()");
        // (bool success, ) = _contractOne.call{value: 10, gas: 100000}(payload);   //It returns (boolean, return of call function)
        //                                                                     //In our case we don't have any return for deposit();
        //#METHOD 3:
        (bool success, ) = _contractOne.call{value: 10, gas: 100000}("");     // as it fails it calls receive function :D

        require(success);
    }


    receive() external payable {}
}