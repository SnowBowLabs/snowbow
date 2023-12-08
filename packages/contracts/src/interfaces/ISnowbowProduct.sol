// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {IStructDef} from "./IStructDef.sol";

interface ISnowbowProductDef {
    error InvalidTokenParams();
    error SnowbowStarted();
    error SnowbowNotEnded();
    error Claimed();
}

interface ISnowbowProduct is ISnowbowProductDef, IStructDef {
    function initialize(ProductInitArgs calldata args) external;
}
