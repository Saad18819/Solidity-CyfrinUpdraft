// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract TimeVault{
uint256 public constant MinUsd =10*1e18;
// datatype visibilty specifier variableName

address[] public funders;
//No, you do not need to assign a 0 value to the array or initialize it manually.
//In Solidity, when you declare a dynamic array like address[] public funders;, it automatically starts completely empty with a length of 0.

mapping(address donaters => uint256 amntFunded) public addToAmnt;

address public owner;

constructor(){
    owner = msg.sender;
}

    function fund() public payable{
require(netAmnt(msg.value)>=MinUsd,"nigga work hard,earn some real shit and then donate");
funders.push(msg.sender);
addToAmnt[msg.sender] += msg.value;
 }

 function getPrice() public view returns(uint256){
    (,int256 price, , ,) = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).latestRoundData();
    return uint256(price *1e10); // chainlink price feed always return the answer with 8 decimal place
 }

 // the mistake i did was not putting the view in above function always remember my function reads the data from external source and aint changing any variables so it must be put on view


 function netAmnt(uint256 EthAmnt) public view returns(uint256){
    uint256 UsdAmnt = getPrice();
    uint256 netUsdAmnt = (EthAmnt * UsdAmnt)/1e18;
    return netUsdAmnt;
 }



 function withdraw() public{

    require(msg.sender == owner , "you aint an owner broo");

    for(uint256 i = 0 ; i<funders.length;i++){
        addToAmnt[funders[i]] = 0;
    }
    funders = new address[](0);

(bool Succ,) = payable(msg.sender).call{value:address(this).balance}("");
require(Succ,"withdraw failed");


 }

 receive() external payable{
    fund();
 }

 fallback()external payable{
    fund();
 }
// i forgot to add the external and payable..
// the reason why we use external is coz we will be calling these function outside of the contract all the time 
// payable means we can pay this contract which is what we are doing rnn
}