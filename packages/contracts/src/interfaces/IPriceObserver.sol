// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {IStructDef} from "./IStructDef.sol";

interface IPriceObserverDef is IStructDef {
    event PriceCheck(address indexed product, currentPrice);
    event KnockIn(address indexed product, uint256 triggerPrice);
    event KnockOut(address indexed product, uint256 triggerPrice);
    event ProductStatusChange(address indexed product, SnowbowResultStatus currentStatus);
}

interface IPriceObserver is IPriceObserverDef {
    // get the product status
    // return product status, valid period length, end price of target assets(if apply)
    function getProductResult(address productAddr)
        external
        view
        returns (SnowbowResultStatus, uint256 period, uint256 endPrice);

    /**
     * @dev Registers a new product with the given product information.
     * @param productInfo The information about the product to be registered.
     */
    function registerProduct(ProductInfo calldata productInfo) external;
}
