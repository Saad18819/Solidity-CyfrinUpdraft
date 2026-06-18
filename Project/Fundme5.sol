// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {PriceConverter} from "Project/Fundme5Library.sol";

contract giveMeFund{

using PriceConverter for uint256;

/*
This line tells Solidity: "Hey, I want to attach all the functions inside PriceConverter to any uint256 variable type."

Because of this, any uint256 variable in your contract automatically upgrades and gains new abilities (methods).

*/

uint256 public constant Minimum_USD = 5 * 1e18;

address[] public UsersAddress;
mapping(address funders => uint256 NetAmountPaid) public AddToAmnt;

function fund() public payable{
    
    require(msg.value.AmntInUsd()>Minimum_USD , "Work hard and pay me more ETH brooo");
   
   /*
 coz of using using PriceConverter for uint256; 
 we dont have to right AmntInUsd(msg.value) the copiler aautomatically undersrood that msg.value is the first parameter we talking abt

 now lets say AmntInUsd(param 1,param2) then u gotta write Param1.AmntInUsd(param 2);




   */


    UsersAddress.push(msg.sender);
    AddToAmnt[msg.sender] = AddToAmnt[msg.sender] + msg.value;

}



}