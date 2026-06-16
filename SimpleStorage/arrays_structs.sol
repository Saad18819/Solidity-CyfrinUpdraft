// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Storage{

int256 number;

// datatype visibility var_name 
int256[] listOfNumbers; // array inittiate ka method

// A struct in Solidity is a custom, user-defined data type that allows you to group several related variables together under a single name.

struct Details{
    int256 num;
    string name;

}


// Details public person1 = Details({ num:7 , name:"Saad"});  or like this Details(7,"Saad");

// but ab bahot jyaada log hai toh uppar vala method is quite tedious so we use array to make it simpler

// array bhi do types 1) dynamic array.... Person[] when u do not metnion size of the array then its flexible ... 2)static array....Person[3] here the size is fixed it can only go upto 3 so its a static array

Details[] public listofPeople; // starts with 0 index and in deploy in listofpeople i have to just write index to get the result 
// above the name of the array is listofPeople which is telling that it holds data type of Details struct

function GetNumber(int256 n) public{
number = n;

}

function View() public view returns(int256){
    return number;
}

function Pure(int256 a , int256 b ) public pure returns(int256){
    return a+b;
}

function addPerson(int256 _num , string memory _name) public{
listofPeople.push(Details(_num , _name));

}

// the array will look something like this [{struct 1},{struct 2},....]



}

