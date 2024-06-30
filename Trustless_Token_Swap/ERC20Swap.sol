// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract ERC20Swap is ERC20 {
    constructor() public ERC20("ERC20Swap", "SWA20") {
        _mint(msg.sender, 100 * 10 ** uint(decimals()));
    }
}
