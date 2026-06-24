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

// three methods to withdraw from contract

    // transfer
    payable(msg.sender).transfer(address(this).balance);

    // send
    bool sendSuccess = payable(msg.sender).send(address(this).balance);
    require(sendSuccess , "Send Failed");

    // call

    // (bool callSuccess , bytes memory dataReturned) = payable(msg.sender).call{value:address(this).balance}("");

    (bool callSuccess ,) = payable(msg.sender).call{value:address(this).balance}("");
    require(callSuccess , "Call Failed");


} 

/* 
THREE METHODS TO WITHDRAW EXPLAINED

all three of these lines are trying to achieve the exact same basic physical action:

Look at how much money (ETH) is currently trapped inside this contract: address(this).balance

Pick up that money.

Throw it into the wallet of whoever clicked the withdraw button: payable(msg.sender)

The difference between them is how they handle errors and how much "gas" they give the receiving wallet to process the payment.



Method 1: transfer (The Strict Way)

How it works: This is the simplest method. It attempts to send the money.

The Catch: It has a hard-coded gas limit of 2,300 gas. This is barely enough gas to register a simple transfer. If the person receiving the money is a smart contract wallet (instead of a regular person's wallet) and tries to do anything complex when it gets the money, it will run out of gas.

Error Handling: If it fails for any reason, it automatically crashes, stops the execution, and reverts the transaction. You don't have to write a require statement for it.

The reason transfer doesn't need a require statement isn't because it's magically safer; it's because the Solidity developers built the failure check directly inside the transfer function itself. If it fails, it automatically reverts the transaction and rolls back the state on its own.








Method 2: send (The Quiet Way)


How it works: Just like transfer, it only gives the receiving wallet a tiny 2,300 gas limit.

The Difference (Error Handling): If send fails, it does not crash your contract. It quietly returns a boolean value of false and lets the rest of your code keep running!

Why the require is there: Because it fails quietly, you must manually trap it using require(sendSuccess, "Send Failed");. If you forget that line and the transfer fails, your contract will clear out your user data anyway, and the money will be lost in limbo forever.(means if i didnt write require statement then transaction failed hone ke baad the money will be locked in contract and ab u have already wiped out address and all and created new address so ye money u can never get back isiliye require statement is sooo much necessary.

If you use require, the code does not keep running. It instantly stops everything, slams the brakes, and cancels the entire transaction.

Let's say something goes wrong and the transfer fails. sendSuccess becomes false.

Because sendSuccess is false, the require statement triggers a Revert.


When a transaction reverts, the blockchain acts like a time machine. It completely un-does every single change your function made up to that point.

Even though your for loop had already cleared the mapping and wiped out the UsersAddress array a millisecond earlier, the revert restores all of that data back to exactly how it was before you clicked the button.

Your UsersAddress array gets all its addresses back.

Everyone's balances in AddToAmnt are completely restored.

The error message "Send Failed" is sent back to your Remix console.







Method 3: call (The Modern Gold Standard) 🏆

How it works: This is a low-level function. Unlike the other two, call forwards all remaining gas to the receiver. This means if a complex multi-sig or smart contract wallet is receiving the funds, it has plenty of gas to execute its logic properly.

The Weird Syntax: call returns two pieces of data packed inside a tuple (bool, bytes):

A boolean (true or false) to tell you if the transfer worked.

A bytes object containing any data returned by the receiving wallet.
Since we only care about whether the transfer worked, we leave a blank space after the comma (bool callSuccess ,) to completely ignore the data part.

Error Handling: Just like send, it fails quietly by returning false. That's why you absolutely need the require(callSuccess, "Call Failed"); line right below it to force a revert if things go wrong.





another thing why we send receiver a gas like u are sending money as well as gas like woww craxyy wth is happening uk the thing is when u pay that amnt so to run the code there to send u money or wahtever process the code needs has to run tht code thats why u send the gas 




GENERAL MECHANISM:



Find out how much total money is sitting inside this contract right now (address(this).balance).

Grab that entire pile of money.

Look up who clicked the button (msg.sender)(it will givee the address) and make sure their wallet is allowed to receive crypto (payable).

METHOD-1
transfer (The Command)
How it behaves: It does not return anything. It acts as an absolute command: "Do this, or crash the whole system trying."




METHOD-2:
How it behaves: This is completely different because of the bool sendSuccess = part. Instead of crashing if it fails, the .send() method evaluates to a boolean value (true if the money moved, false if it failed) and saves that answer directly inside your new variable sendSuccess.






METHOD-3:

How it behaves: This syntax looks the strangest of all three.

The {value: ...} part: Instead of putting the money inside normal parentheses (), call uses curly braces {} to configure the transaction parameters (like setting the value or gas limit) before executing.

The (bool callSuccess, ) part: call returns two pieces of data at the same time. In programming, grouping multiple values together like this is called a tuple. Because we only want the first value (the true/false success boolean) and want to ignore the second piece of data (the bytes returned), we leave a blank space after the comma.






*/

}