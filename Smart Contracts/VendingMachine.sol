// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract VendingMachine {

    address public owner;
    mapping(address => uint) public donutBalances;

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;   // set the balance of 100 to the contract address
    }

    function getVendingMachingBalance() public view returns(uint){
        return donutBalances[address(this)];
    }

    function restock(uint amount) public {
        require(msg.sender == owner, "Only owner can restock this machine");
        donutBalances[address(this)] + amount;
    }
}