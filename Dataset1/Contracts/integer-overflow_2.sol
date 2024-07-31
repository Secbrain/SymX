contract C {
    address owner;

    constructor() { owner = msg.sender; }

    function legit1(uint x, uint y) returns (uint){
        if(x < 5){
            return 0;
        }
        else{
            return y + 5;
        }
    }
}
