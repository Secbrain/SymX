contract C {
    mapping (address => uint) public balances;
    
    function CashOut(address bb) public
    {
        uint _am = 1;
        if (balances[msg.sender] >= _am){
            if(bb.call.value(_am)())
            {
                balances[msg.sender]-=_am;
            }
        } 
    }
    
    function() public payable{}
}
