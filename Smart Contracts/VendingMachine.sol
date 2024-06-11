// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract VendingMachine {

    address public owner;
    mapping(address => uint) public donutBalances;

    constructor {
        owner = msg.sender;
        donutBalances[address(this)] = 100;   // set the balance of 100 to the contract address
    }
}