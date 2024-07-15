// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library Priceconverter{
 function  getPrice()internal  view returns(uint256){
        // ABI
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
AggregatorV3Interface priceFeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 answer,, ,)= priceFeed.latestRoundData();    
        return uint(answer*1e18);
        }

    function getVersion()internal  view returns (uint256){
        AggregatorV3Interface priceFeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }
    function convertPrice(uint256 EthAmount)internal  view returns (uint256) {
        uint256 ethPrice=getPrice();
        uint256 ethAmountinUSD=(ethPrice*EthAmount)/1e18;
        return ethAmountinUSD;
    }
}