// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract giveMeFund{

uint256 public constant Minimum_USD = 5 * 1e18;

address[] public UsersAddress;
mapping(address funders => uint256 NetAmountPaid) public AddToAmnt;

function fund() public payable{
    require(AmntInUsd(msg.value)>Minimum_USD , "Work hard and pay me more ETH brooo");
    UsersAddress.push(msg.sender);
    AddToAmnt[msg.sender] += msg.value;

}

function getPrice() public view returns(uint256){

(,int256 price,,,) = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419).latestRoundData();

return uint256(price*1e10);
}

function AmntInUsd(uint256 ethAmount) public view returns(uint256){
    uint256 singleEthPriceInUsd = getPrice();
    uint TotalPriceInUsd = (singleEthPriceInUsd * ethAmount)/1e18;

    return TotalPriceInUsd;

}

function withdraw() public{
    for(uint i = 0; i < UsersAddress.length ; i++){
       address funders = UsersAddress[i];
       AddToAmnt[funders] = 0;
    }

    UsersAddress = new address[](0);
    
}
}

// so basically what we did here in withdray function we basically set the initial amnt in aaray as 0 and jaise hi paise aate jayege voh badhte jayega har arrray me amnt us address pe



/*
Adding UsersAddress = new address[](0); after the for loop means you are completely resetting or emptying the array of funders.

Think of your contract like a physical ledger for a crowdfunding campaign:

The for loop goes through the ledger book and crosses out everyone's balance, writing $0 next to their name.

UsersAddress = new address[](0); takes the entire list of names, throws it in the trash, and replaces it with a brand new, completely blank notebook.

Without this line, if 10 people fund your contract, your UsersAddress array has a length of 10. If you withdraw, their balances drop to 0, but the array still has a length of 10. If those same 10 people or new people fund you again, the array grows to 20, 30, 40... which will eventually cost a massive, unsustainable amount of gas to loop through!

You are completely right about the very first time the contract runs! When you first deploy the contract, the array starts completely empty, and it only fills up as people call the fund() function.

The reason we have to empty it inside the withdraw() function is to handle the second, third, and fourth rounds of funding.

Think of it as a resetting process for a recurring cycle. Let's trace exactly what happens to your contract's storage memory across two rounds of funding to see why this line is a lifesaver.

so basically kya hora u got funds from thrree different wallet address  ab it iwll look something like this = [add1 , add2 , add3] ab inse withdraw karliye amnt so why the fuck abb inko array me rakhege so we just clean it after withdraw and make a new array so ab jo bhi fund dega we will store it in fresh array although previous history delete ho jayegi but blockchain network pe toh haina
 although abhi withdraw ka logiv nhi likha but uske baad ka llikha hai for now

*/
