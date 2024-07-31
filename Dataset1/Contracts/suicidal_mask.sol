
contract C{
    address owner; //StAs //uninitialized-state(smartanalysis)、constable-states(smartanalysis)、visibility(smartcheck)、State variables default visibility(securify2)

    function i_am_a_backdoor() public{ //StAs //suicidal(smartanalysis)、naming-convention(smartanalysis)、external-function(smartanalysis)、backdoor(slither)
        selfdestruct(msg.sender); //bad //StAs //low-level-calls(smartanalysis)、suicidal(securify2)
    }

    function selfdestruct_1() public{ //StAs //suicidal(smartanalysis)、naming-convention(smartanalysis)、external-function(smartanalysis)
        address aa = msg.sender;
        selfdestruct(msg.sender); //bad //StAs //low-level-calls(smartanalysis)、suicidal(securify2)
    }

    //function init() public {
	//owner = msg.sender; //not check it, because so difficult
    //}

    function good_selfdestruct() public{ //StAs //naming-convention(smartanalysis)、external-function(smartanalysis)、suicidal(slither)
    	address aa = msg.sender;
    	require(aa == owner);
        selfdestruct(msg.sender); //StAs //low-level-calls(smartanalysis)
    }
}
