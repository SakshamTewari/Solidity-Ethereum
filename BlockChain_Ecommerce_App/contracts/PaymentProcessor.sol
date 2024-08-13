// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PaymentProcessor {
    // address of merchant
    address public admin;

    // a variable that points to DAI smart contract
    // using 'DAI' coin as it is always stable [1 DAI = 1 USD]
    IERC20 public dai;

    // address of dai will be different here as we are deploying it on public testnet
    constructor(address adminAddress, address daiAddress) {
        admin = adminAddress;
        dai = IERC20(daiAddress);
    }
}
