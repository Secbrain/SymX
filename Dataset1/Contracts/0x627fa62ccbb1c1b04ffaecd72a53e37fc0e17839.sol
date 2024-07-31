/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 44
 */

pragma solidity ^0.4.19;

contract Ownable
{
    address newOwner;
    address owner = msg.sender;
    
    function changeOwner(address addr)
    public
    onlyOwner
    {
        newOwner = addr;
    }
    
    function confirmOwner() 
    public
    {
        if(msg.sender==newOwner)
        {
            owner=newOwner;
        }
    }
    
    modifier onlyOwner
    {
        if(owner == msg.sender)_;
    }
}

contract Token is Ownable
{
    address owner = msg.sender;
    function WithdrawToken(address token, uint256 amount,address to)
    public 
    {
         // <yes> <report> UNCHECKED_LL_CALLS
        token.call(bytes4(sha3("transfer(address,uint256)")),to,amount); 
    }
}
