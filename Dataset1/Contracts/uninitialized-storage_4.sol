contract Uninitialized{

    uint ee = 2;
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
        st_bug1.a = 5; // This can be missed
        ee = ee + 1; //this is error
        uint ff = st_bug1.a + 1;
    }
}
