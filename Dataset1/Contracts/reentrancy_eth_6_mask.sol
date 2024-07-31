pragma solidity ^0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract Reentrancy {
    mapping (address => uint) userBalance; //StAs //visibility(smartcheck)
   
    function addToBalance() payable public{ //StAs //external-function(smartanalysis)
        userBalance[msg.sender] += msg.value; //StAs //integer-overflow(smartanalysis)、integer_overflow(oyente)
    }

    function withdrawBalance_fixed_3() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // The state can be changed
        // But it is fine, as it can only occur if the transaction fails 
        uint amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
        if( ! (msg.sender.call.value(amount)() ) ){ //good //StAs //low-level-calls(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、reentrancy-eth(securify)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)
            userBalance[msg.sender] = amount;
        }
    }   
    function withdrawBalance_fixed_4() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // The state can be changed
        // But it is fine, as it can only occur if the transaction fails 
        uint amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
        if( (msg.sender.call.value(amount)() ) ){ //good //StAs //low-level-calls(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、reentrancy-eth(securify)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)
            return;
        }
        else{
            userBalance[msg.sender] = amount;
        }
    }   

    function withdrawBalance_nested() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        uint amount = userBalance[msg.sender];
        if( ! (msg.sender.call.value(amount/2)() ) ){ //eth //StAs //low-level-calls(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、reentrancy-eth(securify)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)
            msg.sender.call.value(amount/2)(); //StAs //reentrancy-eth(smartanalysis)、unchecked-lowlevel(smartanalysis)、low-level-calls(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、callstack(oyente)
            userBalance[msg.sender] = 0; //StAs //reentrancy-eth(smartanalysis)
        }
    }   

}
