pragma solidity ^0.8.0;

/*
Front running is a type of attack where an adversary exploits knowledge of pending transactions in the blockchain network to insert, alter, or cancel transactions in a way that benefits them. This can be particularly problematic in decentralized finance (DeFi) where transactions often involve trades or other financial operations.

Example of a Front Running Hack
To illustrate how a front-running attack might work, let's consider a simplified example involving a decentralized exchange (DEX).

Victim's Transaction: A user (Victim) submits a transaction to buy tokens on a DEX at a certain price.
Attacker's Observance: The Attacker sees the Victim's transaction in the pending transactions pool (mempool).
Attacker's Transaction: The Attacker submits their own transaction with a higher gas fee to ensure it is mined before the Victim's transaction.
Execution: The Attacker's transaction gets mined first, changing the token price on the DEX.
Victim's Transaction: The Victim's transaction gets mined next, but now at a worse price due to the Attacker's transaction.
*/

contract FindThisHash {
    bytes32 public constant hash = 0x564;

    constructor() payable {}

    function solve(string memory solution) public {
        require(hash = keccak256(abi.encodePacked(solution)), "wrong solution");
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}
