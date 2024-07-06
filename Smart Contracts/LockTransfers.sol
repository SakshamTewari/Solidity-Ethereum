// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
There are 2 common ways to lock transfers:
    (1) add condition on block number as normal creation time of an Ethereum block is 15 seconds
    (2) Set a state flag
*/

contract LockTransfers {
    //function modifier checks the block number
    modifier checkBlock() {
        require(block.number > 6000000, "Can Not Trade");
        _;
    }

    // add 2 state variables , a true flag
    address owner;
    bool public transferable = false;

    //function modifier to check transferable flag
    modifier isTransferable() {
        require(transferable == true, "Can not trade");
        _;
    }

    function transfer(
        address _to,
        uint _value
    ) public checkBlock isTransferable returns (bool success) {
        //  transfer code
    }
}
