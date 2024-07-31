pragma solidity ^0.4.11; //StAs //solc-version(smartanalysis)

contract PullPayment {
	mapping (address => uint) private userBalances; //StAs //private-not-hidedata(smartanalysis)
	
	function deposit() public payable {
		userBalances[msg.sender] += msg.value;
	}

	function transfer(address to, uint amount) { //StAs //erc20-interface(smartanalysis)、external-function(smartanalysis)、visibility(smartanalysis)、Missing Input Validation(securify)
		if (userBalances[msg.sender] >= amount) {
			userBalances[to] += amount; //StAs //integer-overflow(smartanalysis)、writeto-arbitrarystorage(securify)、integer_overflow(oyente)
			userBalances[msg.sender] -= amount; //StAs //integer-overflow(smartanalysis)
		}
	}

	function withdrawBalance() public { //StAs //external-function(smartanalysis)
		uint amountToWithdraw = userBalances[msg.sender];
		if (!(msg.sender.call.value(amountToWithdraw)())) { throw; } // At this point, the caller's code is executed, and can call transfer() //StAs //reentrancy-eth(smartanalysis)、deprecated-standards(smartanalysis)、low-level-calls(smartanalysis)、revert-require(smartanalysis)、upgrade-050(smartanalysis)、low_leverl_calls(smartcheck)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、reentrancy-benign(mythril)
		userBalances[msg.sender] = 0; //StAs //reentrancy-eth(smartanalysis)
	}
}
