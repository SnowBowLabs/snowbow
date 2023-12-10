// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "solady/tokens/ERC20.sol";

contract WBTC is ERC20 {
    function name() public pure override returns (string memory) {
        return "Wrapped BTC";
    }

    /// @dev Returns the symbol of the token.
    function symbol() public pure override returns (string memory) {
        return "WBTC";
    }

    function mint(address user, uint256 amount) public {
        _mint(user, amount);
    }
}
