contract Otherparameters{

    function bad1() external{
        address coinbase = block.coinbase;    
        require(coinbase == msg.sender); //StAs //block-other-parameters(smartanalysis)、block-other-parameters、timestamp(mythril)
    }   

    function bad2() external returns(bool){
        return block.number>0; //StAs //block-other-parameters(smartanalysis)
    }
    function bad3() external returns(bool){
        return block.coinbase!=msg.sender; //StAs //block-other-parameters(smartanalysis)
    }
    function bad4() external returns(bool){
        return block.difficulty>0; //StAs //block-other-parameters(smartanalysis)
    }
    function bad5() external returns(bool){
        return block.gaslimit>0; //StAs //block-other-parameters(smartanalysis)
    }	
    function bad6() external{
        uint number = block.number;
        require(number == 20); //StAs //incorrect-equality(smartanalysis)、block-other-parameters(smartanalysis)、block-other-parameters、timestamp(mythril)
    }   
    function bad7() external{
        uint difficulty = block.difficulty;
        require(difficulty == 20); //StAs //block-other-parameters(smartanalysis)
    }   
    function bad8() external{   
        uint gaslimit = block.gaslimit;
        require(gaslimit == 20); //StAs //block-other-parameters(smartanalysis)、block-other-parameters、timestamp(mythril)
    }
}

