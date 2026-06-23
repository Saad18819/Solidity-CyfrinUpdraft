// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {dataStorage} from "StorageFactory/SimpleStorage.sol";

contract dataBluePrint{

    dataStorage[] public listOfContracts;

function contractsBlueprint() public{
    dataStorage newContracts = new dataStorage();
    listOfContracts.push(newContracts);
}

function insertNum(uint256 _index , int256 _num) public{
    listOfContracts[_index].getNum(_num);
}

function checkNum(uint256 _index) public view returns(int256){
    return  listOfContracts[_index].onlyView();
}

}