// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV2V3Interface.sol";
import "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";

import {IHedgeExecutor} from "src/interfaces/IHedgeExecutor.sol";
import {ISnowbowProduct} from "src/interfaces/ISnowbowProduct.sol";

contract HedgeExecutor is IHedgeExecutor, AutomationCompatibleInterface {
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

    function registerProduct() external {
        address productAddr = msg.sender;

        productIndexes[productAddr] = monitorProductList.length;
        monitorProductList.push(productAddr);
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
            _hedge();
        }
    }

    function _hedge() internal {
        for (uint256 i = 0; i < monitorProductList.length; i++) {
            address productAddr = monitorProductList[i];
            ISnowbowProduct p = ISnowbowProduct(productAddr);
            p.hedge();
        }
    }
}
