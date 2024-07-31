contract C {
    address owner;
    function init() public {
        owner = msg.sender; //not check it, because so difficult
    }
    function C() payable {
    }
    function arbitrary_send_true1(address bb) public
    {
        if(!msg.sender.send(1 ether)){revert();}
    }
    function arbitrary_send_true2(address bb) public
    {
        msg.sender.send(1 ether);
    }
    function arbitrary_send_true3(address bb) public
    {
        if(msg.sender.send(1 ether)){}
    }
    function arbitrary_send_true4(address bb) public
    {
        bb.send(1 ether);
    }
    function arbitrary_transfer_1(address bb) public
    {
        bb.transfer(1 ether);
    }
    function arbitrary_transfer_2(address bb) public
    {
        msg.sender.transfer(1 ether);
    }
    function arbitrary_send_true5(address bb) public
    {
        require(msg.sender.send(1 ether));
    }
    function arbitrary_send_true6(address bb) public
    {
        assert(msg.sender.send(1 ether));
    }
    function arbitrary_send_true7(address bb) public
    {
        msg.sender.call.value(1 ether)();
    }
    function arbitrary_send_true8(address bb) public
    {
        msg.sender.call.value(1 ether).gas(2300)();
    }
    function arbitrary_send_true9(address bb) public
    {
        require(bb == msg.sender);
        bb.send(1 ether);
    }
    function arbitrary_send_true10(address bb) public
    {
        require(bb != msg.sender);
        bb.send(1 ether);
    }
    function arbitrary_send_true11(address bb) public
    {
        require(bb != msg.sender);
        require(bb != 0x0);
        require(bb != owner);
        bb.send(1 ether);
    }
    function arbitrary_send_false1(address bb) public
    {
        if(false){
            bb.send(1 ether);
        }
    }
    function arbitrary_send_false2(address bb) public
    {
        bb.send(0 ether);
    }
    function arbitrary_send_false3(address bb) public
    {
        require(bb != msg.sender);
        require(bb == msg.sender);
        bb.send(1 ether);
    }

    function() public payable{}
}
