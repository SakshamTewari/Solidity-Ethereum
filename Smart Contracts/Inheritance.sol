// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Ownable {

    address owner;

    constructor() public{
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "not owner");
        _;
    }
}


contract MyContract is Ownable {

    string secret;

    constructor(string memory _secret) public {
        secret = _secret;
        super;  //call the constructor of parent contract;
    }

    function getSecret() public view onlyOwner returns (string memory){
        return secret;
    }

}