// SPDX-License-Identifier: MIT



pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract giveMeMoney{

uint256 public constant MinimumUsd = 3 * 1e18;

address[] public fundersAdd;

mapping(address funders => uint256 amnt) public addToAmnt;

address public immutable owner;

constructor(){
owner = msg.sender;
}

    function paiseDedo() public payable{
require(totalPrice(msg.value) >= MinimumUsd,"Bro work hard and earn some real shit ,then pay brooo");
fundersAdd.push(msg.sender);
addToAmnt[msg.sender]+=msg.value;
    }

function valueOfEth() public view returns(uint256){
 (,int256 price , , ,) = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
 return uint256(price * 1e10);
} 

function totalPrice(uint256 ethAmnt) public view returns(uint256){
    uint256 price1ETH = valueOfEth();
    uint256 netPrice = (price1ETH  * ethAmnt)/1e18;
    return netPrice;

}





function withdraw() public onlyOwner{



for(uint256 i = 0 ; i<fundersAdd.length; i++){
address person = fundersAdd[i];
addToAmnt[person] = 0;
}

fundersAdd = new address[](0);

(bool Succ ,) = payable(msg.sender).call{value:address(this).balance}("");
require(Succ , "Transfer failed");


}

fallback() external payable{
    paiseDedo();
}

receive() external payable{
    paiseDedo();
}

modifier onlyOwner(){
require(msg.sender == owner , "tuff luck,u aint an owner brooo");
_;
}
    
}


/*
learning 1:
i wrote first

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

then pragma solidity ^0.8.19

but pragma must come first












*/