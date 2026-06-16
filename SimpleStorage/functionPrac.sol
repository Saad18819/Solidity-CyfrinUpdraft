// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Storage{

int256 number;

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