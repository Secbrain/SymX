contract Test{

    address payable destination; //StAs //visibility(smartcheck)、State variables default visibility(securify2)、uninitialized-state(securify2)

    mapping (address => uint) balances; //StAs //visibility(smartcheck)、State variables default visibility(securify2)

    constructor() public{
        balances[msg.sender] = 0;
    }

    function direct() public{ //StAs //external-function(smartanalysis)
        msg.sender.send(address(this).balance); //StAs //arbitrary-send(smartanalysis)、unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify2)、unused-return(securify2)
    }

    function init() public{ //StAs //external-function(smartanalysis)
        destination = msg.sender; //StAs //writeto-arbitrarystorage(securify2)
    }

    function indirect() public{ //StAs //external-function(smartanalysis)
        destination.send(address(this).balance);
    }

    function nowithdraw() public{ //StAs //external-function(smartanalysis)
        uint val = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.send(val); //StAs //no arbitrary-send because value is zero. unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify2)、unused-return(securify2)
    }

    function buy() payable public{ //StAs //external-function(smartanalysis)
        uint value_send = msg.value; //StAs //naming-convention(securify2)
        uint value_spent = 0 ; // simulate a buy of tokens //StAs //naming-convention(securify2)
        uint remaining = value_send - value_spent; //StAs //no integer-overflow(smartanalysis)
        msg.sender.send(remaining); //StAs //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、unused-return(securify2)、Transaction Order Affects Ether Amount(securify)
}

}
