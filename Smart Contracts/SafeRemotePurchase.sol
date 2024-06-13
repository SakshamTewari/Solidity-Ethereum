//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PurchaseAgreement {
    uint public value;
    address payable public seller;
    address payable public buyer;

    enum State{
        Created,
        Locked,
        Release,
        Inactive
    }

    State public state;

    constructor() payable {
        seller = payable(msg.sender);
    }

    function confirmPurchase() external payable {
        require(msg.value == 2 * value, "Please send in 2x the purchase amount");
        buyer = payable(msg.sender);
        state = State.Locked; 
    }
 }