// SPDX-License-Identifier: MIT
pragma solidity 0.8.23;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import {IERC20Metadata} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ISnowbowProduct} from "src/interfaces/ISnowbowProduct.sol";
import {BitMaps} from "@openzeppelin/contracts/utils/structs/BitMaps.sol";
import {IPriceObserver, IPriceObserverDef} from "src/interfaces/IPriceObserver.sol";

contract SnowbowProduct is ISnowbowProduct, IPriceObserverDef {
    using SafeERC20 for IERC20;
    using BitMaps for BitMaps.BitMap;

    uint256 constant PROFIT_BASE = 10000;

    // feeData address on polygon mumbai
    // https://docs.chain.link/data-feeds/price-feeds/addresses?network=polygon&page=1#mumbai-testnet

    // target token address
    address internal _targetToken;
    uint8 _targetDecimal;
    // target token price, in per usd
    uint256 internal _targetInitPrice;
    uint256 internal _targetKnockInPrice;
    uint256 internal _targetKnockOutPrice;

    address internal _usdToken;
    address internal _usdFeeData;
    mapping(address => uint256) internal _boughtAmount;

    uint32 internal _startTime;
    uint32 internal _period;
    uint16 internal _baseProfit; // decimal is 4

    uint256 totalBoughtAmount;

    // wether the user had claimed the reward
    BitMaps.BitMap internal _claimed;

    address internal _priceObserver;

    /**
     * @dev one contract for one target asset, only support WETH/WBTC
     */
    function initialize(ProductInitArgs calldata args) public override {
        _targetToken = args.targetToken;
        _targetInitPrice = args.targetInitPrice;
        _targetKnockInPrice = args.targetKnockInPrice;
        _targetKnockOutPrice = args.targetKnockOutPrice;
        _startTime = uint32(args.startTime);
        _period = uint32(args.period);
        _baseProfit = uint16(args.baseProfit);
        _usdToken = args.usdToken;
        _usdFeeData = args.usdFeeData;

        _targetDecimal = IERC20Metadata(args.targetToken).decimals();

        _priceObserver = args.priceObserver;

        // register product
        IPriceObserver(_priceObserver).registerProduct(
            ProductInfo(
                args.targetToken,
                args.targetInitPrice,
                args.targetKnockInPrice,
                args.targetKnockOutPrice,
                args.startTime,
                args.period,
                args.baseProfit
            )
        );
    }

    /**
     * @dev user buy some share on the snowbow
     * @param amount amount of usd token you want to pay
     */
    function buyShare(uint256 amount) public returns (uint256) {
        if (block.timestamp >= _startTime) {
            revert SnowbowStarted();
        }

        // transfer usd token
        IERC20(_usdToken).safeTransferFrom(msg.sender, address(this), amount);

        // calculate how much dest can be bought
        // and handle decimail at the same time
        uint256 dstAmount = getLatestPrice(_usdFeeData) * amount * 10 ** _targetDecimal
            / (_targetInitPrice * 10 ** IERC20Metadata(_usdToken).decimals());

        _boughtAmount[msg.sender] += dstAmount;
        totalBoughtAmount += dstAmount;

        emit BuyShare(msg.sender, amount, dstAmount);

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

        (IPriceObserver.SnowbowResultStatus status, uint256 validPeriod, uint256 endPrice) =
            IPriceObserver(_priceObserver).getProductResult(address(this));

        uint256 allPeriodRewardUSDAmount =
            _boughtAmount[msg.sender] * _targetInitPrice * (10000 + _baseProfit) / PROFIT_BASE * 10 ** _targetDecimal;

        // judge the condition and give corspoding reward
        if (status == SnowbowResultStatus.NorInOrOut) {
            // if not knock in nor knock out
            // reward all reward
            IERC20(_usdToken).safeTransfer(msg.sender, allPeriodRewardUSDAmount);
        } else if (status == SnowbowResultStatus.InAndOut || status == SnowbowResultStatus.OnlyOut) {
            // if knock in and knock out, or only knock out
            // reward the valid period part of reward
            IERC20(_usdToken).safeTransfer(msg.sender, allPeriodRewardUSDAmount * validPeriod / _period);
        } else if (status == SnowbowResultStatus.OnlyIn) {
            // if knock in but no knock out
            if (endPrice > _targetInitPrice) {
                // if end price larger than init price, user get a part earning
                IERC20(_usdToken).safeTransfer(
                    msg.sender,
                    allPeriodRewardUSDAmount * (_targetKnockOutPrice - endPrice) / _period
                        * (_targetKnockOutPrice - _targetKnockInPrice)
                );
            } else {
                // if end price smaller than init price, user get part loss
                IERC20(_usdToken).safeTransfer(
                    msg.sender,
                    allPeriodRewardUSDAmount
                        - allPeriodRewardUSDAmount * (endPrice - _targetKnockInPrice) / _period
                            * (_targetKnockOutPrice - _targetKnockInPrice)
                );
            }
        }
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
