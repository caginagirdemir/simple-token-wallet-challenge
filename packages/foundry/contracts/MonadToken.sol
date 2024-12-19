// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MonadToken is ERC20 {
    constructor() ERC20("Monad Token", "MON") {
        _mint(msg.sender, 1000000 * 10**18);
    }
    
}
