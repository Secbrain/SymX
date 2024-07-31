contract MyConc{
    function bad(address dst) external payable{ //StAs //missing-zero-check(smartanalysis)、Missing Input Validation(securify)
        dst.call.value(msg.value)(""); //StAs //unchecked-lowlevel(smartanalysis)、low-level-calls(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、money_concurrency(oyente)、reentrancy-eth(osiris)
    }

    function bad_1() external payable{ //StAs //naming-convention(smartanalysis)
        msg.sender.call.value(msg.value)(""); //StAs //unchecked-lowlevel(smartanalysis)、low-level-calls(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、money_concurrency(oyente)、reentrancy-eth(osiris)、reentrancy-benign(mythril)
    }

    function good(address dst) external payable{ //StAs //Missing Input Validation(securify)
        require(dst.call.value(msg.value)()); //StAs //low-level-calls(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、reentrancy-eth(osiris)
    }

    function good_1(address dst) external payable{ //StAs //naming-convention(smartanalysis)、Missing Input Validation(securify)
        if(dst.call.value(msg.value)()) {revert();} //StAs //low-level-calls(smartanalysis)、revert-require(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、reentrancy-eth(osiris)
    }
}
