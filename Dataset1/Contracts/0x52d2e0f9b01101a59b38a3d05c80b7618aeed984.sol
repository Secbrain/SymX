/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 27
 */

pragma solidity ^0.4.19;

contract EtherGet {
    address owner;
    function EtherGet() public {
        owner = msg.sender;
    }
    function withdrawEther() public {
        owner.transfer(this.balance);
    }
    function getTokens(uint num, address addr) public {
        for(uint i = 0; i < num; i++){
            // <yes> <report> UNCHECKED_LL_CALLS
            addr.call.value(0 wei)();
        }
    }
}
