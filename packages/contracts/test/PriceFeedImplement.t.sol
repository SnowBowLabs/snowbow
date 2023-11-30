// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "ds-test/test.sol";
import "../src/PriceFeedImplement.sol";
import "../src/interfaces/IPriceObserver.sol";

contract PriceFeedImplementTest is DSTest {
    PriceFeedImplement priceFeed;

    function setUp() public {
        priceFeed = new PriceFeedImplement();
        // 初始化任何必要的状态
    }

    function testRegisterProduct() public {
        // 构造ProductInfo
        IPriceObserver.ProductInfo memory productInfo = IPriceObserver.ProductInfo({
            targetInitPrice: 100,
            targetKnockInPrice: 150,
            targetKnockOutPrice: 200,
            startTime: block.timestamp,
            period: 365 days,
            baseProfit: 1000,
            usdToken: address(0x007A22900a3B98143368Bd5906f8E17e9867581b)
        });

        address productAddr = address(0x123);

        priceFeed.registerProduct(productAddr, productInfo);

    }

    function testGetProductResult() public {
        address productAddr = address(0x123);

        (IPriceObserver.SnowbowResultStatus status, 
        uint256 period, 
        uint256 endPrice) = priceFeed.getProductResult(productAddr);


        assertTrue(uint(status) >= 0, "Status is not valid.");
        assertEq(period, period, "Period does not match.");
        assertTrue(endPrice >= 0, "End price is not valid.");
    }
}
