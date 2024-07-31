pragma solidity ^0.5.0; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract Reentrancy {
    mapping (address => uint) userBalance; //StAs //visibility(smartcheck)、State variables default visibility(securify2)
   
    function getBalance(address u) view public returns(uint){ //StAs //external-function(smartanalysis)、Missing Input Validation(securify2)
        return userBalance[u];
    }

    function addToBalance() payable public{ //StAs //external-function(smartanalysis)
        userBalance[msg.sender] += msg.value; //StAs //integer-overflow(smartanalysis)
    }   

    function withdrawBalance() public{ //StAs //external-function(smartanalysis)
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
        (bool ret, bytes memory mem) = msg.sender.call.value(userBalance[msg.sender])("");  //eth //StAs //reentrancy-eth(smartanalysis)、low-level-calls(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify2)、unchecked-send(securify2)
        if( ! ret ){ //StAs //revert-require(smartanalysis)
            revert();
        }
        userBalance[msg.sender] = 0; //StAs //reentrancy-eth(smartanalysis)
    }   

    function withdrawBalance_fixed() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // To protect against re-entrancy, the state variable
        // has to be change before the call
        uint amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
        (bool ret, bytes memory mem) = msg.sender.call.value(amount)(""); //good //StAs //low-level-calls(smartanalysis)、low_leverl_calls(smartcheck)、reentrancy-eth(securify2)、Transaction Order Affects Ether Amount(securify2)、unchecked-send(securify2)
        if( ! ret ){ //StAs //revert-require(smartanalysis)
            revert();
        }
    }   

    function withdrawBalance_fixed_2() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // send() and transfer() are safe against reentrancy
        // they do not transfer the remaining gas
        // and they give just enough gas to execute few instructions    
        // in the fallback function (no further call possible)
        msg.sender.transfer(userBalance[msg.sender]); //no-gas //StAs //reentrancy-limited-gas(smartanalysis)、reentrancy-eth(securify2)、Transaction Order Affects Ether Amount(securify2)、unchecked-send(securify2)
        userBalance[msg.sender] = 0; //StAs //reentrancy-limited-gas(smartanalysis)
    }   
   
    function withdrawBalance_fixed_3() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // The state can be changed
        // But it is fine, as it can only occur if the transaction fails 
        uint amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
        (bool ret, bytes memory mem) = msg.sender.call.value(amount)(""); //good //StAs //reentrancy-eth(smartanalysis)、low-level-calls(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify2)、unchecked-send(securify2)
        if( ! ret ){
            userBalance[msg.sender] = amount; //StAs //reentrancy-eth(smartanalysis)
        }
    }   
}
