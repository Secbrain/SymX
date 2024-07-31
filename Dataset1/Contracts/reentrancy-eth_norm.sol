contract C {
    function CashOut(address bb) public
    {
        msg.sender.send(1 ether); //没有价格，重入不成功，所以不执行会误报，把这个换成.call的重入问题，得需要constructor添加payable
        msg.sender.call.value(1 ether)();
    }
    
    function() public payable{}
}
