pragma solidity ^0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract Called{
    function f() public; //StAs //unimplemented-functions(smartanalysis)、external-function(smartanalysis)
    uint counter; //StAs //visibility(smartcheck)
    function callme() public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        if( ! (msg.sender.call.value(1)() ) ){ //benign no reentrancy_eth //StAs //arbitrary-send(smartanalysis)、reentrancy-benign(smartanalysis)、low-level-calls(smartanalysis)、revert-require(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)
            throw; //StAs //deprecated-standards(smartanalysis)
        }
        counter += 1; //StAs //integer-overflow(smartanalysis)、reentrancy-benign(smartanalysis)
    }
}

contract ReentrancyEvent {

    mapping (address => uint) userBalance; //StAs //visibility(smartcheck)
    
    function addToBalance() payable public{ //StAs //external-function(smartanalysis)
		userBalance[msg.sender] += msg.value; //StAs //integer-overflow(smartanalysis)
    	} 

    function test_4() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
	uint aa = 0;
        msg.sender.call.value(aa)(); //event no reentrancy_eth //StAs //unchecked-lowlevel(smartanalysis)、reentrancy-events(smartanalysis)、low-level-calls(smartanalysis)、upgrade-050(smartanalysis)、arbitrary-send(slither)、low_leverl_calls(smartcheck)、reentrancy-benign(mythril)
    }

    function test_1() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
	uint aa = 0;
        msg.sender.transfer(aa); //no-gas-event、no-gas-no-eth //StAs //reentrancy-limited-events(smartanalysis)、reentrancy-limited-gas-no-eth(smartanalysis)、reentrancy-limited-gas(slither)
	userBalance[msg.sender] = userBalance[msg.sender] - aa; //StAs //integer-overflow(smartanalysis)、reentrancy-limited-gas-no-eth(smartanalysis)、reentrancy-limited-gas(slither)
    }   

    function test_2() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
	uint amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
        if( ! (msg.sender.call.value(amount)() ) ){ //good、event //StAs //reentrancy-events(smartanalysis)、low-level-calls(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、reentrancy-eth(securify)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、money_concurrency(oyente)
            userBalance[msg.sender] = amount;
        }
    }  

    function test_5() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
	uint amount = userBalance[msg.sender];
        userBalance[msg.sender] = 0;
        if( ! (msg.sender.send(amount) ) ){ //good、no-gas-event //StAs //low-level-calls(smartanalysis)、reentrancy-limited-events(smartanalysis)、reentrancy-limited-gas(slither)、reentrancy-eth(securify)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、money_concurrency(oyente)
            userBalance[msg.sender] = amount;
        }
    }

    function test_3() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
	if( ! (msg.sender.call.value(userBalance[msg.sender])() ) ){ //good、no-gas-event //StAs //low-level-calls(smartanalysis)、reentrancy-limited-events(smartanalysis)、revert-require(smartanalysis)、send-transfer(smartanalysis)、reentrancy-limited-gas(slither)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)
            revert();
        }
        userBalance[msg.sender] = 0;
    }  
}

