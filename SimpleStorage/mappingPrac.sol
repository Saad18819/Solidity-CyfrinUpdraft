// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Storage{

int256 number;

struct Details{
    int256 id;
    string name;
    int256 age;
}

Details[] public listofPeople;

mapping(string => int) public nameAgemapping;

function addpeople(int _id , string memory _name , int _age) public{
    listofPeople.push(Details(_id, _name , _age));
    nameAgemapping[_name] = _age;
}


function GetNumber(int256 n) public{
number = n;

}

function View() public view returns(int256){
    return number;
}

function Pure(int256 a , int256 b ) public pure returns(int256){
    return a+b;
}





}