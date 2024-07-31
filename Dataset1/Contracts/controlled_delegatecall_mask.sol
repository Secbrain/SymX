contract C{

    address owner; //StAs //uninitialized-state(smartanalysis)、constable-states(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)
    address addr_good = address(0x41); //StAs //naming-convention(smartanalysis)、constable-states(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)
    address addr_bad ; //StAs //naming-convention(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)、uninitialized-state(securify2)
    bytes database; //StAs //constable-states(smartanalysis)、unused-state(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)、uninitialized-state(securify2)

    bytes4 func_id; //StAs //naming-convention(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)、uninitialized-state(securify2)

    function good_delegate_call2(bytes memory data) public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)、Missing Input Validation(securify2)、integer_overflow(oyente)
        addr_good.delegatecall(data); //StAs //no controled unchecked-lowlevel(smartanalysis)、low-level-calls(smartanalysis)、unchecked-send(securify2)、unused-return(securify2)
    }

    function bad_delegate_call(bytes memory data) public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)、Missing Input Validation(securify2)、integer_overflow(oyente)
        addr_bad.delegatecall(data); //StAs //controlled-delegatecall(smartanalysis)、unchecked-lowlevel(smartanalysis)、low-level-calls(smartanalysis)、unchecked-send(securify2)、unused-return(securify2)
    }
    function set(bytes4 id) public{ //StAs //external-function(smartanalysis)、Missing Input Validation(securify2)
        func_id = id; //StAs //writeto-arbitrarystorage(securify2)
        addr_bad = msg.sender; //StAs //writeto-arbitrarystorage(securify2)
    }
}
