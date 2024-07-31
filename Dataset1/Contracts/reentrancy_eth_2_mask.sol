pragma solidity ^0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract Reentrancy {
    mapping (address => uint) userBalance; //StAs //visibility(smartcheck)

    function addToBalance() payable public{ //StAs //external-function(smartanalysis)
        userBalance[msg.sender] += msg.value; //StAs //integer-overflow(smartanalysis)、integer_overflow(oyente)
    }

    function withdrawBalance() public{ //StAs //external-function(smartanalysis)
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
        if( ! (msg.sender.call.value(userBalance[msg.sender])() ) ){ //eth //StAs //reentrancy-eth(smartanalysis)、low-level-calls(smartanalysis)、revert-require(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)
            revert();
        }
        userBalance[msg.sender] = 0; //StAs //reentrancy-eth(smartanalysis)
    }   

    function withdrawBalance_bad2() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
        require(msg.sender.call.value(userBalance[msg.sender])()); //eth //StAs //reentrancy-eth(smartanalysis)、low-level-calls(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)
        userBalance[msg.sender] = 0; //StAs //reentrancy-eth(smartanalysis)
    } 

    function withdrawBalance_bad3() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
        msg.sender.call.value(userBalance[msg.sender])(); //eth //StAs //reentrancy-eth(smartanalysis)、unchecked-lowlevel(smartanalysis)、low-level-calls(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、callstack(oyente)
        userBalance[msg.sender] = 0; //StAs //reentrancy-eth(smartanalysis)
    }   
}
