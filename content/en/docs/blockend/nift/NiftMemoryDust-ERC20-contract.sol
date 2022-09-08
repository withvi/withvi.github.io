// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.1.0/contracts/token/ERC20/ERC20.sol";

contract NiftMemoryDust is ERC20 {
    
    constructor() ERC20("Nift memory dust", "NIFT-DUST") {
        _mint(msg.sender,1000 * 1e18);
    }
}