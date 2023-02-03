// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity 0.8.15;

contract ExampleMapping {
    mapping(uint => bool) public myMap;
    mapping(address => bool) public myAddressMap;
    mapping(uint => mapping(uint => bool)) public myNestedMap;

    function setValue(uint _index) public {
        myMap[_index] = true;
    }

    function setmyAdressToTrue() public {
        myAddressMap[msg.sender] = true;
    }

    function setMyNestedMapKey(uint key1, uint key2, bool val) public{
        myNestedMap[key1][key2] = val;
    }
}