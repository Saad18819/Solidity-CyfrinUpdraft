// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// WE WILL BE LEARNING ABT MODIFIERS in this

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

// here we added keyword onlyOwner which we created from modifier

function withdraw() public onlyOwner{

   //  require(msg.sender == owner , "You aint an owner brooo,Hard Luck");
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

    /*
    here what exactly happens wheneever u write keyword in function it will run this modifier which is require here and then
     _; says nows execture whaterver else is in the function
     if we put _; above reuwire then it will say fiunction execture whatever else inside function first and then require
    
    
    */
}
}


/* 
now the scene is we have so many function in which we just want owner to access so we goota
require(msg.sender == owner , "You aint an owner brooo,Hard Luck");
put this line in every gunction and as an engineer we work extremely hard to be extremely lazy

and what modifier do basically it creates a keyword that we can put directly into the function

and we dont give visisbilty to modifiers


MECHANISM:

it will go to function see the keyword comes down to modifier see the require code execute it and then _; goes back to fucntion and execute the rest of the function






*/
