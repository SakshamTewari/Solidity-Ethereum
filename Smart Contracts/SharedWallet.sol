// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SharedWallet {
    address public _owner;
    mapping(address => uint8) private _owners; //to check if the owner is enabled or disabled

    constructor() {
        _owner = msg.sender;
    }

    // only owner can interact with the wallet
    modifier isOwner() {
        require(msg.sender == _owner, "You are not the owner");
        _;
    }

    // to check if the sender is owner or an enabled owner
    modifier validOwner() {
        require(
            msg.sender == _owner || _owners[msg.sender] == 1,
            "You are not authorized"
        );
        _;
    }

    event DepositFunds(address from, uint amount);
    event WithdrawFunds(address from, uint amount);
    event TransferFunds(address from, address to, uint amount);

    // to add other owners
    function addOwner(address owner) public isOwner {
        _owners[owner] = 1;
    }

    // to remove other owners
    function removeOwner(address owner) public isOwner {
        _owners[owner] = 0;
    }

    //anyone can deposit fund into the wallet
    function depositFund() external payable {
        // address(this).balance += amount;
        emit DepositFunds(msg.sender, msg.value);
    }

    //only owners can withdraw from wallet
    function withdrawFund(uint amount) public validOwner {
        require(address(this).balance >= amount, "Insufficient funds");
        payable(msg.sender).transfer(amount);
        emit WithdrawFunds(msg.sender, amount);
    }

    function transferTo(address to, uint amount) public validOwner {
        require(address(this).balance >= amount, "Insufficient funds");
        payable(to).transfer(amount);
        emit TransferFunds(msg.sender, to, amount);
    }
}
