contract C {
    mapping (address => uint) public balances;
        
    function Deposit(uint x)
    public
    payable
    {
        if(msg.value >= 1 ether)
        {
            balances[msg.sender]+=x;
        }
    }
    
    function() public payable{}
}
