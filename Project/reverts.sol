// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FundMe{

    uint public value  = 1;
    function fund() public payable{
      value = value + 1;
        require(msg.value>1e18 , "you need to spedn more eth");
    }

    // REVERT THING

// When your transaction hits that require statement and fails, Ethereum hits an absolute undo button on the data.
//Any money sent is handed back to the user.
// Any changes to variables or balances are wiped clean, as if the transaction never happened.
// If a transaction fails because of a require statement, the state reverts, but you still lose the gas used up to that point.


    function Value() public view returns(uint256){
        return value;
    }

    function withdraw() public{}
}

// When Transaction 1 and 2 succeed, your value variable goes from 1 to 2, and then to 3, with both numbers being permanently saved on the blockchain. When Transaction 3 is attempted with a low amount like 0.1 ETH, line 8 temporarily bumps the number up to 4 in the network's scratchpad memory; however, the moment it hits the failed require check on line 9, Ethereum hits a total undo button, wiping that 4 out completely and snapping the permanent value right back to 3 as if the third transaction never even tried to happen.