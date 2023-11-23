// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract SnowbowSeller {
    error InvalidTokenParams();

    // feeData address on polygon mumbai
    // https://docs.chain.link/data-feeds/price-feeds/addresses?network=polygon&page=1#mumbai-testnet

    // address => feeData address
    mapping(address => address) internal _supportInvestToken;

    address internal _targetToken;
    address internal _targetPriceFeed;
    mapping(address => uint256) internal _boughtAmount;

    uint256 totalBoughtAmount;

    /**
     * @dev one contract for one target asset, only support WETH/WBTC
     */
    constructor(address targetToken, address targetPriceFeed) {
        _targetToken = targetToken;
        _targetPriceFeed = targetPriceFeed;
    }

    /**
     * @dev user buy some share on the snowbow
     * @dev only support buy with ETH/USDC/USDT/DAI
     */

    function buyShare(address putToToken, uint256 amount) public payable returns (uint256) {
        if (_supportInvestToken[putToToken] == address(0)) {
            revert InvalidTokenParams();
        }

        // calculate how much dest can be bought
        // and handle decimail at the same time
        uint256 dstAmount = getLatestPrice(_supportInvestToken[putToToken]) * amount
            * IERC20Metadata(_targetToken).decimals() / getLatestPrice(_targetPriceFeed)
            * IERC20Metadata(putToToken).decimals();

        _boughtAmount[msg.sender] += dstAmount;
        totalBoughtAmount += dstAmount;

        return dstAmount;
    }

    /**
     * @notice Returns the latest price
     *
     * @return latest price
     */
    function getLatestPrice(address priceFeed) public view returns (uint256) {
        (
            ,
            /* uint80 roundID */
            int256 price,
            ,
            ,
        ) = /* uint256 startedAt */
        /* uint256 timeStamp */
        /* uint80 answeredInRound */
         AggregatorV3Interface(priceFeed).latestRoundData();

        // TODO: what about when price less than 0
        return uint256(price);
    }
}
