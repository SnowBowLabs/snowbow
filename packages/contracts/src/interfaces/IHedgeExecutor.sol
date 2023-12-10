// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {IStructDef} from "./IStructDef.sol";

interface IHedgeExecutorDef is IStructDef {
    event PriceCheck(address indexed product, uint256 currentPrice);
    event KnockIn(address indexed product, uint256 triggerPrice);
    event KnockOut(address indexed product, uint256 triggerPrice);
    event ProductStatusChange(address indexed product, SnowbowResultStatus currentStatus);
}

interface IHedgeExecutor is IHedgeExecutorDef {
    /**
     * @dev Registers a new product.
     */
    function registerProduct() external;
}
