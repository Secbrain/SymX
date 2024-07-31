pragma solidity ^0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract Uninitialized{

    address destination; //StAs //uninitialized-state(smartanalysis)、visibility(smartcheck)

    function transfer() payable public{ //StAs //external-function(smartanalysis)
        destination.transfer(msg.value); //StAs //Transaction Order Affects Ether Amount(securify)、Transaction Order Affects Ether Receiver(securify)、unchecked-send(securify)、money_concurrency(oyente)
    }

}

contract Test1 is Uninitialized {   
    function init(address xx){ //StAs //missing-zero-check(smartanalysis)、external-function(smartanalysis)、visibility(smartanalysis)、Missing Input Validation(securify)
	destination = xx; //StAs //writeto-arbitrarystorage(securify)
        destination.transfer(msg.value); //StAs //Transaction Order Affects Ether Amount(securify)、Transaction Order Affects Ether Receiver(securify)、unchecked-send(securify)、money_concurrency(oyente)
    }
}

contract Test {
    mapping (address => uint) balances; //StAs //uninitialized-state(smartanalysis)、visibility(smartcheck)
    mapping (address => uint) balancesInitialized; //StAs //visibility(smartcheck)


    function init() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        balancesInitialized[msg.sender] = 0;
    }

    function use() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        // random operation to use the mapping
        require(balances[msg.sender] == balancesInitialized[msg.sender]);
    }
}

library Lib{ //StAs //locked-ether(securify)

    struct MyStruct{
        uint val;
    }

    function set(MyStruct storage st, uint v){ //StAs //visibility(smartanalysis)、Missing Input Validation(securify)
        st.val = 4; //StAs //writeto-arbitrarystorage(securify)
    }

}
