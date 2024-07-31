/*
 * @source: https://capturetheether.com/challenges/lotteries/guess-the-random-number/
 * @author: Steve Marx
 */

pragma solidity ^0.4.21; //StAs //solc-version(smartanalysis)

contract GuessTheRandomNumberChallenge {
    uint8 answer; //StAs //visibility(smartcheck)

    function GuessTheRandomNumberChallenge() public payable { //StAs //external-function(smartcheck)
        answer = uint8(keccak256(block.blockhash(block.number - 1), now)); //StAs //integer-overflow(smartanalysis)、deprecated-standards(smartanalysis)、upgrade-050(smartanalysis)
    }

    function isComplete() public view returns (bool) { //StAs //external-function(smartanalysis)
        return address(this).balance == 0; //StAs //incorrect-equality(smartanalysis)
    }

    function guess(uint8 n) public payable { //StAs //external-function(smartanalysis)
        require(msg.value == 1 ether);

        if (n == answer) { //StAs //incorrect-equality(smartanalysis)、block-other-parameters(smartanalysis)、timestamp(smartanalysis)
            msg.sender.transfer(2 ether); //StAs //arbitrary-send(smartanalysis)、unchecked-send(securify)
        }
    }
}
