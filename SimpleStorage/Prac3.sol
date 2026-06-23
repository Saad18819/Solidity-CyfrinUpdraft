// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract solidityPrac3{

uint256 public no;


struct info{
    string name;
    string martialStatus;
}

info[] public peopleInfo;

mapping(string _name => string _martialStatus) public nameToMartStatus;


function addInfoOfPeople(string memory _name , string memory _martialStatus) public{
peopleInfo.push(info(_name , _martialStatus));
nameToMartStatus[_name] = _martialStatus;

}



function getNum(uint256 num) public{
    no = num;
}

function checkNum() public view returns(uint256){
    return no;
}

function sumOfNum(uint256 a , uint256 b) public pure returns(uint256){
    return a +b;
}






}