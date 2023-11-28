// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "ds-test/test.sol";

import "../src/PriceFeedImplement.sol";

contract PriceFeedImplementTest is DSTest {
    PriceFeedImplement priceFeed;
    string constant BTC_USD = "BTC/USD";

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

}