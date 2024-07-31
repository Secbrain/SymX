/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 30
 */

pragma solidity >=0.4.11;

contract Owned {
    function Owned() {
        owner = msg.sender;
    }

    address public owner;

    // This contract only defines a modifier and a few useful functions
    // The function body is inserted where the special symbol "_" in the
    // definition of a modifier appears.
    modifier onlyOwner { if (msg.sender == owner) _; }

    function changeOwner(address _newOwner) public {
        owner = _newOwner;
    }

    // This is a general safty function that allows the owner to do a lot
    //  of things in the unlikely event that something goes wrong
    // _dst is the contract being called making this like a 1/1 multisig
    function execute(address _dst, uint _value) onlyOwner {
        // <yes> <report> UNCHECKED_LL_CALLS
        _dst.call.value(_value)();
    }
}
