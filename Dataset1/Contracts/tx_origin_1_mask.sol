/**

[TestInfo]
pattern: TxOriginPattern

 */
pragma solidity ^0.5.4; //StAs //solc-version(smartanalysis)

contract Contract {

    address payable owner; //StAs //visibility(smartcheck)、State variables default visibility(securify2)

    constructor () public{
        owner = msg.sender;
    }

    function test1() public { //StAs //external-function(smartanalysis)
        require(tx.origin == owner); // violation //StAs //tx-origin(smartanalysis)
        msg.sender.send(240194); //StAs //arbitrary-send(smartanalysis)、unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Execution of Ether Transfer(securify2)、unused-return(securify2)
    }

    function test2() public { //StAs //external-function(smartanalysis)
        if (tx.origin != owner) // violation //StAs //tx-origin(smartanalysis)
            assert(false); //StAs //Exception State(mythril)
    }

    function test3() public { //StAs //external-function(smartanalysis)
        require(msg.sender == tx.origin); // compliant //StAs //tx-origin(mythril)
        msg.sender.send(240194); //StAs //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、unused-return(securify2)
    }

    function test4() public { //StAs //suicidal(smartanalysis)、external-function(smartanalysis)
        selfdestruct(tx.origin); // ok //StAs //low-level-calls(smartanalysis)、tx-origin(smartcheck)、suicidal(securify2)
    }
}
