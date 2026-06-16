// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {dataStorage} from "StorageFactory/SimpleStorage.sol";

contract Addfive is dataStorage{
function getNum(int256 n) public override{
    num = n +5;
}

}