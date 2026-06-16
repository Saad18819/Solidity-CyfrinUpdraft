// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract SimpleStorage{
   
   uint256 public number; // it will make the number variable visible in deployed contract section in deploy and run transaction
 // uint number or "uint internal number"   ..... these both thing are same are they are not visible unless u make it public
   
   function store(uint no) public{
     number = no;

   }
// how it works basically in deployed contrtacts when u select store function and write whatever no(num) thats get updated to no and then to number


// VIEW ONLY FUNCTION

function getnumber() public view returns(uint256){
    return number;
}

// A view function reads data from the contract's history (state variables) but promises never to change or write anything. and u spend 0 gas coz u arent changing anything in the blockchain



// PURE ONLY FUNCTION


function addNumbers(uint256 a, uint256 b) public pure returns (uint256) {
    return a + b; 
}


// A pure function does not read and does not write anything to the contract's history. It relies only on the inputs you pass into it right then and there. its also free when called externally


// When you run a view or pure function, you are essentially asking the blockchain, "Hey, if I look at this data or run this calculation right now, what would the result be?" Because it's just a preview, no data actually moves or changes on the blockchain ledger.


// solidity has same logic for scope that is local and global scope rehte hai iske paas
}

// Visibility 

// In Solidity, functions and variables can have one of these four visibility specifiers:



// public — The Front Yard

// What it means: Anyone can walk up and see it or use it.

// The Analogy: It’s like a bench in your front yard. You can sit on it, your family can sit on it, and strangers walking down the street can sit on it too.





// private — Your Locked Bedroom Diary

// What it means: Only the exact contract it was written in can use it. No one else.

// The Analogy: It’s like a diary locked inside your private bedroom drawer. Only you can read it. Even your own children (derived contracts) aren't allowed to touch it.

// Note: In blockchain, "private" doesn't mean "secret." People looking at the blockchain can still see the diary exists, they just aren't allowed to open or use it in code.





// external — The Drive-Thru Window
// What it means: This is only for functions (actions). It can only be called from outside the house. You cannot easily call it from inside your own code.

// The Analogy: It’s like a fast-food drive-thru window. It is built specifically for outsiders in cars to roll up and use. If you are already inside the kitchen, you don't line up at the drive-thru window to get a burger; you just grab it from the counter.



// internal — The Family Living Room (The Default)
// What it means: Only the contract itself and its "child" contracts (inheritance) can use it.

// The Analogy: It’s like the TV in the family living room. You can use it, and your children who inherit the house can use it. But a stranger walking by on the street cannot walk inside and change the channel.



//If a visibility specifier is not given, it defaults to internal.


