// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {BaseTest} from "./Base.t.sol";
import {IStructDef} from "src/interfaces/IStructDef.sol";
import {SnowbowProduct} from "src/SnowbowProduct.sol";
import {ISnowbowProductDef} from "src/interfaces/ISnowbowProduct.sol";

import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";
import "forge-std/console2.sol";

contract MainProgressTest is BaseTest, IStructDef, ISnowbowProductDef {
    SnowbowProduct internal _product;

    function setUp() public override {
        super.setUp();

        // create product
        vm.prank(_admin);
        _product = SnowbowProduct(
            _factory.createProduct(
                ProductInitArgs(
                    _wbtc,
                    address(_wbtcFeeData),
                    100 * 10e8,
                    80 * 10e8,
                    120 * 10e8,
                    1 days,
                    30 days,
                    1000,
                    _usd,
                    address(_usdFeeData),
                    address(_observer)
                )
            )
        );
        // set up price oracle
        // since decimal is 8
        _usdFeeData.setAnswer(1 * 10e8);
        _wbtcFeeData.setAnswer(100 * 10e8);
    }

    function testBuyShare() public {
        deal(_usd, _user, UINT256_MAX);

        vm.startPrank(_user);
        IERC20(_usd).approve(address(_product), UINT256_MAX);

        vm.expectEmit(true, true, true, true);
        emit BuyShare(_user, 1000, 10);

        _product.buyShare(1000);
    }
}
