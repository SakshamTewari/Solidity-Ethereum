// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract HotelRoom {

    enum Statuses { Vacant, Occupied }
    Statuses public currentStatus;
    address payable public owner;

    //Events
    event Occupy(address _occupant, uint _value);

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently occupied");
        _;
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough ether provided");
        _;
    }

    function bookRoom() public payable onlyWhileVacant costs(2 ether) {
        //Check price
        //Check status : so the same room is not booked twice if its already occupied
        //person who books will transfer eth to the owner;
        currentStatus = Statuses.Occupied;
        
        // owner.transfer(msg.value);
        // instead of 'transfer', we use 'call' where we can also get a bool value and use it to emit event further
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(sent);

        emit Occupy(msg.sender, msg.value);
    }
}