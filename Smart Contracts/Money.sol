// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Concept of payable
*/
contract Money {
    uint public totalAmount;

    function deposit() public payable {
        totalAmount += msg.value;
    }

    function drain(address payable ad) public {
        payable(ad).transfer(totalAmount);
        totalAmount = 0;
    }
}