// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// use safe math to prevent underflow and overflow
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";


contract TimeLock {

    using SafeMath for uint; //to use .add

    mapping(address => uint) public balances; //balance mapping
    mapping(address => uint) public lockTime; //timeLock mapping (when the user can withdraw)

    function deposit() external payable {
        //update amount of ether deposited in balances
        balances[msg.sender] += msg.value;

        //lockTime is of 1 week before which user cannot withdraw
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }
    

    function increaseTimeLock(uint _secondsToIncrease) public {
        lockTime[msg.sender] = lockTime[msg.sender].add(_secondsToIncrease);  //to prevent overflow, we used 'add' method of SafeMath
    }


    function withdraw() public {
        require(balances[msg.sender] > 0, "Not sufficient balance");
        require(block.timestamp > lockTime[msg.sender], "Lock Time has not expired");

        //update the balance after withdraw

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        // send the ether back to the sender
        (bool sent, ) = msg.sender.call(value: amount)("");
        require(sent, "Ether sent failed");
    }
}