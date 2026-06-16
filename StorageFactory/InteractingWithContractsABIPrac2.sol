// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;
import {dataStorage} from "StorageFactory/SimpleStorage.sol";
contract BluePrint{
   dataStorage[] public store;

   function createContractsData() public{
    dataStorage newData = new dataStorage();
    store.push(newData);
   }

   function assignnum(uint _Index,int _num) public{
    store[_Index].getNum(_num);
   }

   function checkNum(uint _Index) public view returns(int256){
    return store[_Index].onlyView();
   }

}