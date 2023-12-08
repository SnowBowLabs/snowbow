// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

interface ISnowbowProductDef {
    struct ProductInitArgs {
        address targetToken;
        uint256 targetInitPrice;
        uint256 targetKnockInPrice;
        uint256 targetKnockOutPrice;
        uint256 startTime;
        uint256 period;
        uint256 baseProfit;
        address usdToken;
        address priceObserver;
    }

    error InvalidTokenParams();
    error SnowbowStarted();
    error SnowbowNotEnded();
    error Claimed();
}

interface ISnowbowProduct is ISnowbowProductDef {
    function initialize(ProductInitArgs calldata args) external;
}
