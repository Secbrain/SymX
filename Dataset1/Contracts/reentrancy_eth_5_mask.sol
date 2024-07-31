pragma solidity ^0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract Reentrancy {
    mapping (address => uint) userBalance; //StAs //visibility(smartcheck)
   
    function addToBalance() payable public{ //StAs //external-function(smartanalysis)
        userBalance[msg.sender] += msg.value; //StAs //integer-overflow(smartanalysis)、integer_overflow(oyente)
    }

    function withdrawBalance_fixed() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // To protect against re-entrancy, the state variable
        // has to be change before the call
        uint amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
        if( ! (msg.sender.call.value(amount)() ) ){ //good //StAs //low-level-calls(smartanalysis)、revert-require(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、money_concurrency(oyente)、reentrancy-eth(osiris)
            revert();
        }
    }   

    function withdrawBalance_fixed_1() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // send() and transfer() are safe against reentrancy
        // they do not transfer the remaining gas
        // and they give just enough gas to execute few instructions    
        // in the fallback function (no further call possible)
        msg.sender.transfer(userBalance[msg.sender]); //no-gas-eth //StAs //reentrancy-limited-gas(smartanalysis)、reentrancy-eth(securify)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、money_concurrency(oyente)
        userBalance[msg.sender] = 0; //StAs //reentrancy-limited-gas(smartanalysis)
    }

    function withdrawBalance_fixed_2() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // send() and transfer() are safe against reentrancy
        // they do not transfer the remaining gas
        // and they give just enough gas to execute few instructions    
        // in the fallback function (no further call possible)
        msg.sender.transfer(0); //no-gas-no-eth //StAs //reentrancy-limited-gas-no-eth(smartanalysis)、reentrancy-limited-gas(slither)
        userBalance[msg.sender] = userBalance[msg.sender] - 0; //StAs //integer-overflow(smartanalysis)、reentrancy-limited-gas-no-eth(smartanalysis)、reentrancy-limited-gas(slither)
    }   
   
    function withdrawBalance_fixed_5() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // send() and transfer() are safe against reentrancy
        // they do not transfer the remaining gas
        // and they give just enough gas to execute few instructions    
        // in the fallback function (no further call possible)
	uint aa = 0;
        msg.sender.transfer(aa); //no-gas-no-eth //StAs //reentrancy-limited-gas-no-eth(smartanalysis)、reentrancy-limited-gas(slither)
        userBalance[msg.sender] = userBalance[msg.sender] - aa; //StAs //integer-overflow(smartanalysis)、reentrancy-limited-gas-no-eth(smartanalysis)、reentrancy-limited-gas(slither)
    }
}
