pragma solidity 0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract HoneyPot {
    address addr; //StAs //uninitialized-state(smartanalysis)、constable-states(smartanalysis)、visibility(smartcheck)
    function withdraw() public payable { //StAs //external-function(smartanalysis)
        if(!addr.send(42 ether)) { //StAs send-transfer uninitialized-state //low-level-calls(smartanalysis)、revert-require(smartanalysis)、send-transfer(smartanalysis)、unchecked-send(securify)
			revert();
		}
    }
	
}
