// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {dataStorage} from "StorageFactory/SimpleStorage.sol"; // u imported that blueprint from that file 

contract StorageFactory{

dataStorage[] public listOfContracts;  // listofContracts is a variable with data type dataStorage[] so basically an array jisme andar ka item must be similar to dataStorage

function newContracts() public{
    dataStorage VariableContract = new dataStorage(); // ab array me har ek ghar ko blueprint kaise dena voh likha here dataStorage is a data type and Variabelcontract is the variable name jisko blueprint milega
    listOfContracts.push(VariableContract); // and then har ek ghar banne ke baad apan apni array me add karre
}


// in order to intersct with contract u need two things
// address
// ABI-Application Binary interface (it will tell our code how u can interact with another contract) basically jo button deployed karne ke baad dikhte its just becoz complier sees the abi and vha se use pata chalta kitne buttons daalna hai
// explanation neeche hai code ke above vali cheez ka
function newContractsDataStore(uint256 _simpleStorageIndex , int256 num) public{
    listOfContracts[_simpleStorageIndex].getNum(num);
    // // Because an int256 could theoretically hold a negative number, Solidity gets scared and throws an error to protect your contract from breaking. It demands that all array indexes be a uint256
}

// listOfContracts is an array that stores deployed contract instances. When you pass _simpleStorageIndex, you are grabbing a specific contract from that list. Solidity looks up that item and says: "Okay, I found it. The blockchain address for this contract is 0xabc123..." #### 2. The ABI (What buttons does it have?)
// Because listOfContracts was defined using the contract's type (e.g., dataStorage[] listOfContracts), the compiler already has the ABI built into its memory. It knows exactly what "buttons" that contract has.
// When you type .getNum(num), the compiler checks the ABI to make sure a button named getNum actually exists and that it accepts an int256 variable. If it matches, the compiler packages your num variable into data the other contract can understand.

// ab above code me jo blueprint ban gaye usme simplestorage se num ko value dene ka method hai by using getNum function from that file ka function hai

function check(uint _simpleStorageIndex) public view returns(int256){
return listOfContracts[_simpleStorageIndex].onlyView();
}

// just to review ki jo number assign kara vhi mila ya nhi

}

// what actually happened ki SimpleStorage.sol file hai voh basically blueprint hai and then yaha uppar what we did vhi blueprint use karke multiple same contract banaye and then uske baad har contract me ya har address pe ek number diya so basically u are linking up multiple contract in short

