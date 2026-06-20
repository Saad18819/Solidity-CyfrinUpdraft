// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// we will learn abt constant & immutability this keywords saves up a lot of gas becoz instead os toring these variables inside storage slot we directly store them inside the bytecode of the contract


contract giveMeFund{

    // when constant used : 348 gas (Cost only applies when called by a contract)

    // without constant : 	2447 gas (Cost only applies when called by a contract)

uint256 public constant MINIMUM_USD = 5 * 1e18;

// when u want some vairable to remain fix all the time then its better to use constant keyword in front of them as then that variable no longer takes the storage
// For state variables/global  marked with the constant keyword (whose values are fixed at compile-time), use UPPER_CASE_WITH_UNDERSCORES (also known as SCREAMING_SNAKE_CASE).

address[] public UsersAddress;
mapping(address funders => uint256 NetAmountPaid) public AddToAmnt;

address public immutable owner;

// IMMUTABLE
// You should use the immutable keyword when you have a state variable that needs to be assigned a value exactly once (usually at deployment time) and will never change after that.
// You declare the immutable variable outside of the constructor (as a global state variable), but you assign its value inside the constructor.

constructor(){
    owner = msg.sender;
}


function fund() public payable{
    require(AmntInUsd(msg.value)>MINIMUM_USD , "Work hard and pay me more ETH brooo");
    UsersAddress.push(msg.sender);
    AddToAmnt[msg.sender] = AddToAmnt[msg.sender] + msg.value;

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

function withdraw() public onlyOwner{

   
    for(uint i = 0 ;i<UsersAddress.length ; i++){
        address funders = UsersAddress[i];
        AddToAmnt[funders] = 0;
    }

    UsersAddress = new address[](0);

    
    // call

   (bool sendSucc ,) = payable(msg.sender).call{value:address(this).balance}("");
   require(sendSucc , "Trans Failed");

}

modifier onlyOwner(){
 require(msg.sender == owner , "You aint an owner brooo,Hard Luck");
 _;
}



}