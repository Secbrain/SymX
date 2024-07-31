contract MyConcbase{
    bool cfg = true; //StAs //constable-states(smartanalysis)、unused-state(smartanalysis)、visibility(smartcheck)
    address _owner; //StAs //uninitialized-state(smartanalysis)、naming-convention(smartanalysis)、constable-states(smartanalysis)、visibility(smartcheck)
    bool flag5; //StAs //visibility(smartcheck)
    uint a; //StAs //visibility(smartcheck)
    constructor() { //StAs //visibility(smartanalysis)
		a = 5;
		flag5 = true;
    }
}

contract MyConc is MyConcbase{

    bool flag6; //StAs //visibility(smartcheck)
    bool flag4 = false; //StAs //constable-states(smartanalysis)、visibility(smartcheck)
    function MyConc() //StAs //visibility(smartanalysis)
    {
		a = 4;
		flag6 = false;
    }

    function bad(bool flag) external{
        if(flag == true){ //StAs //boolean-equal(smartanalysis)
		a = 1;	//bad
		}
    }
    function bad1(bool flag) external{
        if(flag == false){ //StAs //boolean-equal(smartanalysis)
		a = 1;	//bad
		}
    }
    function bad2(bool flag) external{
        if(flag != true){ //StAs //boolean-equal(smartanalysis)
		a = 1;	//bad
		}
    }
    function bad3(bool flag) external{
		bool flag1 = flag;
        while(flag1 == true){ //StAs //boolean-equal(smartanalysis)、costly-loop(smartanalysis)
		    flag1 = false;
		}
    }
    function bad4(bool flag) external{
		require(flag == true); //StAs //boolean-equal(smartanalysis)
    }
    function bad5(bool flag) external{
		assert(flag == true); //StAs //assert-violation(smartanalysis)、boolean-equal(smartanalysis)、Exception State(mythril)
    }
    function bad6(bool flag) external{
		bool flag2 = true;
		if(flag == flag2){a = 1;} //StAs //boolean-equal(smartanalysis)
    }
    function bad7(bool flag) external{
		(bool flag3,uint ss) = (true, 0);
		if(flag == flag3){a = 1;} //StAs //boolean-equal(smartanalysis)
    }

    function bad8(bool flag) external{
		if(flag == flag4){a = 1;} //StAs //boolean-equal(smartanalysis)
		if(flag == flag5){a = 2;} //StAs //boolean-equal(smartanalysis)
		if(flag == flag6){a = 3;} //StAs //boolean-equal(smartanalysis)
    }

    function bad9(bool flag) external{
		bool flag7 = true && false; //StAs //boolean-cst(smartanalysis)
		if(flag == flag7){a = 1;} //StAs //boolean-equal(smartanalysis)
    }
    function bad10(bool flag) external{
		bool flag8 = 1 >= 0; //StAs //tautology(smartanalysis)
		if(flag == flag8){a = 1;} //StAs //boolean-equal(smartanalysis)
    }
    function bad11(bool flag) external{
        bool flag7 = true && false; //StAs //boolean-cst(smartanalysis)
        bool flag8 = 1 >= 0; //StAs //tautology(smartanalysis)
		bool flag9 = flag7 || flag8; //StAs //boolean-cst(smartanalysis)
		if(flag == flag9){a = 1;} //StAs //boolean-equal(smartanalysis)
    }
    function bad12(bool flag) external{
    	bool flag2 = true;
		bool flag10 = !flag2; //StAs //boolean-cst(smartanalysis)
		if(flag == flag10){a = 1;} //StAs //boolean-equal(smartanalysis)
    }

    function good(bool flag) external{
        if(flag){
		a = 1;	//good
		}
    }
    function good1(bool flag) external{
        bool flag1 = flag;
        while(flag1){ //StAs //costly-loop(smartanalysis)
		    flag1 = false;
		}
    }

    function good2(bool flag) external{      
		require(flag);
    }
    function good3(bool flag) external{
		assert(flag); //StAs //assert-violation(smartanalysis)
    }
}
