contract Timestamp{
    event Time(uint);

    function bad0() external{
        require(block.timestamp == 0); //StAs //incorrect-equality(smartanalysis)、timestamp(smartanalysis)、block-other-parameters、timestamp(mythril)
    }

    function bad1() external{
        uint time = block.timestamp; //StAs //timestamp(securify2)
        require(time == 0); //StAs //incorrect-equality(smartanalysis)、timestamp(smartanalysis)、block-other-parameters、timestamp(mythril)
    }

    function bad2() external returns(bool){
        return block.timestamp>0; //StAs //timestamp(smartanalysis)
    }   

    function good() external returns(uint){ //StAs //default-return-value(smartanalysis)
        emit Time(block.timestamp); //no timestamp
    }
}

