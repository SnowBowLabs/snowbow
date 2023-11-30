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
    
    struct ProductInfo {
        uint256 targetInitPrice;
        uint256 targetKnockInPrice;
        uint256 targetKnockOutPrice;
        uint256 startTime;
        uint256 period;
        uint256 baseProfit;
        address usdToken;
    }

    

    // get the product status
    // return product status, valid period length, end price of target assets(if apply)
    function getProductResult(address productAddr)
        external
        view
        returns (SnowbowResultStatus, uint256 period, uint256 endPrice);


    /**
    * @dev Registers a new product with the given product information.
    * @param productInfo The information about the product to be registered.
    * @param productAddr The product address
    */
    function registerProduct(address productAddr,ProductInfo calldata productInfo) external;
    
}
