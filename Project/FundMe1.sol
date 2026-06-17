// wants user to pay
// withdraw fund
// minimum fund which user has to pay

// basically crowdfunding project banare to get money from public

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract FundMe{
    function Fund() public payable{
   require(msg.value > 1e18 , "Didnt send enough ETHEREUM"); //  1e18 = 10 ki power 18 == 1 ETH so basically minimum 1 eth u gotta pay for this crowdfundint thing
// msg.value can be used only in payable function
    }


   
// In Solidity, if a function does not have the payable keyword, it will completely reject any attempt to send money to it. By adding payable, you are telling the Ethereum network: "Hey, this function is allowed to accept ETH and store it inside this contract's balance."


// require is a built-in gatekeeper in Solidity. It checks if a condition is true.
//If it is true: The code keeps running normally.
//If it is false: The code immediately stops, crashes on purpose (reverts), and sends all the user's money back to them (minus a tiny bit of gas for the trouble).
// require(What to check , "What to say if it fails");


// msg.value specifically means: "The amount of Ethereum (ETH) the user sent along with this transaction."

// ethereum netweokr unit is wei they dont understand ethereum isilye u write in wei


// REVERT THING

// When your transaction hits that require statement and fails, Ethereum hits an absolute undo button on the data.
//Any money sent is handed back to the user.
// Any changes to variables or balances are wiped clean, as if the transaction never happened.





    function Withdraw() public{}
}


// yaha pe jo fund hai FundMe contract me jaata na ki koi personal developer ke wallet me and all basically jab bhi koi conttract likhte toh uska khud blockchain pe address hota so consider it as digital vault
// so Fund function call karne ke baad user ke wallet se smart contract ke wallet me jaata and then withdraw function call karne ke baad smart contract wallet se developer ke wallet me jaata
