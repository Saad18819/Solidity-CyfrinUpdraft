// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 1. THE INTERFACE: Just a name tag so your code compiles.
// Notice there are NO curly braces {} with code in interface function. It ends in a semicolon.
interface ICalculator {
    function addNumbers(uint256 a, uint256 b) external pure returns (uint256);// function name must be same as it is as it is in that contract

// Solidity strictly enforces that all functions inside an interface must be marked as external. If you try to use public, internal, or private, the compiler will throw an error and refuse to build.
// The definition of external: In Solidity, external means the function can only be called from outside the contract it lives in.


}

// 2. YOUR CONTRACT
contract MyDeFiApp {

    function runMyMath() public pure returns (uint256) {
        // The real machine's address on the blockchain
        address machineAddress = 0x1234567890123456789012345678901234567890; 

        // 3. THE EXECUTION:
        // We wrap the address inside the interface template.
        // This tells Solidity: "Go to machineAddress, look for a function 
        // that matches the 'addNumbers' blueprint, and run it."
        uint256 result = ICalculator(machineAddress).addNumbers(5, 10);

        return result; // Returns 15
    }
}


// EXPLANATION

// interfacemachine.sol: A contract that actually does math.
// interface.sol: A contract that wants to use that machine, utilizing an interface to do it.


// in interface.sol you are writing your contract. You want to use that RealCalculatorMachine from interfacemachine.sol, but you don't want to copy-paste its entire code.



// although when u understand it import and interfce works exactly the smae just the difference is in interface u dont need that filet o exist on  our computer u can directly fetch their data 