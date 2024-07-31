contract MarketPlace {
    function transfer(uint x) { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
        uint a=x+1;//63d8f9 //StAs //integer-overflow(smartanalysis)
        uint b=2*x;//63d8f9 //StAs //integer-overflow(smartanalysis)
        a += 10;//63d8f9 //StAs //integer-overflow(smartanalysis)
    }

}
