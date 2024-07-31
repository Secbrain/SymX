/*
 * @article: https://blog.positive.com/predicting-random-numbers-in-ethereum-smart-contracts-e5358c6b8620
 * @source: https://etherscan.io/address/0xF767fCA8e65d03fE16D4e38810f5E5376c3372A8#code
 * @vulnerable_at_lines: 127,128,129,130,132
 * @author: -
 */

 //added pragma version
pragma solidity ^0.4.0;

 contract LuckyDoubler {
//##########################################################
//#### LuckyDoubler: A doubler with random payout order ####
//#### Deposit 1 ETHER to participate                   ####
//##########################################################
//COPYRIGHT 2016 KATATSUKI ALL RIGHTS RESERVED
//No part of this source code may be reproduced, distributed,
//modified or transmitted in any form or by any means without
//the prior written permission of the creator.

    address private owner;

    //Stored variables
    uint private balance = 0;
    uint private fee = 5;
    uint private multiplier = 125;

    uint[] private unpaidEntries;

    //Set owner on contract creation
    function LuckyDoubler() {
        owner = msg.sender;
    }

    modifier onlyowner { if (msg.sender == owner) _; }


    //Generate random number between 0 & max
    uint256 constant private FACTOR =  1157920892373161954235709850086879078532699846656405640394575840079131296399;
    // <yes> <report> BAD_RANDOMNESS
    function rand(uint max) public returns (uint256 result){
        uint256 factor = FACTOR * 100 / max;
        uint256 lastBlockNumber = block.number - 1;
        uint256 hashVal = uint256(block.blockhash(lastBlockNumber));

        return uint256((uint256(hashVal) / factor)) % max;
    }

    //Contract management
    function changeOwner(address newOwner) onlyowner {
        owner = newOwner;
    }
}
