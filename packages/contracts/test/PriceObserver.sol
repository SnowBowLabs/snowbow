// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {Test} from "forge-std/Test.sol";
import "src/PriceObserver.sol";
import "src/interfaces/IPriceObserver.sol";

contract PriceObserverTest is Test, IPriceObserverDef {
    PriceObserver priceObserver;

    function setUp() public {
        priceObserver = new PriceObserver(15, block.timestamp);
        // 初始化任何必要的状态
    }

    function testRegisterProduct() public {
        // 构造ProductInfo
        IPriceObserver.ProductInfo memory productInfo = ProductInfo({
            targetToken: address(0x007A22900a3B98143368Bd5906f8E17e9867581b),
            targetInitPrice: 100,
            targetKnockInPrice: 150,
            targetKnockOutPrice: 200,
            startTime: block.timestamp,
            period: 365 days,
            baseProfit: 1000
        });

        address productAddr = address(0x123);
        vm.prank(productAddr);
        priceObserver.registerProduct(productInfo);
    }

    function testGetProductResult() public {
        address productAddr = address(0x123);

        (IPriceObserver.SnowbowResultStatus status, uint256 period, uint256 endPrice) =
            priceObserver.getProductResult(productAddr);

        assertTrue(uint256(status) >= 0, "Status is not valid.");
        assertEq(period, period, "Period does not match.");
        assertTrue(endPrice >= 0, "End price is not valid.");
    }

    function testTimeBasedLogging() public {
        IPriceObserver.ProductInfo memory productInfo = ProductInfo({
            targetToken: address(0x007A22900a3B98143368Bd5906f8E17e9867581b),
            targetInitPrice: 100,
            targetKnockInPrice: 150,
            targetKnockOutPrice: 200,
            startTime: block.timestamp,
            period: 365 days,
            baseProfit: 1000
        });

        address productAddr = address(0x123);

        vm.prank(productAddr);
        priceObserver.registerProduct(productInfo);

        uint256 startTime = block.timestamp;
        uint256 interval = 5 minutes;
        uint256 endTime = startTime + 1 hours; // 测试持续时间

        while (block.timestamp < endTime) {
            // 模拟5分钟间隔
            vm.warp(block.timestamp + interval);
            priceObserver.performUpkeep(new bytes(0));

            // 确保循环不会永远执行
            if (block.timestamp + interval > endTime) {
                break;
            }
        }

        (IPriceObserver.SnowbowResultStatus status, uint256 period, uint256 endPrice) =
            priceObserver.getProductResult(productAddr);
        emit log("the value of period");
        emit log_uint(period);
        emit log("the value of endPrice");
        emit log_uint(endPrice);

        assertTrue(uint256(status) >= 0, "Status is not valid.");
        assertEq(period, period, "Period does not match.");
        assertTrue(endPrice >= 0, "End price is not valid.");
    }
}
