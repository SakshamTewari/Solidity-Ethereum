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

    /// The function cannot be called at the current state.
    error InvalidState();
    /// Only the buyer can call the function
    error OnlyBuyer();

    modifier inState(State _state){
        if(state != _state) {
            revert InvalidState();
        }
        _;
    }

    modifier onlyBuyer(){
        if(msg.sender != buyer) {
            revert OnlyBuyer();
        }
        _;
    }

    function confirmPurchase() external inState(State.Created) payable {
        require(msg.value == 2 * value, "Please send in 2x the purchase amount");
        buyer = payable(msg.sender);
        state = State.Locked; 
    }

    function confirmReceived() external onlyBuyer inState(State.Locked){
        state = State.Release;
        buyer.transfer(value);
    }
 }