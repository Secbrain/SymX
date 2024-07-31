contract Integeroverflow {

    function withdraw() public returns (uint)
    {
        uint c = 0;
        for(uint i=0; i<5; i++){
            c = c + 1;
        }
        return c;
    }

}
