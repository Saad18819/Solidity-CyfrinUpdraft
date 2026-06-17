// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// This is the actual contract sitting on the blockchain
contract RealCalculatorMachine {
    
    // Here is the REAL execution code
    function addNumbers(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b; 
    }
}

//Imagine someone else already wrote this contract, compiled it, and deployed it to the blockchain at the address 0x123.... It has the real logic inside it.