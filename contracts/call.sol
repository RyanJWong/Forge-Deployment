
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract Caller {
// f0 declaration
    Counter public myFZero;




    constructor(address counterAddress) {
// call to f0
        myFZero = Counter(counterAddress);

    }




    function callFZero() external {

        myFZero.f0(0);

    }

}
