contract Reentrance {
    mapping (address => uint) userBalance;
    bool blockflag = true;
   
    function getBalance(address u) constant returns(uint){
        return userBalance[u];
    }

    function addToBalance() payable{
        userBalance[msg.sender] += msg.value;
    }

    function withdrawBalance(){
        // send userBalance[msg.sender] ethers to msg.sender
        // if mgs.sender is a contract, it will call its fallback function
        if(blockflag){
            blockflag = false;
            if( ! (msg.sender.call.value(userBalance[msg.sender])() ) ){
            revert();
            }
            userBalance[msg.sender] = 0;
            blockflag = true;
        }  
    }
}
