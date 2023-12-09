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
                    100 ether,
                    80 ether,
                    120 ether,
                    1 days,
                    30 days,
                    1000,
                    _usd,
                    address(_usdFeeData),
                    address(_observer)
                )
            )
        );
        // set up
        _usdFeeData.setAnswer(1 ether);
        _wbtcFeeData.setAnswer(100 ether);
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
