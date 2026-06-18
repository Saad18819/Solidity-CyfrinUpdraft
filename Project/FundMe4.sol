// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract giveMeFund{

uint256 public constant Minimum_USD = 5 * 1e18;

// so basically isme what we did ki we made an array jisme jisne bhi transaction kara unke address store ho jaye and then we also mapped that address with kitne amnt spend kara unhone

address[] public funders; /// address is a data type
mapping (address funder => uint256 amountFunded) public addressToAmountFunded;
/* 

Starting in Solidity 0.8.18, you can now add named parameters (funder and amountFunded) inside the mapping.

Why do it? It is purely for readability and documentation. It doesn't change how the code works under the hood at all. It just makes it instantly clear to anyone reading your code that the key represents the funder's address and the value represents the amount they funded.




*/

function fund() public payable{
    require(AmntInUsd(msg.value)>Minimum_USD , "Work hard and pay me more ETH brooo");
    funders.push(msg.sender);
    addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

}

/*
msg.sender: This is a global variable that automatically represents the wallet address of whoever is currently calling the function.




Why don't we store the USD amount in adddressToAmountFunded? Because the price of ETH is constantly fluctuating second by second.

Imagine if someone funds your contract with exactly 1 ETH today when ETH is worth $3,000. If you store 3000 in your mapping, and tomorrow the price of ETH jumps to $4,000, your ledger is now completely wrong. The contract actually holds 1 ETH, but your ledger says they only gave you $3,000 worth.











 */

function getPrice() public view returns(uint256){

(,int256 price,,,) = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419).latestRoundData();

return uint256(price*1e10);
}

function AmntInUsd(uint256 ethAmount) public view returns(uint256){
    uint256 singleEthPriceInUsd = getPrice();
    uint TotalPriceInUsd = (singleEthPriceInUsd * ethAmount)/1e18;

    return TotalPriceInUsd;

}

}