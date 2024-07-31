/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 201,213
 */

pragma solidity ^0.4.21;

contract PoCGame
{
    /**
     * Modifiers
     */
     
    modifier onlyOwner()
    {
        require(msg.sender == owner);
        _;
    }
    
   modifier isOpenToPublic()
    {
        require(openToPublic);
        _;
    }

    modifier onlyRealPeople()
    {
          require (msg.sender == tx.origin);
        _;
    }

    modifier  onlyPlayers()
    { 
        require (wagers[msg.sender] > 0); 
        _; 
    }
    
    /**
     * Events
     */
    event Wager(uint256 amount, address depositer);
    event Win(uint256 amount, address paidTo);
    event Lose(uint256 amount, address loser);
    event Donate(uint256 amount, address paidTo, address donator);
    event DifficultyChanged(uint256 currentDifficulty);
    event BetLimitChanged(uint256 currentBetLimit);

    /**
     * Global Variables
     */
    address private whale;
    uint256 betLimit;
    uint difficulty;
    uint private randomSeed;
    address owner;
    mapping(address => uint256) timestamps;
    mapping(address => uint256) wagers;
    bool openToPublic;
    uint256 totalDonated;

    /**
     * Constructor
     */
    constructor(address whaleAddress, uint256 wagerLimit) 
    public 
    {
        openToPublic = false;
        owner = msg.sender;
        whale = whaleAddress;
        totalDonated = 0;
        betLimit = wagerLimit;
        
    }
    
    function() public payable { }

    /**
     * Payout ETH to whale
     */
    function donateToWhale(uint256 amount) 
    public 
    {
        // <yes> <report> UNCHECKED_LL_CALLS
        whale.call.value(amount)(bytes4(keccak256("donate()")));
        totalDonated += amount;
        emit Donate(amount, whale, msg.sender);
    }

    /**
     * Payout ETH to whale when player loses
     */
    function loseWager(uint256 amount) 
    public 
    {
        // <yes> <report> UNCHECKED_LL_CALLS
        whale.call.value(amount)(bytes4(keccak256("donate()")));
        totalDonated += amount;
        emit Lose(amount, msg.sender);
    }

}
