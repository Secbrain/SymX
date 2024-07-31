contract Otherparameters{
    event Number(uint);
    event Coinbase(address);
    event Difficulty(uint);
    event Gaslimit(uint);

    modifier onlyOwner {
        require(block.number == 20); //StAs //incorrect-equality(smartanalysis)、block-other-parameters(smartanalysis)
        _;	
    }

    function bad0_1() external{
        require(block.number == 20); //StAs //incorrect-equality(smartanalysis)、block-other-parameters(smartanalysis)、block-other-parameters、timestamp(mythril)
    }

    function bad0_2() external{
        require(block.coinbase == msg.sender); //StAs //block-other-parameters(smartanalysis)、block-other-parameters、timestamp(mythril)
    }

    function bad0_3() external{
        require(block.difficulty == 20); //StAs //block-other-parameters(smartanalysis)
    }

    function bad0_4() external{
        require(block.gaslimit == 20); //StAs //block-other-parameters(smartanalysis)、block-other-parameters、timestamp(mythril)
    }

    function good_1() external returns(uint){ //StAs //default-return-value(smartanalysis)
        emit Number(block.number);
    }
    
    function good_2() external returns(uint){ //StAs //default-return-value(smartanalysis)
        emit Coinbase(block.coinbase);
    }
    
    function good_3() external returns(uint){ //StAs //default-return-value(smartanalysis)
        emit Difficulty(block.difficulty);
    }
    
    function good_4() external returns(uint){ //StAs //default-return-value(smartanalysis)
        emit Gaslimit(block.gaslimit);
    }
}

