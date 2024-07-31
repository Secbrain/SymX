contract Test{

    address destination;
    address owner;

    mapping (address => uint) balances;

    constructor(){ //StAs //visibility(smartanalysis)
        balances[msg.sender] = 0;
	owner = msg.sender;
    }

    function direct() public{ //bad //StAs //external-function(smartanalysis)
        msg.sender.send(address(this).balance); //StAs //arbitrary-send(smartanalysis)、unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)、money_concurrency(oyente)
    }

    function init() public{ //StAs //external-function(smartanalysis)
        destination = msg.sender; //StAs //writeto-arbitrarystorage(securify)
    }

    modifier isowner() {
	address aa = msg.sender;
	require(owner == aa);
	_;
    }

    function indirect() public{ //bad //StAs //external-function(smartanalysis)
        destination.send(address(this).balance); //StAs //arbitrary-send(smartanalysis)、unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)、Transaction Order Affects Ether Receiver(securify)
    }

    function directceshi_1() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
	require(owner == msg.sender);
        destination.send(address(this).balance); //StAs no arbitrary-send //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)、Transaction Order Affects Ether Receiver(securify)
    }

    function directceshi_2() isowner public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        destination.send(address(this).balance); //StAs no arbitrary-send //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、arbitrary-send(slither)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)、Transaction Order Affects Ether Receiver(securify)
    }

    function directceshi_3() payable public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        destination.send(msg.value); //StAs //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)、Transaction Order Affects Ether Receiver(securify)、money_concurrency(oyente)
    }

    function directceshi_4() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        destination.send(balances[msg.sender]); //StAs no arbitrary-send //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)、Transaction Order Affects Ether Receiver(securify)
    }

    function directceshi_5() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        destination.send(0); //StAs no arbitrary-send //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、arbitrary-send(slither)、unchecked-lowlevel(smartcheck)
    }

    function directceshi_6() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
	uint avalue = 0;
        destination.send(avalue); //StAs no arbitrary-send //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、arbitrary-send(slither)、unchecked-lowlevel(smartcheck)
    }

    // these are legitimate calls
    // and should not be detected
    function repay() payable public{ //StAs //external-function(smartanalysis)
        msg.sender.transfer(msg.value); //StAs //Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)
    }

    function withdraw() public{ //StAs //external-function(smartanalysis)
        uint val = balances[msg.sender];
        msg.sender.send(val); //StAs no arbitrary-send //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)
    }

    function withdraw_direct() payable public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        uint val = msg.value;
        msg.sender.send(val); //StAs //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)
    }

    function withdraw_inderect() public{ //bad //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
        uint val = address(this).balance;
        msg.sender.send(val); //StAs //arbitrary-send(smartanalysis)、unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)
    }

    function indirect_ceshi1() public{ //bad //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)
	address cc = msg.sender;
	cc = owner;
	require(cc == owner);
	address dd = msg.sender; //StAs //missing-zero-check(smartanalysis)
        uint val = address(this).balance;
        dd.send(val); //StAs //arbitrary-send(smartanalysis)、unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)
    }

    function buy() payable public{ //StAs //external-function(smartanalysis)
        uint value_send = msg.value;
        uint value_spent = 0 ; // simulate a buy of tokens
        uint remaining = value_send - value_spent; //StAs //integer-overflow(smartanalysis)
        msg.sender.send(remaining); //StAs //unchecked-send(smartanalysis)、low-level-calls(smartanalysis)、unchecked-lowlevel(smartcheck)、Transaction Order Affects Ether Amount(securify)
    }

}
