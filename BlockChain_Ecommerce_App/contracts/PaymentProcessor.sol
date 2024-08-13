// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PaymentProcessor {
    // address of merchant
    address public admin;

    // a variable that points to DAI smart contract
    // using 'DAI' coin as it is always stable [1 DAI = 1 USD]
    IERC20 public dai;

    // even when payment is done
    event PaymentDone(address payer, uint amount, uint paymentId, uint date);

    // address of dai will be different here as we are deploying it on public testnet
    constructor(address adminAddress, address daiAddress) {
        admin = adminAddress;
        dai = IERC20(daiAddress);
    }

    // function 'pay'
    // amount = amount of dai token that is transferred
    // transfers token from 'buyer' to 'admin' [merchant]
    // tokens will never be in our smart contract
    function pay(uint amount, uint paymentId) external {
        dai.transferFrom(msg.sender, admin, amount);
        emit PaymentDone(msg.sender, amount, paymentId, block.timestamp);
    }
}
