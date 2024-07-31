//pragma solidity ^0.4.24;

contract TxOrigin {

    address owner; //StAs //visibility(smartcheck)

    constructor() { owner = msg.sender; } //StAs //visibility(smartanalysis)

    function bug5() public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        while(tx.origin != owner) //StAs //tx-origin(smartanalysis)、extra-gas-inloops(smartanalysis)、costly-loop(smartanalysis)
    	{
    	    uint a = 1;
    	    break;
    	}
    }

    function bug6() public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	   address medi = tx.origin; //StAs //tx-origin(smartcheck)
        require(medi == owner); //StAs //tx-origin(smartanalysis)
    }

    function legit0() public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        require(tx.origin == msg.sender); //StAs //tx-origin(mythril)
    }
    
    function legit1() public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        tx.origin.transfer(address(this).balance); //StAs //arbitrary-send(smartanalysis)、tx-origin(smartcheck)、Transaction Order Affects Ether Amount(securify)、Transaction Order Affects Ether Receiver(securify)、unchecked-send(securify)
    }
}
