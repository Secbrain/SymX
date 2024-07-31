contract A{
	address owner;
	mapping(address => uint256) balances;
    constructor() payable {
		owner = msg.sender;
    }
	function B() returns (uint256){
		if(msg.value == 0) {
			return 0;
		}
		balances[msg.sender] += msg.value;
		return balances[msg.sender];
	}
    function C() returns (uint256){
        uint balance1_val = this.balance;
        uint balance_val = msg.value;
		if(balance_val == 0) {
			return 0;
		}
		balances[msg.sender] += msg.value;
		return balances[msg.sender];
	}
    function D() returns (uint256){
        uint balance_val = msg.value - 0;
		if(balance_val == 0) {
			return 0;
		}
		balances[msg.sender] += msg.value;
		return balances[msg.sender];
	}
    function E() returns (uint256){
        uint balance_val = msg.value - 1; //this is not a example
		if(balance_val == 0) {
			return 0;
		}
		balances[msg.sender] += msg.value;
		return balances[msg.sender];
	}
    function() public payable{}
}
