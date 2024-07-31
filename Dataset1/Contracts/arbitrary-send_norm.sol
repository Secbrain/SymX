contract Arbitrarysend {
    
    function arbitrary_send_true4(address bb) public
    {
        msg.sender.send(1 ether); //report but this cannot obtain moneys
    }

}
