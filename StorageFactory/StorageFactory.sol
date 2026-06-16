// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


// METHOD TO LINK UP CONTRACTS and making address for the other contract from the previous contract by linking them up

// 1st CONTRACT
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


function getNum(int256 n) public{
    num = n;
}

function onlyView() public view returns(int256){
    return num;
}

function onlyPure(int a , int b) public pure returns(int256){
    return a + b;
}



}



// 2nd CONTRACT

// basically what happened here u are making a storageFactory contract so u are basically kinda here rn copying the above contract info with new address so its new contract only coz diff addresss

contract storageFactory{
// format is (data type visibility variable_name)
dataStorage public dataStorage2; // basically this creates a variable dataStorage2 variable which stores dataStorage contract info qwith his own new address
// Whenever you declare a state variable as public, Solidity automatically does some magic behind the scenes: it creates a hidden "getter" function for that variable.basically it creates a blue button for it in deployment


function createSimpleStorageContract() public{
dataStorage2 = new dataStorage(); // here new words tells that take the data from dataStorage contract and store in dataStorage2 and it will have different address
// here new word tells It tells the compiler that a new contract instance is intended to be deployed after compilation.
// It does not copy all the actual storage data into the factory. Instead, your factory uses that dataStorage template (or blueprint) to spawn a brand-new, empty contract out into the blockchain world, and then it just remembers the address of where it put it.so basically new addres with a template we get or u can say at that address we got a template

}

}

// what does dataStorage public dataStorage2 means

// dataStorage (The Type):
// In regular programming, you might declare a variable as an int, string, or bool. In Solidity, a contract name is also a data type which is a custom data type. By writing dataStorage, you are telling the blockchain: "This variable is only allowed to hold the address of a contract that fits the dataStorage blueprint." It's a safety guard so you don't accidentally store a wallet address or a completely different contract type here.


// public (The Visibility):
// As we discussed earlier, this tells Solidity to automatically make that blue button in Remix. It allows anyone outside this contract to read and see what address is currently stored inside this variable.


// dataStorage2 (The Name):
// This is simply the custom name you chose for this specific slot (like naming a variable x or myTotal).