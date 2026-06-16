// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Storage{

int256 number;


mapping(string => int) public mapId; // so basically mapping works like this mapping(key => value returned) and here public means mapping accesible from outside the contract and mapId is the name of mapping variable

struct Details{
    int256 id;
    string name;
    int256 age;
}

Details[] public listofPeople;

function addpeople(int _id , string memory _name , int _age) public{
    listofPeople.push(Details(_id, _name , _age));
    mapId[_name] = _id; // "Find the storage slot associated with the text string _name, and place the number _id into it."
    // mapId[_name] is not an array at all. Even though it uses square brackets [ ]—which can look confusing because arrays use them too—this is just the syntax Solidity uses to look up a key inside a mapping.
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