// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import { TheHerdV2 } from "../contracts/TheHerd.sol";
import { PRBTest } from "@prb/test/PRBTest.sol";

contract TestTheHerdV2 is PRBTest {
    TheHerdV2 herd;

    function setUp() public {
        herd = new TheHerdV2();
    }
    function testWithdraw() public payable {
        // Deploy the contract

        // Send some ether to the contract
        uint256 initialBalance = address(herd).balance;
        uint256 amountToSend = 1000000000000000000; // 1 ether
      

        // Withdraw ether from the contract
        address payable withdrawTo = payable(msg.sender);
        uint256 initialWithdrawToBalance = withdrawTo.balance;
        assertEq(address(herd).balance, 0);

        uint256 expectedWithdrawalAmount = initialBalance + amountToSend;
        assertEq(withdrawTo.balance, initialWithdrawToBalance + expectedWithdrawalAmount);
    }


}