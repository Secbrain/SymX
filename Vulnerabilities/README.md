# The examples of contract vulnerabilities

**ID** | **Vulnerability Name** | **Severity** | **ID** | **Vulnerability Name** | **Severity**
--- | --- | --- | --- | --- | ---
RE     | reentrancy-eth          | High     | UCL    | unchecked-lowlevel      | Medium   
SU     | suicidal                | High     | UCS    | unchecked-send          | Medium      
CDC    | controlled-delegatecall | High     | TO     | tx-origin               | Medium      
AS     | arbitrary-send          | High     | TS    | timestamp              | Low      
UIS    | uninitialized-state     | High | BP    | block-other-parameters | Low
UIO    | uninitialized-storage    | High | LLC   | low-level-calls        | Info
TOD    | TOD-ether/receiver      | High     | MEZ   | msgvalue-equals-zero        | Info     
IE     | incorrect-equality      | Medium   | ST    | send-transfer          | Opt    
IO     | integer-overflow        | Medium   | BE    | boolean-equal          | Opt     

We combine the contract code to explain the vulnerability examples supported by SymX in terms of occurrence principle, severity, repair countermeasures, and insights at bytecode level.

## Vulnerability_description.xlsx

This document describes the description of vulnerabilities.

## Dangerous strict equalities (*incorrect-equality*)

```solidity
contract Crowdsale {
    address owner = msg.sender;
    modifier verify() {
        require(tx.origin == owner);
        require(this.balance == 100 ether;);
        _;
    }
}
```
Attackers can easily manipulate strict equality judgments (e.g., == and !=). Specifically, they can send Ethers to any address via the selfdestruct() function, thus making contract logic may fail to work.

**Severity:** *Medium* severity. IE can cause some non-core business verification to be bypassed, which causes the business logic not to function properly (*Medium* risk). Moreover, it has remarkable features and can be exploited deterministically (*exactly* utilization).

**Example:** In above code, *Crowdsale* relies on verify() to know when to stop the sale of tokens. *Crowdsale reaches 100 ETH. However, Bob sends 0.1 ETH by utilizing selfdestruct(). As a result, line 5 in verify() is always false and the crowd sale never ends.

**Improvements:** Developers can use ``>='' instead of strict equality to determine whether an account has enough Ethers.

**Possible insight at bytecode-level:** The BALANCE instruction is used to get the balance of a contract. If a BALANCE instruction is read by EQ, it means there is a strict balance equality check. If this check happens at a conditional jump expression, it means this contract contains this vulnerability.

## Transaction origin address (*tx-origin*)

```solidity
contract Crowdsale {
	address owner = msg.sender;
	modifier verify() {
		require(tx.origin == owner); _;
	}
	function func(address payable dst) payable verify(){
		dst.send(msg.value);
	}
}
```

As the transactions' underlying property, the origin address may be manipulated by attackers and is unsuitable for authentication. 

**Severity:** *Medium* severity. TO can bypass non-core business verification without provoking a direct economic loss (*Medium* risk). Moreover, it requires the combination of ancillary contracts to get transactions from the verified party (*probably* utilization).

**Example:** An attack scenario is depicted in above code. Bob is the owner of the *Crowdsale* contract. Bob invokes Eve's contract. Eve's contract calls *Crowdsale* and bypasses the tx.origin protection. Thus, line 4 in ''verify()'' modifier will lose its verification effect, making the contract abnormal.

**Improvements:** Don't use tx.origin for authentication.

**Possible insight at bytecode-level:** The EQ instruction reads two values from the EVM stack and verifies whether these values are equal. The tx.origin property generates an ORIGIN instruction. If the contract contains this vulnerability, there is an ORIGIN instruction that is read by an EQ instruction and compared to a 40-bit address value. Also, all addresses in Ethereum conform to the EIP55 standard \cite{SIAM_Depth}.

## Timestamp dependency (*timestamp*)

```solidity
contract Bockpara{
    uint time_now = 1577808000;
    function frangibility(uint input) public {
        require(block.timestamp > time_now);
        require(input == (block.number + 10));
        require(msg.sender.call.value(10 ether).gas(7777)(""));
    }
}
```
Dangerous usage of the block.timestamp. The block.timestamp can be manipulated by miners and nodes.

**Severity:** *Low* severity. TS can introduce security risks such as verification failure and random number utilization (*Low* risk). Moreover, it requires attackers to collude with miners or block nodes (*probably* utilization).

**Example:** As shown in above code, attackers can control the block.timestamp to pass the verification (line 4) by conspiring with miners or nodes.

**Improvements:** The block attributes such as timestamp should be avoided.

**Possible insight at bytecode-level:** Both the block.timestamp and now properties generate a TIMESTAMP instruction. Similar to Strict Balance Equality, if the conditional expression contains TIMESTAMP, it means the contract contains this vulnerability.

