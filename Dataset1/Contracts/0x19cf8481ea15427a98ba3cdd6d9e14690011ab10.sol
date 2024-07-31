/*
 * @source: etherscan.io 
 * @author: -
 * @vulnerable_at_lines: 439,465
 */

//DAO Polska Token deployment
pragma solidity ^0.4.11;

//  daoPOLSKAtokens
contract daoPOLSKAtokens{

    string name = "DAO POLSKA TOKEN version 1";
    string symbol = "DPL";
    uint8 constant decimals = 18;  // 18 decimal places, the same as ETC/ETH/HEE.

    // Receives 
    address owner;
    address migrationMaster;	
    // The current total token supply.

    uint256 otherchainstotalsupply =1.0 ether;
    uint256 supplylimit      = 10000.0 ether;
	//totalSupply   
   uint256  totalSupply      = 0.0 ether;
	//chains:

	address migrationAgent=0x8585D5A25b1FA2A0E6c3BcfC098195bac9789BE2;
    uint256 totalMigrated;

  //tokenCreationCap
  bool supplylimitset = false;
  bool otherchainstotalset = false;
   
  function daoPOLSKAtokens() {
owner=msg.sender;
migrationMaster=msg.sender;
}

     // Crowdfunding:
uint tokenCreationRate=1000;
uint bonusCreationRate=1000;
uint CreationRate=1761;
   uint256 constant oneweek = 36000;
uint256 fundingEndBlock = 5433616;
bool funding = true;
bool refundstate = false;
bool migratestate= false;
	
    function PartialFundsTransfer(uint SubX) external {
	      if (msg.sender != owner) throw;
        // <yes> <report> UNCHECKED_Send
        owner.send(this.balance - SubX);
	}


    // notice Finalize crowdfunding clossing funding options
	
function finalize() external {
        if (block.number <= fundingEndBlock+8*oneweek) throw;
        // Switch to Operational state. This is the only place this can happen.
        funding = false;	
		refundstate=!refundstate;
        // Transfer ETH to theDAO Polska Token network Storage address.
        if (msg.sender==owner)
        // <yes> <report> UNCHECKED_Send
		owner.send(this.balance);
    }
	

}


//------------------------------------------------------
