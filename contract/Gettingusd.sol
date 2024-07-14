// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
contract Priceconversion{
    AggregatorV3Interface internal Pricefeed;
constructor() {
    Pricefeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
}
function getLatesPrice()public view returns (int){
    (,int price,,,)=Pricefeed.latestRoundData();
    return price;
}    
}
