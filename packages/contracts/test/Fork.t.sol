// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {Test} from "forge-std/Test.sol";
import {PriceObserver} from "src/PriceObserver.sol";
import {SnowbowFactory} from "src/SnowbowFactory.sol";
import {SnowbowProduct} from "src/SnowbowProduct.sol";
import {USD} from "src/mock/USD.sol";
import {WBTC} from "src/mock/WBTC.sol";
import {AggregatorMock} from "src/mock/Aggregator.sol";

contract ForkTest is Test {
    function setUp() public {}

    function testForkClaimReward() public {
        vm.createSelectFork("https://polygon-mumbai-bor.publicnode.com");
        vm.rollFork(43405040);

        SnowbowProduct p = SnowbowProduct(0xADE65B9A96Eca24a7db4a642B3FDCBFC96C324dC);

        deployCodeTo("SnowbowProduct.sol", new bytes(0), address(p));

        vm.prank(0x736e19e3512303b8cDB67A7d61360392DB3d22fc);

        p.claimReward();
    }
}
