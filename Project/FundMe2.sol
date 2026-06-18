// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// https://docs.chain.link/data-feeds/using-data-feeds   this is the website we are using to fetch real word price basically we are using onchain to bring in the data on chain
// we can import directly from the github
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// Remix is smart. When it sees @chainlink/contracts, it knows it's an NPM package, looks up Chainlink's public GitHub repository automatically, and grabs the file straight from the internet.




contract FundMe{
   

    
    uint256 public constant MINIMUM_USD = 5 * 1e18;

    /* 
    Using constant here is all about saving gas (which means saving real money on the blockchain).

In Solidity, when you deploy a smart contract, changing or reading data from the blockchain's storage is incredibly expensive. constant completely changes how the variable is stored and accessed.
    
    but once its deployed the value is locked forever
    
    */


    function fund() public payable {
        require(msg.value>= MINIMUM_USD, "You need to spend more ETH!"); // here right now the issue is 5 will be seen as 5 wei by the compiler so u gotta convert that to USD
       // here msg.value will have 18 dec places coz its in wei and 1 ETH = 10^18 wei
       // remember solidity doesnt work with decimals it only works with whole numbers
       // msg.value always measures in wei(18 decimals) 
    }


// This function calls the Chainlink oracle to fetch the current price of 1 ETH in USD.
    function getPrice() public view returns(uint256){
        // to interact with the another contract u need their address and ABI 

        
        // addrress
           AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
           // here the address used is specifically to convert that ETH/USD vala we used




           // ABI
           (,int256 price,,,) = priceFeed.latestRoundData(); // The Commas (,int256 price,,,): latestRoundData() returns 5 different values Because we only care about price, we leave the other variables blank to save gas, keeping only the commas as placeholders.
           // price of eth in USD dega above code
           // but it will return a number like this 2000000 coz solidity doesnt work with decimals (but thw number shld be 2000.00000)


    return uint256(price*1e10); // since price is int256 but msg.value is uint256 so baad me these both thing will be interacting with each ohter isiliye we changed it to uint by typecasting
    }


    function withdraw() public{}
}   



// @chainlink/contracts part is an NPM package name.

// NPM (Node Package Manager) is essentially a massive app store for code. Developers publish blocks of reusable code there so you don't have to reinvent the wheel. Chainlink published their smart contracts there under the name @chainlink/contracts.

// Because NPM packages are built from GitHub repositories. 1. Chainlink developers write their code in a public GitHub repository (a folder of code hosted on the web).
//2. They then publish that exact same folder to NPM so you can easily install it.




// (,int256 price,,,) = priceFeed.latestRoundData();   understanding this accche se

// When you call priceFeed.latestRoundData(), that function doesn't just return the price. It actually returns five separate pieces of data all at once.

// If you look at Chainlink's documentation, the original function looks like this:

/* 
function latestRoundData() external view returns (
    uint80 roundId,
    int256 answer, // This is the price!
    uint256 startedAt,
    uint256 updatedAt,
    uint256 answeredInRound
);


In Solidity, when a function returns multiple values (called a tuple), you have to tell your contract what to do with them.

(uint80 roundId, int256 price, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData();

But here is the catch: Every time you create a variable in Solidity, it uses memory and computation, which costs Gas (real money).

Since our FundMe contract only cares about the price and completely ignores the timestamps and round IDs, we use blank spaces separated by commas. It tells Solidity: "Hey, ignore the 1st, 3rd, 4th, and 5th values. Only save the 2nd value into a variable called price."

Solidity doesn't understand decimals, Chainlink multiplies the real USD price by $10^8$ (8 decimal places) before sending it to your contract.

like for example $2000 = 200000000000 = 2000 * 10^8;


*/