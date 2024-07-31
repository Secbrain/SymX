contract C {
    event Number(uint);
    event Coinbase(address);
    event Difficulty(uint);
    event Gaslimit(uint);

    modifier onlyOwner {
        require(block.number == 20);
        require(block.coinbase == msg.sender); //can not be arrived
        require(block.difficulty == 20);
        require(block.gaslimit == 20);
        _;	
    }

    function bad0() external{
        require(block.number == 20);
        require(block.coinbase == msg.sender); //can not be arrived
        require(block.difficulty == 20);
        require(block.gaslimit == 20);
    }

    function bad1() external{
        address coinbase = block.coinbase;    
        require(coinbase == msg.sender);
    }   

    function bad2() external returns(bool){
        return block.number>0;
    }
    function bad3() external returns(bool){
        return block.coinbase!=msg.sender;
    }
    function bad4() external returns(bool){
        return block.difficulty>0;
    }
    function bad5() external returns(bool){
        return block.gaslimit>0;
    }	
    function bad6() external{
        uint number = block.number;
        require(number == 20);
    }   
    function bad7() external{
        uint difficulty = block.difficulty;
        require(difficulty == 20);
    }   
    function bad8() external{   
        uint gaslimit = block.gaslimit;
        require(gaslimit == 20);
    }   
    
    function good() external returns(uint){
        emit Number(block.number);
    }
    function good1() external returns(uint){
        emit Coinbase(block.coinbase);
    }
    function good2() external returns(uint){
        emit Difficulty(block.difficulty);
    }
    function good3() external returns(uint){
        emit Gaslimit(block.gaslimit);
    }
}
