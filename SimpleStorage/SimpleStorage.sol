// SPDX-License-Identifier: MIT
// It tells anyone reading the code (and the software compiling it) how the code is licensed. MIT is a very popular, permissive open-source license. It essentially means: "Hey, anyone can use, modify, or share this code for free."
// Solidity highly encourages putting this at the top of your files to avoid legal ambiguity about who owns or can use the code.

pragma solidity ^0.8.19; // this is the solidity compiler version we using
// A "pragma" is an instruction to the Solidity compiler (the tool that translates your human-readable code into machine code that the blockchain can understand).

 contract SimpleStorage{
 // basic variable types

 bool hasFavouriteNumber = true;
 uint256 favouriteNumber = 88;
 string favouriteNumberInText = "Eighty-Eight";
 address myAddress = 0xc9DDba2c60cB6fA96e57A713D3d5348224d325C8;  
 int256 favouriteInt = -88;
 bytes32 favouriteBytes32 = "cat";
 uint256 abc; // it sets the value to 0 by default and its just here we are initializing

 }

 // this is the main body of the program and contract keyword is very similar to word class in javscript or java and simplestorage is the name of the class

 // uint means unsigned integer which can store 0 and + whole no (0 to 2^(256)-1)
 // int means signed interger which can store +ve and -ve both ( -2^{255} to 2^{255} -1)
 // ; means end of statement