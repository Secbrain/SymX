contract Integeroverflow {
    function calsum(uint x, uint dd) public returns (uint)
    {
        uint c = 0;
        for(uint i=1; i<=dd; i++){
            c = c + x;
        }
        return c;
    }
}
