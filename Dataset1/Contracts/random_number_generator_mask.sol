pragma solidity ^0.4.24; //StAs //solc-version(smartanalysis)、solc-version(smartanalysis)

// Based on TheRun contract deployed at 0xcac337492149bDB66b088bf5914beDfBf78cCC18.
contract RandomNumberGenerator {
  uint256 salt =  5; //StAs //private-not-hidedata(smartanalysis)、constable-states(securify2)、unused-state(securify2)

  function random(uint max) view public returns (uint256 result) {
    // Get the best seed for randomness
    uint256 x = salt * 100 / max; //StAs //integer-overflow(smartanalysis)
    return x;
  }
  function random_1(uint max) view public returns (uint256 result) { //StAs //naming-convention(smartanalysis)
    // Get the best seed for randomness
    uint256 x = salt * 100 / max; //StAs //integer-overflow(smartanalysis)
    uint256 y = salt * block.number / (salt % 5); //StAs //integer-overflow(smartanalysis)
    uint256 seed = block.number / 3 + (salt % 300) + y; //StAs //integer-overflow(smartanalysis)
    uint256 h = uint256(blockhash(seed));
    // Random number between 1 and max
    return uint256((h / x)) % max + 1; //StAs //weak-prng(smartanalysis)、integer-overflow(smartanalysis)
  }
  function random_2(uint max) view public returns (uint256 result) { //StAs //naming-convention(smartanalysis)
    
    uint256 y = salt * block.number / (salt % 5); //StAs //integer-overflow(smartanalysis)
    uint256 seed = block.number / 3 + (salt % 300) + y; //StAs //integer-overflow(smartanalysis)
    
    return seed;
  }
  
}
