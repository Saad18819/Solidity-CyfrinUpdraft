// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "StorageFactory/SimpleStorage.sol";

// lets say if we have multiple contract written in one file and u want some limited contract imports only then this is how u write
// import {dataStorage , dataStorage5} from "StorageFactory/SimpleStorage.sol";

contract storageFactory{

dataStorage public dataStorage2;

function makeContract() public{
    dataStorage2 = new dataStorage();
}


}


