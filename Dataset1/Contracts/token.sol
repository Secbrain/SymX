/*
 * @source: https://github.com/sigp/solidity-security-blog
 * @author: Steve Marx
 * @vulnerable_at_lines: 20,22
 */

 pragma solidity ^0.4.18;

 contract Token {

   mapping(address => uint) balances;
   uint totalSupply;

   function Token(uint _initialSupply) public {
     balances[msg.sender] = totalSupply = _initialSupply;
   }

   function transfer(address _to, uint _value) public returns (bool) {
     // <yes> <report> ARITHMETIC
     balances[msg.sender] -= _value;
     balances[_to] += _value;
     return true;
   }
 }
