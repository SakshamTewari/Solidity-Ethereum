pragma solidity ^0.8.0;

contract CrowdFund {
    address public manager;    
    uint public minimumContribution;
    address[] public approvers;  //people who will approve manager's spending request

    // person can call this function to start the campaign
    function Campaign(uint minimum) public {
        manager = msg.sender;          //person who starts the campaign will be the manager
        minimumContribution = minimum  //Minimum contribtuion required for anyone who wants to contribute
    }

    //people who want to contribute can call this function and send amount
    function contribute() public {
        require(msg.value > minimumContribution);
        approvers.push(msg.sender)   // if person has sent good amount, add him/her to approvers list
    }
}