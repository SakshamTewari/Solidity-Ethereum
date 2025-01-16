// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Create a 'Will' contract
(1) Every  user will deploy their own 'Will' contract.
(2) When initialized, set the owner to be the person initializing.
(3) Owner can define a recipient in the contructor.
(4) Owner should be allowed to change the recipient.
(5) Owner can interact with the contract via a ping function.
(6) If ping hasn't been called for >10 years, the recipient should be allowed to call a drain function
*/

contract Will {
    address public owner;
    address payable  recipient;
    uint startTime;
    uint tenYears;
    uint lastVisited;
    constructor(address payable _recipient) {
        tenYears = 1 hours * 24 * 365 * 10;
        startTime = block.timestamp;
        lastVisited = block.timestamp;
        owner = msg.sender;
        recipient = _recipient;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, 'Caller not the owner');
        _;
    }

    modifier onlyRecipient() {
        require(msg.sender == recipient, 'Caller not the recipient');
        _;
    }

    function deposit() public payable onlyOwner {
        lastVisited = block.timestamp;
    }

    // This function is only to tell that the owner is still alive :P
    function ping() public {
        lastVisited = block.timestamp;
    }

    function claim() external onlyRecipient {
        require(lastVisited < block.timestamp - tenYears, "Owner is still alive");
        payable(recipient).transfer(address(this).balance);
    }
}