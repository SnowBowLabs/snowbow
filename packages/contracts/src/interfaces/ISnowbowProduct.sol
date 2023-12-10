// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {IStructDef} from "./IStructDef.sol";

interface ISnowbowProductDef {
    error InvalidTokenParams();
    error SnowbowStarted();
    error SnowbowNotEnded();
    error Claimed();

    event BuyShare(address indexed user, uint256 usdAmount, uint256 targetAmount);
}

interface ISnowbowProduct is ISnowbowProductDef, IStructDef {
    function initialize(ProductInitArgs calldata args) external;
    function hedge() external;
}
