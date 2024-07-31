pragma solidity ^0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract Reentrancy {
    mapping (address => uint) userBalance; //StAs //visibility(smartcheck)
   
    function addToBalance() payable public{ //StAs //external-function(smartanalysis)
        userBalance[msg.sender] += msg.value; //StAs //integer-overflow(smartanalysis)、integer_overflow(oyente)
    }

    function withdrawBalance_good() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
        if( ! (msg.sender.send(userBalance[msg.sender]) ) ){ //no-gas-eth //StAs //low-level-calls(smartanalysis)、reentrancy-limited-gas(smartanalysis)、revert-require(smartanalysis)、send-transfer(smartanalysis)、reentrancy-eth(securify)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)
            revert();
        }
        userBalance[msg.sender] = 0; //StAs //reentrancy-limited-gas(smartanalysis)
    }

    function withdrawBalance_good1() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
	if(userBalance[msg.sender]>1)
	{
            if( ! (msg.sender.call.value(0)() ) ){ //no-eth //StAs //reentrancy-no-eth(smartanalysis)、low-level-calls(smartanalysis)、revert-require(smartanalysis)、upgrade-050(smartanalysis)、reentrancy-eth(slither)、low_leverl_calls(smartcheck)
                revert();
            }
	    userBalance[msg.sender] = userBalance[msg.sender] - 1; //StAs //reentrancy-no-eth(smartanalysis)、integer-overflow(smartanalysis)、reentrancy-eth(slither)
	}      
    }

    function withdrawBalance_good2() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
	if(userBalance[msg.sender]>1)
	{
	    uint aa = 0;
            if( ! (msg.sender.call.value(aa)() ) ){ //no-eth //StAs //reentrancy-no-eth(smartanalysis)、low-level-calls(smartanalysis)、revert-require(smartanalysis)、upgrade-050(smartanalysis)、reentrancy-eth(slither)、low_leverl_calls(smartcheck)
                revert();
            }
	    userBalance[msg.sender] = userBalance[msg.sender] - aa; //StAs //reentrancy-no-eth(smartanalysis)、integer-overflow(smartanalysis)、reentrancy-eth(slither)
	}      
    }

}
