contract ERC20Function{
    function balanceOf(address _owner) external returns(uint);
}

contract ERC20Variable{
    mapping(address => uint) public balanceOf; //StAs //unused-state(securify2)、Missing Input Validation(securify)
}


contract ERC20TestBalance{


    function good0(ERC20Function erc) external{ //StAs //Missing Input Validation(securify2)
        require(erc.balanceOf(msg.sender) > 0); //StAs //unchecked-lowlevel(securify2)
    }

    function good1(ERC20Variable erc) external{ //StAs //Missing Input Validation(securify2)
        require(erc.balanceOf(msg.sender) > 0); //StAs //unchecked-lowlevel(securify2)
    }

    function bad0(ERC20Function erc) external{ //StAs //Missing Input Validation(securify2)
        require(erc.balanceOf(address(this)) == 10); //StAs //incorrect-equality(smartanalysis)、unchecked-lowlevel(securify2)
    }

    function bad1(ERC20Variable erc) external{ //StAs //Missing Input Validation(securify2)
        require(erc.balanceOf(msg.sender) ==10); //StAs //incorrect-equality(smartanalysis)、unchecked-lowlevel(securify2)
    }
}

contract TestContractBalance {

    function bad5() external {
        uint256 balance = address(this).balance;
        if (10 ether == balance) { //StAs //incorrect-equality(smartanalysis)
            msg.sender.transfer(0.1 ether); //StAs //arbitrary-send(smartanalysis)、unchecked-send(securify2)
        }
    }

    function bad6() external {
        uint256 balance = address(address(this)).balance;
        if (balance == 10 ether) { //StAs //incorrect-equality(smartanalysis)
            msg.sender.transfer(0.1 ether); //StAs //arbitrary-send(smartanalysis)、unchecked-send(securify2)
        }
    }

    function bad7() external {
        uint256 balance = address(address(this)).balance;
        if (10 ether == balance) { //StAs //incorrect-equality(smartanalysis)
            msg.sender.transfer(0.1 ether); //StAs //arbitrary-send(smartanalysis)、unchecked-send(securify2)
        }
    }

    function myfunc(uint256 balance) pure internal returns (uint256) {
        return balance - balance; //StAs //integer-overflow(smartanalysis)
    }

    function good1() external {
        require (address(address(this)).balance >= 10 ether);
        msg.sender.transfer(0.1 ether); //StAs //arbitrary-send(smartanalysis)、unchecked-send(securify2)
    }

    function good2() external {
        require (10 <= address(address(this)).balance);
        msg.sender.transfer(0.1 ether); //StAs //arbitrary-send(smartanalysis)、unchecked-send(securify2)
    }

}
