// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Practice2{
    int256 public num;

    struct dataSet{
      string name;
      uint age;
    }

    mapping(string => uint256) public nameToAge;

    dataSet[] public listOfDataSet;

    function setNum(int256 _num) public{
        num = _num;
    }


  function addDataSet(string memory _name , uint _age) public{
    listOfDataSet.push(dataSet(_name,_age));
   nameToAge[_name] = _age;
  }













    function viewNum() public view returns(int256){
        return num;
    }

    function addNum(int a , int b) public pure returns(int256){
        return a+b;
    }


}