pragma solidity ^0.5.0; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

contract Uninitialized{
    address payable destination; //StAs //uninitialized-state(smartanalysis)、constable-states(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)

    function transfer() payable public{ //StAs //external-function(smartanalysis)
        destination.transfer(msg.value); //StAs //Transaction Order Affects Ether Receiver(securify2)、unchecked-send(securify2)、Transaction Order Affects Ether Amount(securify)
    }
}
