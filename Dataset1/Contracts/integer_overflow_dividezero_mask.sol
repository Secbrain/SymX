pragma solidity ^0.4.11; //StAs //solc-version(smartanalysis)

contract SolidityUncheckedSend {
    uint x = 5; //StAs //constable-states(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)、unused-state(securify2)
    uint q = 2; //StAs //constable-states(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)、unused-state(securify2)
    uint w = 3; //StAs //constable-states(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)、unused-state(securify2)

    function operator(uint16 a, uint16 b) public{
        uint y = 5 / a * b; //StAs //divide-before-multiply(smartanalysis)、integer-overflow(smartanalysis)
    }
    function operator1(uint16 a, uint16 b) public{
	require(5 / a * b > 0); //StAs //divide-before-multiply(smartcheck)
    }
}
