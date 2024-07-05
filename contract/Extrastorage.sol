// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import  "./Simplesstorage.sol";
contract ExtendedSimpleStorage is SimpleStorage{
    function store(uint256 _favoriteNumber) public override  {
        favoriteNumber = _favoriteNumber+5;
    }
    
}