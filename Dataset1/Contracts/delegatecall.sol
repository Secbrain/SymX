contract C{

    address owner;
    address addr_good = address(0x41);
    address addr_bad = address(0x0);
    bytes database;

    bytes4 func_id;
    
    function C () public{
    	owner = msg.sender;
    }

    function bad_delegate_call4() public{
        msg.sender.delegatecall(abi.encodeWithSignature(""));
    }

    function set(bytes4 id) public{
        func_id = id;
        addr_bad = msg.sender;
    }

    function bad_delegate_call() public{
        addr_bad.delegatecall(abi.encodeWithSignature(""));
    }

    function good_delegate_call1() public{
        addr_good.delegatecall(abi.encodeWithSignature(""));
        require(msg.sender == owner);
        msg.sender.delegatecall(abi.encodeWithSignature(""));
    }

    modifier ifowner() {
        require(msg.sender == owner);
        _;
    }

    function good_delegate_call7() public{
        address cc = msg.sender;
        cc = addr_bad;
        require(cc == owner);
        address dd = addr_bad;
        dd.delegatecall(abi.encodeWithSignature(""));
    }

    function bad_delegate_call3(address cc) public{
        require(cc == owner);
        address dd = addr_bad;
        dd.delegatecall(abi.encodeWithSignature(""));
    }


    function good_delegate_call2() ifowner public{
        msg.sender.delegatecall(abi.encodeWithSignature(""));
    }

    function good_delegate_call3(address kk) ifowner public{
        kk.delegatecall(abi.encodeWithSignature(""));
    }

    function good_delegate_call4(address kk1) public{
        require(kk1 == owner);
	    kk1.delegatecall(abi.encodeWithSignature(""));
    }

    function good_delegate_call8(address kk1) public{
        address a = msg.sender;        
        require(a == owner);
        kk1.delegatecall(abi.encodeWithSignature(""));
    }

    function(){}
}
