/*
 * @source: http://blockchain.unica.it/projects/ethereum-survey/attacks.html#governmental
 * @author: -
 * @vulnerable_at_lines: 27
 */

//added pragma version
pragma solidity ^0.4.0;

contract Governmental {
  address public owner;
  address public lastInvestor;
  uint public jackpot = 1 ether;
  uint public lastInvestmentTimestamp;
  uint public ONE_MINUTE = 1 minutes;

  function Governmental() payable {
    owner = msg.sender;
  }

  function invest() public payable {
    if (msg.value<jackpot/2) throw;
    lastInvestor = msg.sender;
    jackpot += msg.value/2;
    // <yes> <report> TIME_MANIPULATION
    lastInvestmentTimestamp = block.timestamp;
    jackpot += lastInvestmentTimestamp;
  }
}
