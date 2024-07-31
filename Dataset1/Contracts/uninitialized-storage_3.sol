contract Uninitialized{

    uint ee = 2;
    address destination;

    function transfer() payable public{
        destination.transfer(msg.value);
    }

    struct St{
        uint a;
    }

    St st_bug = St(5);

    function func() {
        St st; // non init, but never read so its fine
        St memory st2;
        ee = ee + 1;
        address cc = destination;
        uint ff = st_bug.a + 1;
    }

    function func2() {
        ee = ee + 1; //this is error
        uint ff = st_bug.a + 1;
    }
}
