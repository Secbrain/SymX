/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 100,106,133
 */

// by nightman
// winner gets the contract balance
// 0.02 to play


pragma solidity ^0.4.23;

contract DrainMe {

//constants

address winner = 0x0;
address owner;
address firstTarget = 0x461ec7309F187dd4650EE6b4D25D93c922d7D56b;
address secondTarget = 0x1C3E062c77f09fC61550703bDd1D59842C22c766;
address[] players;

mapping(address=>bool) approvedPlayers;

uint256 secret;
uint256[] seed = [951828771,158769871220];
uint256[] balance;

//constructor

function DranMe() public payable{
	owner = msg.sender;
}

//modifiers

modifier onlyOwner() {
    require(msg.sender == owner);
    _;
}

modifier onlyWinner() {
    require(msg.sender == winner);
    _;
}

modifier onlyPlayers() {
    require(approvedPlayers[msg.sender]);
    _;
}

//functions

function setSecret(uint256 _secret) public payable onlyOwner{
	secret = _secret;
}

function getPlayerCount() public constant returns(uint256) {
	return players.length;
}

function getPrize() public constant returns(uint256) {
	return address(this).balance;
}

function becomePlayer() public payable{
	require(msg.value >= 0.02 ether);
	players.push(msg.sender);
	approvedPlayers[msg.sender]=true;
}

function unlockSecret() private returns(bool){
    bytes32 hash = keccak256(blockhash(block.number-1));
    uint256 secret = uint256(hash);
    winner = msg.sender;
    return true;
}

function callFirstTarget () public payable onlyPlayers {
	require (msg.value >= 0.005 ether);
	// <yes> <report> UNCHECKED_LL_CALLS
	firstTarget.call.value(msg.value)();
}

function callSecondTarget () public payable onlyPlayers {
	require (msg.value >= 0.005 ether);
	// <yes> <report> UNCHECKED_LL_CALLS
	secondTarget.call.value(msg.value)();
}

function winPrize() public payable onlyOwner {
	// <yes> <report> UNCHECKED_LL_CALLS
	owner.call.value(1 wei)();
}
//fallback function

function() public payable{
	}
}
