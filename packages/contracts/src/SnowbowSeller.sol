// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ISnowbowSeller} from "src/interfaces/ISnowbowSeller.sol";
import {BitMaps} from "@openzeppelin/contracts/utils/structs/BitMaps.sol";

contract SnowbowSeller is ISnowbowSeller {
    using SafeERC20 for IERC20;
    using BitMaps for BitMaps.BitMap;

    uint256 constant PROFIT_BASE = 10000;

    // feeData address on polygon mumbai
    // https://docs.chain.link/data-feeds/price-feeds/addresses?network=polygon&page=1#mumbai-testnet

    // address => feeData address
    mapping(address => address) internal _supportInvestToken;

    // target token address
    address internal _targetToken;
    uint8 _targetDecimal;
    // target token price, in per usd
    uint256 internal _targetInitPrice;

    address internal _usdToken;
    mapping(address => uint256) internal _boughtAmount;

    uint32 internal _startTime;
    uint32 internal _period;
    uint16 internal _baseProfit; // decimal is 4

    uint256 totalBoughtAmount;

    // wether the user had claimed the reward
    BitMaps.BitMap internal _claimed;

    /**
     * @dev one contract for one target asset, only support WETH/WBTC
     */
    constructor(
        address targetToken,
        uint256 targetInitPrice,
        uint256 startTime,
        uint256 period,
        uint256 baseProfit,
        address usdToken
    ) {
        _targetToken = targetToken;
        _targetInitPrice = targetInitPrice;
        _startTime = uint32(startTime);
        _period = uint32(period);
        _baseProfit = uint16(baseProfit);
        _usdToken = usdToken;

        _targetDecimal = IERC20Metadata(targetToken).decimals();
    }

    /**
     * @dev user buy some share on the snowbow
     * @dev only support buy with ETH/USDC/USDT/DAI
     */

    function buyShare(address putToToken, uint256 amount) public returns (uint256) {
        if (block.timestamp >= _startTime) {
            revert SnowbowStarted();
        }

        if (_supportInvestToken[putToToken] == address(0)) {
            revert InvalidTokenParams();
        }

        // transfer token
        IERC20(putToToken).safeTransferFrom(msg.sender, address(this), amount);

        // calculate how much dest can be bought
        // and handle decimail at the same time
        uint256 dstAmount = getLatestPrice(_supportInvestToken[putToToken]) * amount * 10 ** _targetDecimal
            / _targetInitPrice * IERC20Metadata(putToToken).decimals();

        _boughtAmount[msg.sender] += dstAmount;
        totalBoughtAmount += dstAmount;

        return dstAmount;
    }

    function claimReward() public {
        if (block.timestamp < _startTime + _period) {
            revert SnowbowNotEnded();
        }

        if (_claimed.get(uint160(msg.sender))) {
            revert Claimed();
        }

        _claimed.set(uint160(msg.sender));

        // judge the condition and give corspoding reward
        // if not knock in nor knock out
        uint256 rewardUSDAmount =
            _boughtAmount[msg.sender] * _targetInitPrice * (10000 + _baseProfit) / PROFIT_BASE * 10 ** _targetDecimal;

        IERC20(_usdToken).safeTransfer(msg.sender, rewardUSDAmount);
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

        // ignore when price is less than 0
        return uint256(price);
    }
}
