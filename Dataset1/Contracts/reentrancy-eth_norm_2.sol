contract B {    
    function CashOut(uint _am) public returns (uint)
    {
        return _am;
    }
}
contract C {
    mapping (address => uint) public balances;
    
    function CashOut(address bb) public
    {
        uint _am = 1;
        if (balances[msg.sender] >= _am){
            B b = B(bb);
            uint dd = b.CashOut(1);
            balances[msg.sender] -= _am;
        } 
    }
    
    function() public payable{}
}
