// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV2V3Interface.sol";
import "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";

import "./interfaces/IPriceObserver.sol";

contract PriceObserver is IPriceObserver, AutomationCompatibleInterface {
    mapping(string => address) private dataFeedAddresses;
    mapping(address => ProductInfo) private productInfos;
    mapping(address => ProductResult) private productResult;
    address[] private monitorProductList;
    mapping(address => uint256) private productIndexes;

    uint256 public immutable interval;
    uint256 public lastTimeStamp;

    constructor(uint256 updateInterval, uint256 startTime) {
        interval = updateInterval;
        lastTimeStamp = startTime;
    }

    function getProductResult(address productAddr)
        external
        view
        returns (SnowbowResultStatus, uint256 period, uint256 endPrice)
    {
        ProductResult memory ps = productResult[productAddr];

        return (ps.status, ps.validPeriod, ps.endPrice);
    }

    function registerProduct(ProductInfo calldata productInfo) external {
        address productAddr = msg.sender;

        productInfos[productAddr] = productInfo;
        productResult[productAddr].status = SnowbowResultStatus.NotEnd;

        productIndexes[productAddr] = monitorProductList.length;
        monitorProductList.push(productAddr);

        emit ProductStatusChange(productAddr, SnowbowResultStatus.NotEnd);
    }

    function checkUpkeep(bytes calldata /* checkData */ )
        external
        view
        override
        returns (bool upkeepNeeded, bytes memory performData)
    {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
    }

    function performUpkeep(bytes calldata /* performData */ ) external override {
        if ((block.timestamp - lastTimeStamp) > interval) {
            // set timestamp
            lastTimeStamp = block.timestamp - block.timestamp % interval;
            _fetchProductPrice();
        }
    }

    function _fetchProductPrice() internal {
        for (uint256 i = 0; i < monitorProductList.length; i++) {
            address productAddr = monitorProductList[i];
            ProductInfo memory product = productInfos[productAddr];

            // product not start yet, check next one
            if (product.startTime > block.timestamp) {
                continue;
            }

            AggregatorV2V3Interface dataFeed = AggregatorV2V3Interface(product.targetTokenFeeData);
            (, int256 currentPriceInt,,,) = dataFeed.latestRoundData();
            uint256 currentPrice = uint256(currentPriceInt);

            emit PriceCheck(productAddr, currentPrice);

            ProductResult memory ps = productResult[productAddr];

            // judge whether knock in or knock in out now
            if (currentPrice >= product.targetKnockOutPrice) {
                ps.KnockOut = true;
                emit KnockOut(productAddr, currentPrice);
            } else if (currentPrice <= product.targetKnockInPrice) {
                ps.KnockIn = true;
                emit KnockIn(productAddr, currentPrice);
            } else {
                return;
            }

            // if knock out happened, end product
            if (ps.KnockOut) {
                if (ps.KnockIn) {
                    ps.status = SnowbowResultStatus.InAndOut;
                    ps.endPrice = uint200(currentPrice);
                    ps.validPeriod = uint32(block.timestamp - product.startTime);
                } else {
                    ps.status = SnowbowResultStatus.OnlyOut;
                    ps.endPrice = uint200(currentPrice);
                    ps.validPeriod = uint32(block.timestamp - product.startTime);
                }

                _endProduct(productAddr);
            }

            // if time is up, end product
            if (block.timestamp - product.startTime > product.period) {
                if (ps.KnockIn) {
                    ps.status = SnowbowResultStatus.OnlyIn;
                } else {
                    ps.status = SnowbowResultStatus.NorInOrOut;
                }

                _endProduct(productAddr);
            }

            emit ProductStatusChange(productAddr, ps.status);

            productResult[productAddr] = ps;
        }
    }

    /**
     * @dev remove product from monitor list
     * @param productAddr product address
     */
    function _endProduct(address productAddr) internal {
        uint256 productIndex = productIndexes[productAddr];
        address lastProduct = monitorProductList[monitorProductList.length - 1];

        // swap current product with last one and pop
        monitorProductList[productIndex] = lastProduct;

        // disable the product index
        productIndexes[productAddr] = type(uint256).max;

        // set the right index to swaped product
        productIndexes[lastProduct] = productIndex;

        monitorProductList.pop();
    }
}
