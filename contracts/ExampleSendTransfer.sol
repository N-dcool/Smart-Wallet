// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.15;

contract ExampleSendTransfer {

    function withdrawTransfer(address payable _to) public {
        _to.transfer(10);
    }

    function withdrawSend(address payable _to) public {
        bool trans = _to.send(10);
        require(trans, "unsuccessfull tranction !!");
    }

    receive() external payable {}
}

contract ReceiverNoAction {

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    receive() external payable {}
}

contract ReceiverAction {
    uint public balanceReveived;

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    receive() external payable {
        balanceReveived += msg.value;
    }
}