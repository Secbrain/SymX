contract C {
    uint n;
    function C(uint x) {
        n = x;
    }
    function f(uint x) payable public returns (uint) {
        if (x == n) {
            return 5;
        }
        else if (x == 3) {
            return 10;
        }
        else{
            return 20;
        }
    }
    function g(uint x) payable public returns (uint) {
        if (x == n) {
            return 5;
        }
        else {
            return 20;
        }
    }
}
contract D {
    uint n;
    function f(address cc, uint x) payable public returns (uint) {
        C c = C(cc);
        uint dd = c.f(x);
        uint ee = 2;
        return dd;
    }
}
