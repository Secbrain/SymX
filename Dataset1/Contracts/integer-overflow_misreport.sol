contract Integeroverflow {
    function calsum(uint x) public returns (uint)
    {
        uint c = 0;
        for(uint i=1; i<=x; i++){
            c = c + i;
        }
        return c;
    }
}
