contract Uninitialized{

    uint ee;
    address destination;

    function transfer() payable public{
        destination.transfer(msg.value);
    }

    struct St{
        uint a;
    }

    function func() {
        St st; // non init, but never read so its fine
        St memory st2;
        St st_bug;
        ee = ee + 1;
        address cc = destination;
        uint ff = st_bug.a + 1;
    }

    function func2() {
        St st_bug1;
        st_bug1.a = 5;
        ee = ee + 1; //this is error
        uint ff = st_bug1.a + 1;
    }

    function func1(uint a, uint b) {
        uint cc = (a&b) + 3;
        ee = ee + 1;
    }
}
