pragma solidity 0.4.24;

contract Suicidal {
    address owner;

    function init() public {
        owner = msg.sender; //not check it, because so difficult
    }

    function false_selfdestruct() public{
        require(msg.sender == owner);
        selfdestruct(msg.sender);
    }
}
