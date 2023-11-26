// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

interface IPriceObserver {
    enum SnowbowResultStatus {
        Invalid,
        NotEnd,
        NorInOrOut,
        InAndOut,
        OnlyOut,
        OnlyIn
    }

    // get the product status
    // return product status, valid period, end price(if apply)
    function getProductResult(address productAddr)
        external
        view
        returns (SnowbowResultStatus, uint256 period, uint256 endPrice);
}
