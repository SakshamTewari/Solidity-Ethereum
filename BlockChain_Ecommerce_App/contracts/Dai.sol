// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Dai is ERC20 {
    constructor() ERC20("Dai Stablecoin", "DAI") {}

    // function to create DAI token by faucet
    function faucet(address to, uint amount) external {
        _mint(to, amount);
    }
}
