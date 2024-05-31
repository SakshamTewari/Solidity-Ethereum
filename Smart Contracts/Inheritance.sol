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


//Now creating another smart contract 'SecretVault' which will be deployed through 'MyContract2'
//We will use getSecret() function from that contract

contract SecretVault {

    string secret;
    constructor(string memory _secret) public {
        secret = _secret;
    }
    function getSecret() public view returns (string memory){
        return secret;
    }
}


contract MyContract2 is Ownable {

    address secretVault;        //address of SecretVault contract as it will be used to use its functions

    constructor(string memory _secret) public {
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);       //storing address of the 'new' SecretVault contract
        super;  //call the constructor of parent contract (Ownable);
    }

    function getSecret() public view onlyOwner returns (string memory){
        return SecretVault(secretVault).getSecret();
    }

}