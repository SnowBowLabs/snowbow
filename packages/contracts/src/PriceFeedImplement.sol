// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV2V3Interface.sol";


contract PriceFeedImplement {

    mapping(string => address) private dataFeedAddresses;
    /**
    * @notice Constructor that initializes the contract with Chainlink data feed addresses.
    */
    constructor() {
        // 使用新地址更新映射
        dataFeedAddresses["BTC/USD"] = 0x007A22900a3B98143368Bd5906f8E17e9867581b;
        dataFeedAddresses["DAI/USD"] = 0x0FCAa9c899EC5A91eBc3D5Dd869De833b06fB046;
        dataFeedAddresses["ETH/USD"] = 0x0715A7794a1dc8e42615F059dD6e406A6594651A;
        dataFeedAddresses["EUR/USD"] = 0x7d7356bF6Ee5CDeC22B216581E48eCC700D0497A;
        dataFeedAddresses["LINK/MATIC"] = 0x12162c3E810393dEC01362aBf156D7ecf6159528;
        dataFeedAddresses["LINK/USD"] = 0x1C2252aeeD50e0c9B64bDfF2735Ee3C932F5C408;
        dataFeedAddresses["MATIC/USD"] = 0xd0D5e3DB44DE05E9F294BB0a3bEEaF030DE24Ada;
        dataFeedAddresses["SAND/USD"] = 0x9dd18534b8f456557d11B9DDB14dA89b2e52e308;
        dataFeedAddresses["SOL/USD"] = 0xEB0fb293f368cE65595BeD03af3D3f27B7f0BD36;
        dataFeedAddresses["USDC/USD"] = 0x572dDec9087154dC5dfBB1546Bb62713147e0Ab0;
        dataFeedAddresses["USDT/USD"] = 0x92C09849638959196E976289418e5973CC96d645;
    }

    /**
    * @notice Retrieves the latest price for a given cryptocurrency pair.
    * @param pair The cryptocurrency pair in string format (e.g., "BTC/USD").
    * @return price The latest price of the given pair.
    * @dev This function queries the Chainlink data feed associated with the given pair.
    *      It reverts if the pair is not found in the mapping.
    */

    function getLatestPrice(string memory pair) public view returns (int) {
        address dataFeedAddress = dataFeedAddresses[pair];
        require(dataFeedAddress != address(0), "Data feed not found for this pair");

        AggregatorV2V3Interface dataFeed = AggregatorV2V3Interface(dataFeedAddress);
        (, int price, , , ) = dataFeed.latestRoundData();
        return price;
    }
}