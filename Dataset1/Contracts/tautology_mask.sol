contract tautologies{ //StAs //naming-convention(smartanalysis)
    function bad5(uint8 y) public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
		if(y != 256){ //StAs //tautology(smartanalysis)
		    uint8 z = y + 1;//good
		}
    }

    function bad7(uint8 y) public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
		uint aa = 256;
		if(y != aa){ //StAs //tautology(smartanalysis)
		    uint8 z = y + 1;
		}
    }

    function bad6(uint8 x) public { //StAs //external-function(smartanalysis)、visibility(smartanalysis)
		if(x == 257){ //StAs //tautology(smartanalysis)
		    uint8 z = x + 1;
		}
    }
}
