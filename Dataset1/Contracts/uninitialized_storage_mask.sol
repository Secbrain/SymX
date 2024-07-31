contract Uninitialized{

    struct St{
        uint a;
    }

    function func() public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        St st; // non init, but never read so its fine //StAs //upgrade-050(smartanalysis)
        St memory st2;
        St st_bug; //StAs //uninitialized-storage(smartanalysis)、upgrade-050(smartanalysis)
        st_bug.a += 1; //StAs //integer-overflow(smartanalysis)、writeto-arbitrarystorage(securify)
    }    

}
