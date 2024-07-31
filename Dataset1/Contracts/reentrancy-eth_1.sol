contract C {
    mapping (address => uint) public balances;
    
    uint public MinDeposit = 1 ether;
    
    function C() payable {}

    function Deposit()
    public
    payable
    {
        if(msg.value >= MinDeposit)
        {
            balances[msg.sender]+=msg.value;
        }
    }
    
    function CashOut(uint _am)
    {
        if(_am<balances[msg.sender])
        {            
            if(msg.sender.call.value(_am)())
            {
                balances[msg.sender]-=_am;
            }
        }
    }
    
    function() public payable{}
}
