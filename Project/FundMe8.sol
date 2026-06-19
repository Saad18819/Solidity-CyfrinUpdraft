// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

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

function withdraw() public{


 require(msg.sender == owner , "Must be owner!");

    for(uint i = 0 ;i<UsersAddress.length ; i++){
        address funders = UsersAddress[i];
        AddToAmnt[funders] = 0;
    }

    UsersAddress = new address[](0);

 
    // call

   (bool sendSucc ,) = payable(msg.sender).call{value:address(this).balance}("");
   require(sendSucc , "Trans Failed");

}
}

/* 
CONSTRUCTOR EXPLAINED

Think of a constructor as the "Birth Certificate" or "Setup Wizard" of your smart contract.

It is a special, one-time function that runs exactly once at the absolute moment your contract is deployed to the blockchain. After the contract is born, the constructor dies—it can never be called or run ever again.



the Moment of Deployment: You click the orange "Deploy" button in Remix.

The Execution: The EVM looks at who is deploying the contract (msg.sender) and immediately saves that person's address into the owner variable.

The Result: The very first second your contract exists on the blockchain, it already perfectly knows who its creator/boss is.





SYNTAX BREAKDOWN


The Keyword constructor: You don't use the word function. You simply write constructor.

The Parentheses (): This is where you can pass setup parameters if you want (more on this below).

No Visibility: You never write public, private, or external on a constructor. The compiler already knows it's public during deployment and invisible afterward.

No Return Type: A constructor can never return data. Its only job is to change state variables.




When should you use a constructor?
You use a constructor anytime you need to set up rules, values, or permissions before anyone else is allowed to interact with your contract.





*/