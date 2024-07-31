
pragma solidity ^0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract Intergeroverflow{
    function good2() public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint a; //StAs //uninitialized-local(smartanalysis)
	uint b; //StAs //uninitialized-local(smartanalysis)
	uint c; //StAs //uninitialized-local(smartanalysis)
	uint d = a + b + c; //StAs //integer-overflow(smartanalysis)
    }

    function good3() public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint a; //StAs //uninitialized-local(smartanalysis)
	uint b; //StAs //uninitialized-local(smartanalysis)
	uint d = a + b + 5; //StAs //integer-overflow(smartanalysis)
    }
    
    function bad(uint a, uint b) public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint d = a + b + 5; //StAs //integer-overflow(smartanalysis)
    }

    function bad1(uint a, uint b) public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint d = a - b; //StAs //integer-overflow(smartanalysis)
    }

    function good4(uint a) public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint d = a + 5;
	assert(d >= a);
    }
}
