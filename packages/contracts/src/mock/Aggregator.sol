// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV2V3Interface.sol";

interface IAggregatorMock {
    function latestRoundData()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

    function decimals() external view returns (uint8);
}

contract AggregatorMock is IAggregatorMock {
    int256 internal _answer;

    function latestRoundData()
        public
        view
        override
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound)
    {
        answer = _answer;
    }

    function decimals() external view returns (uint8) {
        return 8;
    }

    function setAnswer(uint256 answer) public {
        _answer = int256(answer);
    }
}
