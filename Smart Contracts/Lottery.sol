/*
Lottery Algorithm

    - A manager to manage the lottery system
    - Different players who participate
    - Participate fees
    - Atleast 3 participants
*/

pragma solidity ^0.8.0;

contract Lottery {
    address public manager;
    address payable[] public players;
    address payable public winner;

    constructor(){
        manager = msg.sender;
    }

    // function that users call to participate in the lottery game
    function participate() public payable {
        require(msg.value == 1 ether, "Please pay 1 ether to participate");
        players.push(payable(msg.sender));
    }

    // to check the balance of the contract
    function getBalance() public view returns(uint){
        require(msg.sender == manager, "You are not the manager");
        return address(this).balance;
    }

    // ideally we should use Oracle to generate random number
    function random() internal view returns(uint){
        return uint(keccak256(abi.encodePacked((block.difficulty, block.timestamp, players.length))));
    }

    // manager calls this function to get the winner
    function pickWinner() public {
        require(msg.sender == manager, "You are not the manager");
        require(players.length >= 3 , "Players are less than 3");

        uint r = random();
        uint index = r % players.length;
        winner = players[index];
        winner.transfer(getBalance());
        players = new address payable[](0); //initialise array back to 0;
    }
}
