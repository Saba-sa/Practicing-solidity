 // SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

library Stringcomparson {
function Comparesion(string memory operation,string memory val)public pure returns(bool){

 bytes32 operationHash = keccak256(abi.encodePacked(operation));
bytes32 valHash = keccak256(abi.encodePacked(val));
return operationHash == valHash;
}
}