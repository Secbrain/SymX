contract MarketPalce{
	uint256 public price;
	uint256 public stock=20; //public allow to access it by call stock()
	address public owner;
	function updateprice(uint _price) public
	{
		price = _price;
	}
	function buy(uint quant) public
	{
		if(msg.value < quant * price ){ throw;}
		stock = stock - quant;
	}
}
