// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {Test} from "forge-std/Test.sol";
import {PriceObserver} from "src/PriceObserver.sol";
import {SnowbowFactory} from "src/SnowbowFactory.sol";
import {SnowbowProduct} from "src/SnowbowProduct.sol";
import {USD} from "src/mock/USD.sol";
import {WBTC} from "src/mock/WBTC.sol";
import {AggregatorMock} from "src/mock/Aggregator.sol";

contract BaseTest is Test {
    SnowbowFactory internal _factory;
    address internal _impl;
    PriceObserver internal _observer;

    address internal _admin = makeAddr("admin");
    address internal _user = makeAddr("user");
    address internal _wbtc = address(new WBTC());
    address internal _usd = address(new USD());
    AggregatorMock internal _wbtcFeeData = new AggregatorMock();
    AggregatorMock internal _usdFeeData = new AggregatorMock();

    function setUp() public virtual {
        _factory = new SnowbowFactory(_admin);
        _impl = address(new SnowbowProduct());
        // observe every day, observe on utc+0
        _observer = new PriceObserver(1 days, 0);

        // set implementation
        vm.prank(_admin);
        _factory.setImplementation(_impl);
    }
}