## Block Members Manipulation (*block-other-parameters*)

```solidity
contract Bockpara{
    uint time_now = 1577808000;
    function frangibility(uint input) public {
        require(block.timestamp > time_now);
        require(input == (block.number + 10));
        require(msg.sender.call.value(10 ether).gas(7777)(""));
    }
}
```
The object block contains many attributes (e.g., block.number), which can be predicted by miners and nodes. 

**Severity:** *Low* severity. BP violates the development specifications and can affect the operation stability of smart contracts (*Low* risk). Moreover, it requires attackers to collude with miners or nodes (*probably* utilization).

**Example:** In above code, attackers can predict the block.number by conspiring with miners or nodes, and then enter a precalculated input to pass the verification (line 5).

**Improvements:** Don't generate random numbers using data such as block.number that can be predicted by miners and nodes.

**Possible insight at bytecode-level:** Similar to Timestamp dependency, if the conditional expression contains block related instructions, i.e., BLOCKHASH, COINBASE, NUMBER, DIFFICULTY, GASLIMIT, it means the contract contains this vulnerability.

## Unchecked Low-level Calls (*unchecked-lowlevel*)

```solidity
contract MyConc{
    function func(address payable dst) public payable{
        dst.call.(bytes4(keccak256("expand(uint)")),1);
        dst.send(msg.value);
    }
}
```
Certain Solidity operations known as low-level calls, require the developer to manually ensure that the operation succeeded. This is in contrast to operations which throw an exception on failure. If a low-level call fails, but is not checked, the contract will continue execution as if the call succeeded. This will likely result in buggy and potentially exploitable behavior from the contract.

**Severity:** *Medium* severity. UL violates the development specifications and may cause some non-core business logic not to function properly (*Medium* risk). Moreover, it is triggered when the call function executes abnormally (*probably* utilization).

**Example:** The execution of the low-level call function returns success and failure instead of throwing an exception. As shown in above code, since the func function does not check the return value of the low-level call (line 4), it misleads the caller that the expand function has been executed exactly when the call invokes fails.

**Improvements:** Ensure that the return value of a low-level call is checked or logged.

**Possible insight at bytecode-level:** The low-level calls generate a CALL instruction with the gas limitation does not contain a specific value 2300. Furthermore, CALL returns 0 on error (e.g., out of gas) and 1 on success. If the result is checked by the contract, it will generate an ISZERO instruction, which judges whether it equals 0. If there is a CALL that meets the above conditions and is not read/checked by ISZERO, this vulnerability is detected.

## Unchecked Send (*unchecked-send*)

```solidity
contract MyConc{
    function func(address payable dst) public payable{
        dst.call.(bytes4(keccak256("expand(uint)")),1);
        dst.send(msg.value);
    }
}
```
Similar to *unchecked-lowlevel*, this vulnerability emphasizes that the return value of the send function is not checked, as the send function focuses on transfer operations and has explicit gas limits (namely 2300).

**Severity:** *Medium* severity. US may cause some non-core business logic not to function properly and steal small assets (*Medium* risk). Moreover, it is triggered when the send function executes abnormally (*probably* utilization).

**Example:** In above code, the return value of send is not checked (line 5), so if the send fails, the transfer operation will not be completed and the Ethers will be locked in the contract.

**Improvements:** Ensure that the return value of send is checked or logged, or use the tranfer function.

**Possible insight at bytecode-level:** The address.send() generates a CALL instruction, which satisfies (i) the gas limitation contains a specific value 2300; (ii) the transfer amount is larger than 0. Similar to unchecked-lowlevel, if there is a CALL that meets these conditions and is not read/checked by ISZERO, this vulnerability is detected.

## Calls with poor safety (*low-level-calls*)

```solidity
contract MyConc{
    function func(address payable dst) public payable{
        dst.call.(bytes4(keccak256("expand(uint)")),1);
        dst.send(msg.value);
    }
}
```
The use of low-level calls (e.g., call, delegatecall and callcode) is error-prone and they don't check for code existence or call success.

**Severity:** *Info* severity. LLC is prone to cause contract errors so that it is necessary to focus on the use of these functions (*Info* risk). Moreover, it can be called by executing the vulnerable code (*exactly* utilization).

**Example:** As shown in above code, the func function used low-level call to invoke the external function, which are vulnerable to attackers.

**Improvements:** Avoid low-level calls and check the call success. If the call is meant for a contract, check for code existence.

**Possible insight at bytecode-level:** Unlike unchecked-lowlevel, LLC is designed to highlight the low-level calls and draw the attention of developers. Thus, LLC is detected if there is a CALL instruction with the gas limitation that does not contain a specific value ``2300''.