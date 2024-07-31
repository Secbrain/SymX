contract B {    
    function CashOut(uint _am) public returns (uint)
    {
        return _am;
    }
}
contract C {
    function C() payable {
    }
    address ee;
    function setaddress(address bb) public
    {
        ee = bb;
    }
    function low_level_calls_false1(address bb) public
    {
        msg.sender.call.value(1 ether).gas(2300)();
    }
    function send_false1(address bb) public
    {
        msg.sender.send(1 ether);
    }
    function transfer_false1(address bb) public
    {
        msg.sender.transfer(1 ether);
    }
    function low_level_calls_true1(address bb) public
    {
        msg.sender.call.value(1 ether)();
    }
    function low_level_calls_true2(address bb) public
    {
        ee.call.value(1 ether)();
    }
    function low_level_calls_false2(address bb) public
    {
        B b = B(bb);
        uint dd = b.CashOut(1);
    }
}
