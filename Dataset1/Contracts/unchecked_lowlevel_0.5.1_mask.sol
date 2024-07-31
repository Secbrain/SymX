contract MyConc{
    function bad(address payable dst) external payable{ //StAs //missing-zero-check(smartanalysis)、Missing Input Validation(securify2)
        dst.call.value(msg.value)(""); //StAs //unchecked-lowlevel(smartanalysis)、low-level-calls(smartanalysis)、low_leverl_calls(smartcheck)、unchecked-send(securify2)、unused-return(securify2)、Transaction Order Affects Ether Amount(securify)
    }

    function bad_1() external payable{ //StAs //naming-convention(smartanalysis)
        msg.sender.call.value(msg.value)(""); //StAs //unchecked-lowlevel(smartanalysis)、low-level-calls(smartanalysis)、low_leverl_calls(smartcheck)、unchecked-send(securify2)、unused-return(securify2)、Transaction Order Affects Ether Amount(securify)、reentrancy-benign(mythril)
    }

    function good(address payable dst) external payable{ //StAs //missing-zero-check(smartanalysis)、Missing Input Validation(securify2)
        (bool ret, bytes memory _) = dst.call.value(msg.value)(""); //StAs //low-level-calls(smartanalysis)、low_leverl_calls(smartcheck)、naming-convention(securify2)、unchecked-send(securify2)、Transaction Order Affects Ether Amount(securify)
        require(ret);
    }

    function badfunction(address payable dst) external payable{ //StAs //missing-zero-check(smartanalysis)、Missing Input Validation(securify2)
        (bool ret, bytes memory _) = dst.call.value(msg.value)(""); //StAs //low-level-calls(smartanalysis)、low_leverl_calls(smartcheck)、naming-convention(securify2)、unchecked-send(securify2)、Transaction Order Affects Ether Amount(securify)、unchecked-lowlevel(securify)
    }
}
