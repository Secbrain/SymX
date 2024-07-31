contract C {
    function bad(bool flag) external{
        if(flag == true){} // the content is none, so that the condition is not executed
    }
    function bad4(bool flag) external{
        if(flag == true){
			uint a = 2;
		}
    }
    function bad1(bool flag) external{
        if(flag == false){
			uint a = 2;
		}
    }
    function bad2(bool flag) external{
        if(flag != true){
			uint a = 2;
		}
    }
    function bad3(bool flag) external{
		bool flag1 = false;
        while(flag1 == true){
		    flag1 = false;
		}
    }
    function bad5() external{
		bool flag1 = (false == true);
        while(flag1 == true){
		    flag1 = false;
		}
    }
    function bad6() external{
		bool flag1 = (false == true);
        if(flag1){
		    flag1 = false;
		}
    }
    function bad7(bool flag) external{
        if(flag >= (true == (true==true))){
		    uint cc = 0;
		}
    }
    function good(bool flag) external{
        if(flag){}
    }
    function good2(bool flag) external{
        if(flag){
			uint a = 2;
		}
    }
}
