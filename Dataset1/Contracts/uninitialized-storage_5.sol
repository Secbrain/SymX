contract C {
    
    uint n;
    uint m;
    struct St{
        uint a;
        uint b;
    }

    function mm(uint x) {
        St st;
        st.a = 7;
        st.b = 8;
    }

    St st1 = St(7,8);

    function ggg(uint x) {
        St memory st = St(1,2);
    }

    function ff() payable public returns (uint) {
        return n;
    }
    
    function fff() payable public returns (uint) {
        return m;
    }
}
