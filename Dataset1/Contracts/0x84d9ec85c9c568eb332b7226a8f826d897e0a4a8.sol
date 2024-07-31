/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 56
 */

pragma solidity ^0.4.16;

/// @author Bowen Sanders
/// sections built on the work of Jordi Baylina (Owned, data structure)
/// smartwedindex.sol contains a simple index of contract address, couple name, actual marriage date, bool displayValues to
/// be used to create an array of all SmartWed contracts that are deployed 
/// contract 0wned is licesned under GNU-3

/// @dev `Owned` is a base level contract that assigns an `owner` that can be
///  later changed
contract Owned {

    /// @dev `owner` is the only address that can call a function with this
    /// modifier
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    address owner;

    /// @notice The Constructor assigns the message sender to be `owner`
    function Owned() payable {
        owner = msg.sender;
    }

    function acceptOwnership(address _newOwner) public {
        owner = _newOwner;
    }

    // This is a general safty function that allows the owner to do a lot
    //  of things in the unlikely event that something goes wrong
    // _dst is the contract being called making this like a 1/1 multisig
    function execute(address _dst, uint _value, bytes _data) onlyOwner {
         // <yes> <report> UNCHECKED_LL_CALLS
        _dst.call.value(_value)(_data);
    }
}
