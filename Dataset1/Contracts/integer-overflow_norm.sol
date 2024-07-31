contract Integeroverflow {

    function withdraw(uint x) public returns (uint)
    {
        uint c = 0;
        uint d = x % 7;

        for(uint i=0; i<d; i++){
            c = c + 1;
        }
        return c;
    }
}
