contract Holder {
    uint public holdUntil;
    address public holder;

    function Holder(uint period) public payable { //StAs //external-function(smartcheck)
        holdUntil = now + period; //StAs //integer-overflow(smartanalysis)
        holder = msg.sender;
    }

    function withdraw (uint a, uint b) external {
        if (now < holdUntil){ //StAs //timestamp(smartanalysis)、revert-require(smartanalysis)、block-other-parameters、timestamp(mythril)
            revert();
        }
        holder.transfer(this.balance); //StAs //arbitrary-send(smartanalysis)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、money_concurrency(oyente)
    }

    function withdraw_1 (uint a, uint b) external { //StAs //naming-convention(smartanalysis)
        if (now < holdUntil){ //StAs //timestamp(smartanalysis)、revert-require(smartanalysis)、block-other-parameters、timestamp(mythril)
            throw; //StAs //deprecated-standards(smartanalysis)
        }
        holder.transfer(this.balance); //StAs //arbitrary-send(smartanalysis)、Transaction Order Affects Ether Amount(securify)、unchecked-send(securify)、money_concurrency(oyente)
    }

}
