/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 14
 */

pragma solidity ^0.4.24;

contract Proxy  {
    modifier onlyOwner { if (msg.sender == Owner) _; } address Owner = msg.sender;
    function transferOwner(address _owner) public onlyOwner { Owner = _owner; } 
    function proxy(address target) public payable {
        // <yes> <report> UNCHECKED_LL_CALLS
        target.call.value(msg.value)();
    }
}
