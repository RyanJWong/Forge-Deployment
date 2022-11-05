
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract Caller {
// f0 declaration
    ExampleSoliditySprint2022 public myFZero;




    constructor(address counterAddress) {
// call to f0
        myFZero = ExampleSoliditySprint2022(counterAddress);

    }




    function callFZero() external {

        myFZero.f0(0);

    }

}
