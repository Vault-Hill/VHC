// SPDX-License-Identifier: unlicenced

pragma solidity ^0.8.6;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract VaultHillCity is ERC20, Ownable {
    mapping(address => bool) private _blocklist;

    event UserBlocked(address user);
    event UserUnblocked(address user);

    constructor() ERC20("Vault Hill City", "VHC") {
        _mint(msg.sender, 340000000 * 10 ** uint256(decimals()));
    }
    
    /**
     * @dev Returns a boolean indicating whether a certain address is on the blocklist
     */
     function isUserBlocked(address account) public view returns (bool) {
         return _blocklist[account];
     }

    function burn(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
    }

     /**
     * @dev Add an address to the blocklist
     */
     function blockUser(address user) public onlyOwner {
         require(user != address(0), "Address zero cannot be added to the blocklist");
         _blocklist[user] = true;
         emit UserBlocked(user);
     }
     
     /**
     * @dev Removes an address from the blocklist
     */
     function unblockUser(address user) public onlyOwner {
         require(_blocklist[user], "Address is not on blocklist");
         _blocklist[user] = false;
         emit UserUnblocked(user);
     }

    /**
     * @dev See {IERC20-balanceOf}.
     * 
     * Hook that checks whether an address is on the blocklist before 
     * initiating a token transfer.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        require(_blocklist[from] != true, "User on blocklist: Sender is blacklisted");
        require(_blocklist[to] != true, "User on blocklist: Recipient is blacklisted");
        
        super._beforeTokenTransfer(from, to, amount);
    }
}