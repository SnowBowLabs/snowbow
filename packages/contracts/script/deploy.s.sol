// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import {SnowbowProduct} from "src/SnowbowProduct.sol";
import {SnowbowFactory} from "src/SnowbowFactory.sol";
import {PriceObserver} from "src/PriceObserver.sol";
import {USD} from "src/mock/USD.sol";
import {WBTC} from "src/mock/WBTC.sol";
import {AggregatorMock} from "src/mock/Aggregator.sol";
import "src/interfaces/IStructDef.sol";

contract Deploy is Script, IStructDef {
    function deploy() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address owner = vm.addr(deployerPrivateKey);
        vm.startBroadcast(deployerPrivateKey);

        SnowbowProduct snowbowImpl = new SnowbowProduct();
        SnowbowFactory factory = new SnowbowFactory(owner);

        factory.setImplementation(address(snowbowImpl));

        USD usd = new USD();
        WBTC wbtc = new WBTC();

        vm.stopBroadcast();

        deployObserver();

        console2.log("factory: ", address(factory), "\n  snowbow impl: ", address(snowbowImpl));
        console2.log("usd:", address(usd));
        console2.log("wbtc: ", address(wbtc));
    }

    function deployMockPriceFeed() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        // for mock, observe every 5 minutes
        AggregatorMock ag = new AggregatorMock();

        console2.log("aggregator: ", address(ag));

        vm.stopBroadcast();
    }

    function setAnswer() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        AggregatorMock ag = AggregatorMock(0xe44a0B926f6CC5a56af17468F66D84DA0dE413bb);

        ag.setAnswer(4400000000000);

        vm.stopBroadcast();
    }

    function deployObserver() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        // for mock, observe every 5 minutes
        PriceObserver observer = new PriceObserver(300, 1701993600);

        console2.log("observer: ", address(observer));

        vm.stopBroadcast();
    }

    function upgradeProduct() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address owner = vm.addr(deployerPrivateKey);
        vm.startBroadcast(deployerPrivateKey);

        SnowbowProduct snowbowImpl = new SnowbowProduct();
        SnowbowFactory factory = SnowbowFactory(0xbD5a8C111E60867D07D73fcDEd680689D401E2D7);

        factory.setImplementation(address(snowbowImpl));

        vm.stopBroadcast();

        console2.log("factory: ", address(factory), "\n new snowbow impl: ", address(snowbowImpl));
    }

    function createWBTCProduct() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        SnowbowFactory factory = SnowbowFactory(0xbD5a8C111E60867D07D73fcDEd680689D401E2D7);

        // create wbtc product
        address product = factory.createProduct(
            ProductInitArgs(
                0x3d56dC8D257Db1085fD4f47F7fCCeCE279FB330b,
                0xe44a0B926f6CC5a56af17468F66D84DA0dE413bb,
                4400000000000,
                4000000000000,
                4800000000000,
                1702202400,
                900,
                1000,
                0x42EFBA52668d124e8c7427aA7cb2c4Fe7212109A,
                0x572dDec9087154dC5dfBB1546Bb62713147e0Ab0,
                0x74Aa66Ce57E8d6Cea12C71ff146bA9837DddCb8b
            )
        );

        vm.stopBroadcast();

        console2.log("factory: ", address(factory));
        console2.log("wbtc product: ", product);
    }

    function buyWBTCShare() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address owner = vm.addr(deployerPrivateKey);
        vm.startBroadcast(deployerPrivateKey);

        SnowbowProduct product = SnowbowProduct(0x96d7eA9C888f620D3706161441deD64bB5cdd775);
        USD usd = USD(0x42EFBA52668d124e8c7427aA7cb2c4Fe7212109A);

        usd.approve(address(product), UINT256_MAX);
        product.buyShare(10 ether);

        vm.stopBroadcast();
    }
}
