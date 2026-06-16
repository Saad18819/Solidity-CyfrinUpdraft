// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract dataStorage{

int256 public num; // if u dont write public here u wont be able to see it in deploy and run transactions coz its internal by default then

struct Info{
    int age;
    string name;
    string degree;
}

Info[] public infoList; 

mapping(string => string) public nameToDegree;

function addDetails(int _age , string memory _name , string memory _degree) public{
infoList.push(Info(_age ,_name ,_degree));
nameToDegree[_name] = _degree;
}


function getNum(int256 n) public virtual{
    num = n;
}

function onlyView() public view returns(int256){
    return num;
}

function onlyPure(int a , int b) public pure returns(int256){
    return a + b;
}



}