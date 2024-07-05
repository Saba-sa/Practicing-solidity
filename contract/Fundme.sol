// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}
contract Fundme {
    uint256 public minimumUSD=50;
    function fund()public payable {
require(msg.value >= minimumUSD , "value must be atleast 1 eth");
    }
    // function withdraw(){}

    function  getPrice()public view{
        // ABI
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();

    }
    function getVersion()public view returns (uint256){
        AggregatorV3Interface priceFeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }
    // function convertPrice(params) {
    //     code
    // }
}