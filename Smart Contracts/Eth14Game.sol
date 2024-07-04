// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//14th person that deposits the ether wins all the ether in the contract
//winner can claim 14 ether

contract Eth14Game {

    uint public targetAmount = 14 ether;
    uint public balance;
    address public winner;

    function deposit() external payable {
        require(msg.value == 1 ether, "You can only send 1 ether");
        balance += msg.value;
        require(balance <= targetAmount, "Game is over");

        if(balance == targetAmount){
            winner = msg.sender;
        }
    }

    function claimReward() public {
        require(msg.sender == winner, "You are not the winner");
        (bool sent, ) = msg.sender.call(value: address(this).balance(""));
        require(sent, "Ether sent failed");
    
    }

    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}