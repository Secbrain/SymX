//pragma solidity ^0.4.24;

contract TxOrigin {

    address owner; //StAs //visibility(smartcheck)

    constructor() { owner = msg.sender; } //StAs //visibility(smartanalysis)

    function bug0() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        require(tx.origin == owner); //StAs //tx-origin(smartanalysis)
    }

    function bug2() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        if (tx.origin == owner) { //StAs //tx-origin(smartanalysis)、revert-require(smartanalysis)
            revert();
        }
    }

    function bug3() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        if ((tx.origin != owner) || (tx.origin != msg.sender)) { //StAs //tx-origin(smartanalysis)、revert-require(smartanalysis)
            revert();
        }
    }

    function bug4() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        assert(tx.origin != owner); //StAs //assert-violation(smartanalysis)、tx-origin(smartanalysis)、Exception State(mythril)
    }
}
