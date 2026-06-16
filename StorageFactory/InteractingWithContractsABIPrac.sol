// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {dataStorage} from "StorageFactory/SimpleStorage.sol";

contract bluePrint{

dataStorage[] public listOfContracts;

function BluePrintNewContracts() public{
    dataStorage newContract = new dataStorage();
    listOfContracts.push(newContract);
}

function InsertData(uint256 _Index , int256 _num) public{
    listOfContracts[_Index].getNum(_num);  
}

function CheckData(uint256 _Index) public view returns(int256){
    return listOfContracts[_Index]. onlyView();
}

}