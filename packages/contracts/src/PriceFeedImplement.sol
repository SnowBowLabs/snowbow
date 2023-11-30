// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV2V3Interface.sol";

import "./interfaces/IPriceObserver.sol";


contract PriceFeedImplement is IPriceObserver {

    mapping(string => address) private dataFeedAddresses;
    mapping(address => ProductInfo) private tokenInfos;
    mapping(address => uint256) private currentInfo;
    address[] private productAddresses; 
    constructor() {

    }



    function getLatestPrice() public {
        for (uint i = 0; i < productAddresses.length; i++) {
            address productAddr = productAddresses[i];
            ProductInfo storage product = tokenInfos[productAddr];
            AggregatorV2V3Interface dataFeed = AggregatorV2V3Interface(product.usdToken);
            (, int256 price, , , ) = dataFeed.latestRoundData();
            currentInfo[productAddr] = uint256(price);
        }
    }


    function getProductResult(address productAddr) 
    external 
    view 
    returns(SnowbowResultStatus, uint256 period, uint256 endPrice) {
        ProductInfo memory product = tokenInfos[productAddr];
        uint256 currentPrice = currentInfo[productAddr];
        SnowbowResultStatus status;

        // 根据价格计算赌局状态
        if (currentPrice >= product.targetKnockInPrice && currentPrice <= product.targetKnockOutPrice) {
            status = SnowbowResultStatus.InAndOut;
        } else if (currentPrice >= product.targetKnockOutPrice) {
            status = SnowbowResultStatus.OnlyOut;
        } else if (currentPrice <= product.targetKnockInPrice) {
            status = SnowbowResultStatus.OnlyIn;
        } else {
            status = SnowbowResultStatus.NorInOrOut;
        }
        return (status, product.period, currentPrice); 
    }

    function registerProduct(address productAddr, ProductInfo calldata productInfo )  external
    {
        tokenInfos[productAddr] = productInfo;
        productAddresses.push(productAddr);
    }
}