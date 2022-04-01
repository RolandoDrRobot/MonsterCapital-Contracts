//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CoraToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Cora", "CORA") {
        _mint(msg.sender, initialSupply);
    }

    // replace default 18 decimals

    function decimals() public view virtual override returns (uint8) {
        return 8;
    }
}
