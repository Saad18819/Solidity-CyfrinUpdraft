// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

interface myAPP{
    function addNumbers(uint256 a, uint256 b) external pure returns (uint256);
}

contract mine{
    function getCalculation() public pure returns(uint256){
    address myAddress = 0x1234567890123456789012345678901234567890; 
    
    uint256 result = myAPP(myAddress).addNumbers(5,10);

    return result;
    
    }
}