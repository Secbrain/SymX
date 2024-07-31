contract SolidityUncheckedSend {
    function operator(uint16 a, uint16 b) public{
        uint16 qq = a - b; //StAs //divide-before-multiply(smartanalysis)、integer-overflow(smartanalysis)
    }
    function operator3(uint a, uint b) public returns(uint){
        uint qq = a * b; //StAs //divide-before-multiply(smartanalysis)、integer-overflow(smartanalysis)
        return qq;
    }
}
