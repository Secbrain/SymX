//pragma solidity ^0.4.24;


contract Sender {
    address owner; //StAs //uninitialized-state(smartanalysis)、constable-states(smartanalysis)、visibility(smartcheck)

    function inc_callcode(address _contractAddress) public { //StAs //missing-zero-check(smartanalysis)、naming-convention(smartanalysis)、naming-convention(smartanalysis)、external-function(smartanalysis)
        _contractAddress.callcode(bytes4(keccak256("inc()"))); //StAs //controlled-delegatecall(smartanalysis)、unchecked-lowlevel(smartanalysis)、deprecated-standards(smartanalysis)、low-level-calls(smartanalysis)
    }

    function inc_delegatecall(address _contractAddress) public { //StAs //missing-zero-check(smartanalysis)、naming-convention(smartanalysis)、naming-convention(smartanalysis)、external-function(smartanalysis)
        _contractAddress.delegatecall(bytes4(keccak256("inc()"))); //StAs //no low-level-call //controlled-delegatecall(smartanalysis)、unchecked-lowlevel(smartanalysis)、low-level-calls(smartanalysis)
    }

    function destroy() { // so funds not locked in contract forever //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	if (msg.sender == owner) { 
		suicide(owner); // send funds to organizer //StAs //deprecated-standards(smartanalysis)、low-level-calls(smartanalysis)
	}
    }

    function kill()  { //如果后面加上constant的时候，刚创建就会把他销毁掉了 //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	if (owner==msg.sender){
		//析构函数
		selfdestruct(msg.sender); //StAs //low-level-calls(smartanalysis)、money_concurrency(oyente)
	}
    }

    function callvaluefuzhi(address _contractAddress) payable external{ //StAs //missing-zero-check(smartanalysis)、naming-convention(smartanalysis)
        bool kk = _contractAddress.callcode(bytes4(keccak256("inc()"))); //StAs //controlled-delegatecall(smartanalysis)、unchecked-lowlevel(smartanalysis)、deprecated-standards(smartanalysis)、low-level-calls(smartanalysis)
    }

    function sendvaluefuzhi(address _receiver) payable external{ //StAs //missing-zero-check(smartanalysis)、naming-convention(smartanalysis)、Missing Input Validation(securify)
        bool kk = _receiver.send(msg.value); //StAs //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、Transaction Order Affects Ether Amount(securify)、unchecked-lowlevel(securify)
    }
}


contract Receiver { //StAs //locked-ether(smartcheck)
    uint public balance = 0;

    function () payable external{ //StAs //locked-ether(smartanalysis)
        balance += 2; //StAs //integer-overflow(smartanalysis)、integer_overflow(oyente)
    }
}
