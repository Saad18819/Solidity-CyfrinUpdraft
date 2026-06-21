// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;



contract FallbackExample{

uint256 public result;

receive() external payable{
result = 1;
}

fallback() external payable{
    result = 2;
}

// so basically in low level interaction if i write something in calldata(random hexadecimal thing) we will call the fallback function and if we do not write anything then receive function will be called


}


// what happens if someone send ETH without calling any function

// we have 2 special functions such as receive() and fallback() function 

// a contract can have at most one receive function declared using receive external payable{....} without function keyword and this function cannot have arguments cannot return anything and must have external visibility and shld be payable



/*
Normally, if you want a contract to do something, you call a specific function (like increment() or mint()).

But what if someone just sends straight Ethereum to your contract address without calling any function?

Your contract needs a way to say, "Hey, someone just dumped Ether on me! What should I do?" That is what receive() is for. It is a special, built-in Solidity function that triggered automatically when:

Someone sends Ether to the contract.

They do not specify any function to call (the transaction data field is completely empty which is here calldata in low level interaction while testing here )






In Remix, when you want to call a function, you click its orange or blue button. But to simulate someone just sending raw Ether to the contract without clicking a function, you have to use the Low-Level Interaction section at the very bottom of the deployed contract panel.

By leaving the Calldata field blank, putting 1 Wei or 1 Ether in the Value field, and hitting Transact, Patrick was simulating a user doing a direct wallet-to-contract transfer (like sending ETH from MetaMask directly to the contract address).

Because the transaction had no data (no function name), the EVM automatically routed the transaction into receive(). Inside receive(), Patrick wrote result = 1;. That's why the value changed!






Solidity decides between receive() and fallback() using this simple logic tree:

Is Ether sent in the transaction?
                     /          \
                   Yes           No
                   /               \
        Is Calldata empty?      Goes to fallback()
             /       \
           Yes        No
           /            \
    receive()          fallback()





    receive(): Triggered when Ether is sent and Calldata is empty.

    receive(): Triggered when Ether is sent and Calldata is empty.








The fallback() function is the ultimate safety net of a Solidity smart contract.

Think of it as the default case in a switch statement, or a "catch-all" router. If someone interacts with your contract and the Ethereum Virtual Machine (EVM) looks at the request and says, "I have absolutely no idea what function you are trying to call," it immediately hands the transaction over to fallback().


There are two main scenarios that trigger the fallback function:

The Missing Function Scenario: A user or another contract tries to call a function name that does not exist in your contract code (e.g., calling transferTokens() on a contract that only has a mint() function).

The "Ether with Data" Scenario: Someone sends Ether directly to your contract address, but they also included extra data (msg.data) in the transaction payload, and that data doesn't match a valid function signature.





Just like receive(), the fallback() function has a very specific, strict syntax. It does not use the function keyword, it must be marked external, and it can optionally be marked payable if you want it to be able to accept Ether.


To put it perfectly:No Data (msg.data is empty)It triggers receive().
With Data (msg.data has content). It triggers fallback().
There is just one tiny catch to add to your mental model: What happens if a contract receives a transaction with no data, but the receive() function wasn't defined? In that case, it will drop down and look for a fallback() function instead. If neither exists, the transaction reverts.


*/