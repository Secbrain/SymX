/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 41
 */
 
pragma solidity ^0.4.19;

contract ETH_VAULT
{
    mapping (address => uint) public balances;
    
    uint public MinDeposit = 1 ether;
    
    function Deposit()
    public
    payable
    {
        if(msg.value > MinDeposit)
        {
            balances[msg.sender]+=msg.value;
        }
    }
    
    function CashOut(uint _am)
    public
    payable
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
