/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 52
 */

pragma solidity ^0.4.19;

contract PrivateDeposit
{
    mapping (address => uint) public balances;
        
    uint public MinDeposit = 1 ether;
    address public owner;
    
    modifier onlyOwner() {
        require(tx.origin == owner);
        _;
    }

    function Deposit()
    public
    payable
    {
        if(msg.value >= MinDeposit)
        {
            balances[msg.sender]+=msg.value;
        }
    }
    
    function CashOut(uint _am) public
    {
        if(_am<=balances[msg.sender])
        {            
            // <yes> <report> REENTRANCY
            if(msg.sender.call.value(_am)())
            {
                balances[msg.sender]-=_am;
            }
        }
    }
    
    function() public payable{}    
    
}
