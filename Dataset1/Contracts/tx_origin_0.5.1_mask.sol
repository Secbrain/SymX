pragma solidity ^0.5.0; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract TxOrigin {

    address payable owner; //StAs //visibility(smartcheck)、State variables default visibility(securify2)

    constructor() public{ owner = msg.sender; }

    function bug0() public{ //StAs //external-function(smartanalysis)
        require(tx.origin == owner); //StAs //tx-origin(smartanalysis)
    }

    function bug2() public{ //StAs //external-function(smartanalysis)
        if (tx.origin != owner) { //StAs //tx-origin(smartanalysis)、revert-require(smartanalysis)
            revert();
        }
    }

    function legit0() public{ //StAs //external-function(smartanalysis)
        require(tx.origin == msg.sender); //StAs //tx-origin(mythril)
    }
    
    function legit1() public{ //StAs //external-function(smartanalysis)
        tx.origin.transfer(address(this).balance); //StAs //arbitrary-send(smartanalysis)、tx-origin(smartcheck)、Transaction Order Affects Ether Amount(securify2)、unchecked-send(securify2)、Transaction Order Affects Ether Receiver(securify)
    }
}
