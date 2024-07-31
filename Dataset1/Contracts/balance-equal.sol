contract C{
    function bad0() external {
        require(address(address(this)).balance != 10 ether);
        msg.sender.transfer(0.1 ether);
    }

    function bad1() external {
        require(10 ether == address(address(this)).balance);
        msg.sender.transfer(0.1 ether);
    }

    function bad2() external {
        require(address(this).balance == 10 ether);
        msg.sender.transfer(0.1 ether);
    }

    function bad3() external {
        require(10 ether == address(this).balance);
        msg.sender.transfer(0.1 ether);
    }

    function bad4() external {
        uint256 balance = address(this).balance;
        if (balance == 10 ether) {
            msg.sender.transfer(0.1 ether);
        }
    }

    function bad5() external {
        uint256 balance = address(this).balance;
        if (10 ether == balance) {
            msg.sender.transfer(0.1 ether);
        }
    }

    function bad6() external {
        uint256 balance = address(address(this)).balance;
        if (balance == 10 ether) {
            msg.sender.transfer(0.1 ether);
        }
    }

    function bad7() external {
        uint256 balance = address(address(this)).balance;
        if (10 ether == balance) {
            msg.sender.transfer(0.1 ether);
        }
    }

    function myfunc(uint256 balance) pure internal returns (uint256) {
        return balance - balance;
    }

    function good1() external {
        require (address(address(this)).balance >= 10 ether);
        msg.sender.transfer(0.1 ether);
    }

    function good2() external {
        require (10 <= address(address(this)).balance);
        msg.sender.transfer(0.1 ether);
    }

    function good3() external {
        require (address(this).balance >= 10 ether);
        msg.sender.transfer(0.1 ether);
    }

    function good4() external {
        require (10 <= address(this).balance);
        msg.sender.transfer(0.1 ether);
    }
}
