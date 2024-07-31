/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 29
 */

pragma solidity ^0.4.25;

contract WALLET
{
    function Put(uint _unlockTime)
    public
    payable
    {
        var acc = Acc[msg.sender];
        acc.balance += msg.value;
        acc.unlockTime = 0;
    }

    function Collect(uint _am)
    public
    payable
    {
        var acc = Acc[msg.sender];
        if( acc.balance>=MinSum && acc.balance>=_am && now>=acc.unlockTime)
        {
            // <yes> <report> REENTRANCY
            if(msg.sender.call.value(_am)())
            {
                acc.balance-=_am;
            }
        }
    }

    function() 
    public 
    payable
    {}

    struct Holder   
    {
        uint unlockTime;
        uint balance;
    }

    mapping (address => Holder) public Acc;

    uint public MinSum = 1 ether;    

}
