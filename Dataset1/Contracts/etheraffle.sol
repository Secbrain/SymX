/*
 * @article: https://blog.positive.com/predicting-random-numbers-in-ethereum-smart-contracts-e5358c6b8620
 * @source: https://etherscan.io/address/0xcC88937F325d1C6B97da0AFDbb4cA542EFA70870#code
 * @vulnerable_at_lines: 49,99,101,103,114,158
 * @author: -
 */

 pragma solidity ^0.4.16;

contract Ethraffle_v4b {
    struct Contestant {
        address addr;
        uint raffleId;
    }

    event RaffleResult(
        uint raffleId,
        uint winningNumber,
        address winningAddress,
        address seed1,
        address seed2,
        uint seed3,
        bytes32 randHash
    );

    event TicketPurchase(
        uint raffleId,
        address contestant,
        uint number
    );

    event TicketRefund(
        uint raffleId,
        address contestant,
        uint number
    );

    // Constants
    uint constant prize = 2.5 ether;
    uint constant fee = 0.03 ether;
    uint constant totalTickets = 1;
    uint constant pricePerTicket = (prize + fee) / totalTickets; // Make sure this divides evenly
    address feeAddress;

    // Other internal variables
    bool paused = false;
    uint raffleId = 1;
    // <yes> <report> BAD_RANDOMNESS
    uint blockNumber = block.number % 2;
    uint blockNumber_copy = blockNumber;
    uint nextTicket = 0;
    mapping (uint => Contestant) contestants;
    uint[] gaps;

    // Initialization
    function Ethraffle_v4b() public {
        feeAddress = msg.sender;
    }

    function buyTickets() payable public {
        
        uint moneySent = msg.value;

	uint currTicket = 0;
        contestants[currTicket] = Contestant(msg.sender, raffleId);
    }

    function chooseWinner() public {
        // <yes> <report> BAD_RANDOMNESS
        address seed1 = contestants[uint(block.coinbase) % totalTickets].addr;
        // <yes> <report> BAD_RANDOMNESS
        address seed2 = contestants[uint(msg.sender) % totalTickets].addr;
        // <yes> <report> BAD_RANDOMNESS
        uint seed3 = block.difficulty;
        bytes32 randHash = keccak256(seed1, seed2, seed3);

        uint winningNumber = uint(randHash) % totalTickets;
    }

}
