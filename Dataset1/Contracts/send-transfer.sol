contract C {
    function C() payable {
    }
    function send_true1(address bb) public
    {
        if(msg.sender.send(1 ether)){revert();}
    }
    function send_true2(address bb) public
    {
        msg.sender.send(1 ether);
    }
    function send_true3(address bb) public
    {
        if(msg.sender.send(1 ether)){uint c = 0;}
    }
    function send_true4(address bb) public
    {
        bb.send(1 ether);
    }
    function require_false1(address bb) public
    {
        bb.transfer(1 ether);
    }
    function require_false2(address bb) public
    {
        msg.sender.transfer(1 ether);
    }
    function send_true5(address bb) public
    {
        msg.sender.send(1 ether);
    }
    function send_true6(address bb) public
    {
        msg.sender.send(1 ether);
    }
    function call_false1(address bb) public
    {
        msg.sender.call.value(1 ether)();
    }
    function call_false3(address bb) public
    {
        if(msg.sender.call.value(1 ether)()){revert();}
    }
    function call_false4(address bb) public
    {
        if(msg.sender.call.value(1 ether)()){}
    }
    function() public payable{}
}
