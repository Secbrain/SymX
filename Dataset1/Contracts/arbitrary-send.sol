contract Arbitrarysend {
    mapping (address => uint) userBalance;
    
    function arbitrary_send_true4(address bb) public
    {
        uint cc = userBalance[msg.sender];
        //userBalance[msg.sender] = 0;
        msg.sender.send(cc); //false report
    }

    function addToBalance() payable{
        userBalance[msg.sender] += msg.value;
    }

    function() public payable{}
}
