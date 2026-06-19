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

function withdraw() public{
    for(uint i = 0 ;i<UsersAddress.length ; i++){
        address funders = UsersAddress[i];
        AddToAmnt[funders] = 0;
    }

    UsersAddress = new address[](0);
} 

}