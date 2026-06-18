// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {PriceConverter} from "Project/Fundme5Library.sol";

contract giveMeFund{

    using PriceConverter for uint256;

uint256 public constant Minimum_USD = 5 * 1e18;

address[] public UsersAddress;
mapping(address funders => uint256 NetAmountPaid) public AddToAmnt;

function fund() public payable{
    require(msg.value.AmntInUsd()>Minimum_USD , "Work hard and pay me more ETH brooo");
    UsersAddress.push(msg.sender);
    AddToAmnt[msg.sender] = AddToAmnt[msg.sender] + msg.value;

}



}