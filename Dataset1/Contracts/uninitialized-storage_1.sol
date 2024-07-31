contract Uninitialized{

    struct St{
        address a;
    }

    modifier ceshi_modi(address ss) { //This cannot be executed!
        St st_bug1;
        if(st_bug1.a == ss) {}
        _;
    }

    function func(address ss) {
        St st_bug;
        if(st_bug.a == ss) {
            uint a = 0;
        }
    }
}
