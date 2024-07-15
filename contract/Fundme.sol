// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "./Priceconverter.sol";

contract Fundme {
using Priceconverter for uint256;
    uint256 public minimumUSD=50*1e18;
address[] public funders;
mapping (address=>uint256)public addressToAmountFunded;

  
    function fund()public payable {
require(msg.value.convertPrice()>= minimumUSD , "value must be atleast 1 eth");
funders.push(msg.sender);
    addressToAmountFunded[msg.sender]=msg.value;
    }
function withgraw()public{
    for (uint256 funderindex=0; funderindex<funders.length;funderindex++) 
    {
       address funder=funders[funderindex];
       addressToAmountFunded[funder]=0;
    }
    funders=new address[](0);
    //transfer tokens or coins from this contract to the address that calles the function
//    payable(msg.sender.transfer(address(this).balance));
//send
//    bool sendRequest=payable(msg.sender.send(address(this).balance));
//    require(sendRequest, "send failed");
//call
(bool callSuccess,)=payable(msg.sender).call{value:address(this).balance}("");
   require(callSuccess, "call failed");

}


}