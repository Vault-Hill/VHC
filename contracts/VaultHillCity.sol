// SPDX-License-Identifier: unlicenced
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VaultHillCity is ERC20 {
    constructor() ERC20("Vault Hill City", "VHC") {
        _mint(msg.sender, 340000000 * 10 ** uint256(decimals()));
    }
    function burnTokens(uint256 _amount) public {
        _burn(msg.sender, _amount);
    }
}