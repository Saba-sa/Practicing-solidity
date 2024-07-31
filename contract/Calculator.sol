// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./Stringcomparson.sol";

contract Calculator{
uint256 public weiValue;
uint256 public gweiValue;
uint256 public ethValue;
uint256 public usd;
using Stringcomparson for string; 

function calculate(uint val,string memory operation)public{
    if(Stringcomparson.Comparesion(operation,"smallest")){
        gweiValue = val / 1e9;
            ethValue = val / 1e18;
            weiValue = val;
    }
    else if(Stringcomparson.Comparesion(operation,"smaller")){
weiValue = val * 1e9;
            ethValue = val / 1e9;
            gweiValue = val;
    }
    else{
        weiValue=val*1e18;
        gweiValue=val*1e9;
        ethValue=val;
    }
}

}