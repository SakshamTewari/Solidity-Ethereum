// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

contract CrowdFund {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
    }
    Request[] public requests;
    address public manager;    
    uint public minimumContribution;
    address[] public approvers;  //people who will approve manager's spending request

    modifier restricted(){
        require(msg.sender == manager);
        _;
    }

    // person can call this function to start the campaign
    function Campaign(uint minimum) public {
        manager = msg.sender;          //person who starts the campaign will be the manager
        minimumContribution = minimum;  //Minimum contribtuion required for anyone who wants to contribute
    }

    //people who want to contribute can call this function and send amount
    function contribute() payable public {
        require(msg.value > minimumContribution);
        approvers.push(msg.sender);   // if person has sent good amount, add him/her to approvers list
    }

    //allow manager to create a request
    function createRequest(string memory _description, uint _value, address _recipient) public restricted {
        Request memory newRequest = Request({
            description: _description,
            value: _value,
            recipient: _recipient,
            complete: false
        });

        requests.push(newRequest);
    }
}