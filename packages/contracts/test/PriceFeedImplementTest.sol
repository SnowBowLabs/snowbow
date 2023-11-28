// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "ds-test/test.sol";

import "../src/PriceFeedImplement.sol";

contract PriceFeedImplementTest is DSTest {
    PriceFeedImplement priceFeed;
    string constant BTC_USD = "BTC/USD";

    address private constant targetToken = address(1);
    uint256 private constant targetInitPrice = 100;
    uint256 private constant targetKnockInPrice = 150;
    uint256 private constant targetKnockOutPrice = 200;
    uint256 private constant startTime = 1;
    uint256 private constant period = 86400; // 1 day
    uint256 private constant baseProfit = 10;
    address private constant usdToken = address(2);

    // 在每个测试前运行
    function setUp() public {
        priceFeed = new PriceFeedImplement();
    }

    // 测试价格获取函数
    function testGetLatestPrice() public {
        // 假设价格应该是非零的
        int price = priceFeed.getLatestPrice(BTC_USD);
        assertTrue(price != 0);
    }


    function testStoreAndRetrieveTokenInfo() public {
        // 存储信息
        priceFeed.storeTokenInfo(targetToken, targetInitPrice, targetKnockInPrice, targetKnockOutPrice, startTime, period, baseProfit, usdToken);

        // 检索信息
        PriceFeedImplement.TokenInfo memory info = priceFeed.getTokenInfo(targetToken);

        // 断言
        assertEq(info.targetInitPrice, targetInitPrice);
        assertEq(info.targetKnockInPrice, targetKnockInPrice);
        assertEq(info.targetKnockOutPrice, targetKnockOutPrice);
        assertEq(info.startTime, startTime);
        assertEq(info.period, period);
        assertEq(info.baseProfit, baseProfit);
        assertEq(info.usdToken, usdToken);
    }

    function testFailGetTokenInfoForNonexistentToken() public {
        // 尝试检索不存在的token信息，应该失败
        priceFeed.getTokenInfo(address(0));
    }

}