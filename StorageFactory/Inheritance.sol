// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {dataStorage} from "StorageFactory/SimpleStorage.sol";

// contract addFive is dataStorage{} this will give exact same thing as datastorage contract would have given when deployed

contract addFive is dataStorage{
// virtual is used in a parent contract to allow a function to be overridden, while override is used in a child contract to provide a new implementation for that function.
    function getNum(int256 n) public override{
        num = n+5;
    }
  // the dataStorage is the parent(base) contract and this is the child contract and u generally do inheritance when u fuly like the contract just ek do function u want to change
  // here override means jo parent contract me function hai usko change karna so parent contract me u gotta give permission to override it so in parent contracct in that function u weite "virtual" so this gives permission to override a function
  // and u write exact same name of a function and variables
}

