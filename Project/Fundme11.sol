// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// WE WILL LEARN ABT CREATING CUSTOM ERRORS
// we do custom error to revert instead of require in updated solidity

error notOwner();

// we declare them at top and use ifs instead of require 
// this ends up saving a lot of gas

contract giveMeFund{

uint256 public constant Minimum_USD = 5 * 1e18;

address[] public UsersAddress;
mapping(address funders => uint256 NetAmountPaid) public AddToAmnt;

address public owner;

constructor(){
    owner = msg.sender;
}

function fund() public payable{
    require(AmntInUsd(msg.value)>Minimum_USD , "Work hard and pay me more ETH brooo");
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
 //require(msg.sender == owner , "You aint an owner brooo,Hard Luck");

 // instead of using require we will use if
if(msg.sender != owner){revert notOwner();}
_;

// this saves up a lot of gas coz we dont have to write the revert string "You aint an owner brooo,Hard Luck" which takes up storage
// revert keyowrd exactly does the same thing

// note in this we only changed require here only but we can change each and every require
}
}