
pragma solidity ^0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)
/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
   防止整数溢出问题
 */
library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }
 
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b > 0); // Solidity automatically throws when dividing by 0 //StAs //assert-violation(smartanalysis)
    uint256 c = a / b;
    assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
 
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a); //StAs //assert-violation(smartanalysis)
    return a - b;
  }
 
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

contract Intergeroverflow{
    using SafeMath for uint256; //StAs //safemath(smartanalysis)
    
    function bad() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint a; //StAs //uninitialized-local(smartanalysis)
	uint c; //StAs //uninitialized-local(smartanalysis)
	if(!(a + c <=3)) {revert();} //StAs //revert-require(smartanalysis)
	uint b = a - 5; //StAs //integer-overflow(smartanalysis)
    }
    function good1() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint a; //StAs //uninitialized-local(smartanalysis)
	uint c; //StAs //uninitialized-local(smartanalysis)
	if(!(a + c >=3)) {revert();} //StAs //revert-require(smartanalysis)
	uint b = a - 5; //StAs no nteger-overflow //integer-overflow(smartanalysis)
    }

    function good5() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint a; //StAs //uninitialized-local(smartanalysis)
	if(!(a>=5)) {revert();} //StAs //revert-require(smartanalysis)
	uint b = a - 5;
    }

    function good4() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint a; //StAs //uninitialized-local(smartanalysis)
	uint b; //StAs //uninitialized-local(smartanalysis)
	if(!((a+b+5)>=5)) {revert();} //StAs //revert-require(smartanalysis)
	uint d = a + b + 5;
    }

    function good3() { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
	uint a; //StAs //uninitialized-local(smartanalysis)
	uint b; //StAs //uninitialized-local(smartanalysis)
	uint d = a + b + 5;
	if(!(d>=5)) {revert();} //StAs //revert-require(smartanalysis)
    }
}
