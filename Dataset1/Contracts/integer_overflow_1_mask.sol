
contract SimpleBank {
    mapping(address => uint) balances; //StAs //visibility(smartcheck)

    function withdraw(uint amount) { //StAs //external-function(smartanalysis)、visibility(smartanalysis)、Missing Input Validation(securify)
        balances[msg.sender] -= amount; //StAs //integer-overflow(smartanalysis)、integer_underflow(osiris)
        msg.sender.transfer(amount); //StAs //unchecked-send(securify)
    }
}

contract SimpleBank_2 { //StAs //naming-convention(smartanalysis)
    mapping(address => uint) balances; //StAs //visibility(smartcheck)

    function withdraw(uint amount) { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        require(amount <= balances[msg.sender]);
        balances[msg.sender] -= amount; //StAs no integer-overflow //integer-overflow(smartanalysis)
        msg.sender.transfer(amount); //StAs //unchecked-send(securify)
    }
}
