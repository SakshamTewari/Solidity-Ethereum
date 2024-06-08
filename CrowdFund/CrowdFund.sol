pragma solidity ^0.8.0;

contract CrowdFund {
    address public manager;    
    uint public minimumContribution;


    // person can call this function to start the campaign
    function Campaign(uint minimum) public {
        manager = msg.sender;          //person who starts the campaign will be the manager
        minimumContribution = minimum  //Minimum contribtuion required for anyone who wants to contribute
    }
}