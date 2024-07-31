# Vulnerable Instance Validation

Through the above vulnerability detection and transaction analysis process, the defects of contracts can be discovered to standard the source code development. Nevertheless, some of vulnerabilities identified by the pre-mentioned Vulnerability Detectors may not be exploited by attackers to get extra amounts. To this end, the refinement of vulnerability detection results is useful to find the truly harmful discoveries, which should be fixed by the developers as soon as possible. Specifically, Vulnerability Validator works automatically based on the following two sub-components. 

## The validation templates for vulnerabilities

The first step of verification process is to deploying the vulnerable contracts and replaying the potential attack calls. The deployment requirements is the same as behavior identification, that is, either of contract code and deployment transactions. Next, the methods of initialing calls are divided into two types according to their vulnerability exploitation. 

### Vulnerable calls replaying

All of the potential calls are directly replayed in their order based on the EVM World Memory for vulnerabilities that can be triggered simply, such as AS and SU. For example, after the execution of AS calls, the last call is designed to be performed once additionally, so that the functions with unlimited calls can be checked. 

### Auxiliary contract executing

```solidity
contract ReentranceExploit {
	uint reentry_num = 2, reentry_val = 0;//Reentry values 
	address owner, vul_contract; //Attack settings
	bytes reentry_str; //Reentry data
	function ReentranceExploit() payable{
		owner = msg.sender;
	}
	function set_vulnerable_contract(address _contract){
		vul_contract = _contract;
	}
	function proxycall(bytes data, uint val) payable{
		reentry_str = _reentry; reentry_val = val;
		vul_contract.call.value(val)(data);	//Initial calls.
	}
	function get_money(){
		suicide(owner);//Destroy contract and get assets.
	}
	function() payable{
		if (reentry_num > 0){
			reentry_num = reentry_num - 1;
			vul_contract.call.value(reentry_val)(reentry_str);
		}
	}
}
```

There are some vulnerabilities that need to be exploited through auxiliary contracts, such as RE. For them, SymX develops the auxiliary contract templates to make calls indirectly. As an example shown in the above code, the *ReentranceExploit* contract is designed for the RE vulnerability. Vulnerability Validator deploys this contract and sets the vulnerable contract address by invoking the "set\_vulnerable\_contract'' function. Then, he replays each call data through "proxycall'' function. During the call process, the fallback function  "function()'' is triggered when the auxiliary contract receives the Ether, so that the call data can be conducted repeatedly until "reentry\_num=0''. Finally, he destroys this contract and obtains its balance by invoking the "get\_money'' function. In this way, the vulnerable contracts suffers from a RE attack. 

## The goals/metrics to measure the success of attacks

After replaying the vulnerable calls, \nofram determines the attacks are successful when the goals/metrics are achieved, currently including the following four types. 

### Balance status tracking

The economic gain is a fundamental factor that needs to be considered, since most vulnerabilities, such as RE and AS, are exploited by attackers to increase their balance. Thus, after a series of attack calls, the account balance of attacks increases, indicating that the vulnerability exploit is successful. On the contrary, the vulnerability is not as dangerous as expected and can be considered a false positive. 

### Contract/Transaction status monitoring

In addition to stealing the contract balance, some vulnerabilities are aimed at breaking contracts or their logic. To describe their influence, other EVM world attributes (e.g., contract and transaction status) are monitored to verify the result correctness. For instance, after the SU calls, the contract was destroyed, i.e., its bytecode is reset to "0x'' in the EVM world. Meanwhile, the balance of attackers will be increased if the contract balance is non-zero. Also, the return values of TOD transactions differ at varying execution orders, and Gas exhaustion occurs in the calls of DOS vulnerability. 

### Variable status tracking

There are some vulnerabilities whose ultimate impact is difficult to measure, such as IO and UIO. In order to validate them, Vulnerability Validator tracks the variables and checks their operations in real time based on the EVM Stack. For instance, the abnormal computation results occur in the state path of IO calls. status of local variables, e.g., whether their computation results are abnormal. The value of global state variables are changed incorrectly during the execution of UIO calls. 

### Source code checking

Thanks to the mechanism of defective source code mapping, code checking can be used to validate defects that reflect the significant features. For instance, the *revert-require* optimization can be directly verified by checking the corresponding defective source code is "revert()'' rather than "require()''. The UIS defect can be validated by checking the state variable whether is initialed with a specific value. Notably, there are some vulnerabilities do not require validating with dynamic execution, such as low-level-calls, boolean-equal, and send-transfer. It can be attributed to the facts that they can validate simply by checking the contract source code.