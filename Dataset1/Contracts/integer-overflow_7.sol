contract SolidityUncheckedSend {
    uint16 c;
    function operator(uint16 a, uint16 b) public returns(uint16){
        uint16 qq = a + b + c; //StAs //divide-before-multiply(smartanalysis)、integer-overflow(smartanalysis)
        return qq;
    }
    function operator_true(uint16 a, uint16 b) public returns(uint16){
        //uint16 dd = 5;
        uint16 qq = a + b + c; //StAs //divide-before-multiply(smartanalysis)、integer-overflow(smartanalysis)
        assert(qq>=a&&qq>=b&&qq>=c);
        return qq;
    }
    function operator3(uint a, uint b) public returns(uint){
        uint dd = 5;
        uint qq = dd + a - b; //StAs //divide-before-multiply(smartanalysis)、integer-overflow(smartanalysis)
        return qq;
    }
    function operator1(uint16 a, uint16 b) public returns(uint16){
        uint16 qq = a * b;
        return qq;
    }
    function operator2(uint16 a) public returns(uint16){
    //    uint a = 2**256-1; //StAs //divide-before-multiply(smartanalysis)、integer-overflow(smartanalysis)
        uint16 b = 4;
        uint16 qq = a * b;
        return qq;
    }
}
