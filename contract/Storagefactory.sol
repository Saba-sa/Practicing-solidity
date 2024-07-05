// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./Simplesstorage.sol";

contract Storagefactory {

SimpleStorage[] public simpleStorageArray;

    function createSimplestorage()public{
SimpleStorage simpleStorage =new SimpleStorage();
simpleStorageArray.push(simpleStorage);
    }

    function sinteract(uint256 _simpleStorageindex)public{
        simpleStorageArray[_simpleStorageindex].store(4);
    }

     function sfget(uint256 _simpleStorageNumber)public view returns (uint256){
       return simpleStorageArray[_simpleStorageNumber].retrieve();
    }
}