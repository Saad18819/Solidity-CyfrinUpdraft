// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Storage{

int256 number; // storage location pe this is stored

struct Details{
    int256 id;
    string name;
    int256 age;
}

Details[] public listofPeople;

function addpeople(int _id , string memory _name , int _age) public{
_name = "saad";  // this is working coz string ki location is memory and its mutable and if u save string calldata _name this would have given error coz its immutable
// here no matter what name u insert saad will override everyone 
    listofPeople.push(Details(_id, _name , _age));
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