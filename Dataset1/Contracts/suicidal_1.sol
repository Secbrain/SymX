contract C {
    address owner;
    function i_am_a_backdoor() public{
        selfdestruct(msg.sender); //bad
    }

    function C() payable {
    }

    function init() public {
        owner = msg.sender; //not check it, because so difficult
    }

    function selfdestruct_1() public{
        address aa = msg.sender;
        selfdestruct(msg.sender); //bad
    }

    function good_selfdestruct_2() public{
        if(false){
            selfdestruct(msg.sender);
        }
    }

    function false_selfdestruct() public{
        address aa = msg.sender;
        require(aa == owner);
        selfdestruct(msg.sender);
    }
}
