// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CommitmentContract {
 
     function uintToString(uint256 _value) internal pure returns (string memory) {
        if (_value == 0) {
            return "0";
        }
        uint256 tempValue = _value;
        uint256 digits;
        while (tempValue != 0) {
            digits++;
            tempValue /= 10;
        }
        bytes memory buffer = new bytes(digits);
        uint256 index = digits - 1;
        tempValue = _value;
        while (tempValue != 0) {
            buffer[index--] = bytes1(uint8(48 + tempValue % 10));
            tempValue /= 10;
        }
        return string(buffer);
    }

     function calculateHash(uint256 _cnic, string memory _randomNo) public pure returns (bytes32) {
        string memory cnicString = uintToString(_cnic);
        string memory concatenated = string(abi.encodePacked(cnicString, _randomNo));
        return (keccak256(abi.encodePacked(concatenated)));
    }
}
