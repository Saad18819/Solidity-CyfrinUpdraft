// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

 import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
 
 library PriceConverter{

    function getPrice() internal view returns(uint256){

(,int256 price,,,) = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419).latestRoundData();

return uint256(price*1e10);
}

function AmntInUsd(uint256 ethAmount) internal view returns(uint256){
    uint256 singleEthPriceInUsd = getPrice();
    uint TotalPriceInUsd = (singleEthPriceInUsd * ethAmount)/1e18;

    return TotalPriceInUsd;

}
 }


 /* EXPLANATION


Think of a Library in Solidity like a specialized toolbox or a helper friend.

If you are building a house (a contract), you don't want to forge your own hammers and saws from scratch. Instead, you buy a toolbox (a library) and use its tools on your materials.

In your code, your library PriceConverter is the toolbox, and the "tool" inside it is the AmntInUsd function.




A library is similar to a smart contract, but it has strict limitations designed to save gas and make code reusable:

No State Variables: A library cannot hold money (Ether) or store data permanently. It can only process data passed to it.

No Ether Storage: You cannot send Ether directly to a library.

Embedded or Delegated: If library functions are internal (like yours), the compiler literally copies and pastes the library's code directly into your main contract when it compiles. It doesn't live on a separate address, which saves you gas!
Inside a library, you can use three visibility specifiers: internal, public, and external (you cannot use private)

An internal function in Solidity is like a "backroom operation" in a business. It can only be seen and called from inside the contract it belongs to, or by contracts that inherit from it (its children).

People outside the building (like external users or other random smart contracts) cannot see it or interact with it directly.


An internal function is a function that only your own contract's code can call, hiding it safely away from the outside public.

understand from the example u own a burger shop so only u can access its kitchen and customer dont have access to it so so basically my main contract only has the authority to access it and any public outside cant access it


 */