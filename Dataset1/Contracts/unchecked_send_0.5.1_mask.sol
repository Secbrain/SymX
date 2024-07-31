contract MyConc{
    function bad(address payable dst) external payable{ //StAs //missing-zero-check(smartanalysis)、Missing Input Validation(securify2)
        dst.send(msg.value); //StAs //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、unused-return(securify2)、Transaction Order Affects Ether Amount(securify)
    }

    function bad_1() external payable{ //StAs //naming-convention(smartanalysis)
        msg.sender.send(msg.value); //StAs //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、unused-return(securify2)、Transaction Order Affects Ether Amount(securify)
    }

    function good(address payable dst) external payable{ //StAs //Missing Input Validation(securify2)
        require(dst.send(msg.value)); //StAs //low-level-calls(smartanalysis)、send-transfer(smartanalysis)、unchecked-send(securify2)、Transaction Order Affects Ether Amount(securify)
    }

    function good2(address payable dst) external payable{ //StAs //missing-zero-check(smartanalysis)、Missing Input Validation(securify2)
        bool res = dst.send(msg.value); //StAs //low-level-calls(smartanalysis)、reentrancy-limited-events(smartanalysis)、reentrancy-limited-gas(slither)、unchecked-send(securify2)、Transaction Order Affects Ether Amount(securify)
        if(!res){
            emit Failed(dst, msg.value); //StAs //reentrancy-limited-events(smartanalysis)、reentrancy-limited-gas(slither)
        }
    }

    event Failed(address, uint);
}
