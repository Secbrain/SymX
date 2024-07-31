# The examples of contract vulnerabilities

| **ID** | **Vulnerability Name**  | **Severity** | **ID** | **Vulnerability Name** | **Severity** |
| ------ | ----------------------- | ------------ | ------ | ---------------------- | ------------ |
| RE     | reentrancy-eth          | High         | UCL    | unchecked-lowlevel     | Medium       |
| SU     | suicidal                | High         | UCS    | unchecked-send         | Medium       |
| CDC    | controlled-delegatecall | High         | TO     | tx-origin              | Medium       |
| AS     | arbitrary-send          | High         | TS     | timestamp              | Low          |
| UIS    | uninitialized-state     | High         | BP     | block-other-parameters | Low          |
| UIO    | uninitialized-storage   | High         | LLC    | low-level-calls        | Info         |
| TOD    | TOD-ether/receiver      | High         | MEZ    | msgvalue-equals-zero   | Info         |
| IE     | incorrect-equality      | Medium       | ST     | send-transfer          | Opt          |
| IO     | integer-overflow        | Medium       | BE     | boolean-equal          | Opt          |

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



# The Detection Logic of Vulnerability Detectors

## (1) reentrancy-eth (RE)

Ethereum provides three methods to transfer Ethers, i.e., address.send(), address.transfer(), and address.call().value(). These methods all generate a CALL instruction, which reads seven values from the EVM stack. The first three values represent the gas limitation, recipient address, and transfer amounts, respectively. The CALL instruction that meets the following conditions is almost generated by call().value(). (i) the gas limitation is larger than "2300''; (ii) the transfer amount is greater than 0. In addition, the SLOAD instruction is used to get a offset value (named *Slot ID*) from the EVM stack and puts the result read from storage back onto the stack [Ethereum_ledger]. If an SLOAD instruction is executed before the CALL instruction and its *Slot ID* are written by an SSTORE instruction after executing the CALL instruction, it means the CALL instruction can be executed again and cause Reentrancy problem. 

## (2) suicidal (SU)

Unprotected calls to a function executing selfdestruct or suicide statements, which generate a DELEGATECALL instruction to destroy the contract, may cause property damage and business interruption. In order to describe the unprotected behavior, the arbitrary caller address can be defined as there is at least one possible value of the symbolic caller, or the caller is "msg.sender''. In this way, this vulnerability can be detected by verifying that (i) the SELFDESTRUCT instruction can be executed and (ii) the caller belongs the arbitrary addresses. 

## (3) controlled-delegatecall (CDC)

The delegatecall operation of the untrusted addresses may cause unexpected results, such as stealing the contract balance. It works through a DELEGATECALL instruction, so that this vulnerability can be identified by judging (i) the DELEGATECALL instruction is reachable and (ii) the caller is an arbitrary address. 

## (4) arbitrary-send (AS)

This vulnerability refers to the Ether transfer operation can be executed by everyone, since the identifiers of callers are not checked. In this way, it can be detected when the following three conditions are satisfied simultaneously. (i) The CALL instruction of the Ether transfer operation is reachable. (ii) The caller is a arbitrary address. (iii) The Ether value is larger than zero. 

## (5) uninitialized-state (UIS)

The uninitialized state variables may cause unexpected behavior, such as transfer the amount to the zero address. If a variable is meant to be initialized to zero, explicitly set it to zero to improve code readability. At first, uninitialized global variables refer to the value read by SLOAD instruction exists and is not set by the SSTORE instruction. Then, in order to distinguish this vulnerability and UIO, the offset value of SLOAD is further checked whether tainted by ADD instruction, i.e., "ADD'' label, since the member position of storage variables such as \textit{struct} type is calculated by adding the root and member offset of the storage. In this way, this vulnerability is identified when the read offset of SLOAD instruction is not tained by "ADD'' label. 

## (6) uninitialized-storage (UIO)

The uninitialized storage variables will cover the values of other global variables. As mentioned in the detection of UIS, this vulnerability involves the uninitialized global variables and the read offset of SLOAD instruction is tained by the "ADD'' label. Besides, the vulnerability has another situation in which the read offset of SSTORE instruction is tained by the "ADD'' label and the root offset of the storage is zero, which may cause the storage contents to be overwritten. 

## (7) tod-ether/receiver (TOD)

The varying transaction execution sequence may result in different results, so that attackers can prioritize their transactions and manipulate results by launching transactions with higher Gas. Thus, we detect this vulnerability by checking two symbolic transactions that meet the following conditions. (i) They read/story the same global state variables, i.e., the same offset of SLOAD/SSTORE instruction. (ii) The different results can be obtained by swap their sequences. 

## (8) incorrect-equality (IE)

This defect may make a part of code never be executed. It can be detected whether there is a conditional expression that contains the related pattern. BALANCE instruction is used to get the balance of a contract. Its result is tainted with label "BALANCE'' during the path exploration. If a value read by EQ is tainted by "BALANCE'', it means there is a strict check for balance equality in contract. 

## (9) integer-overflow (IO)

The overflow of arithmetic operations of signed and unsigned integers, including addition, subtraction, multiplication, division, modulo, and negation, can result in unexpected results such as withdrawing more Ether than previously deposited. In order to detect the possible overflow operations, we taint the calculation results of instructions such as ADD/SUB/MUL with the label "IOS/IOU'' (sighed/unsighed integers), and check them when the calculation finished by using solvers such as Z3 to solve the inputs that can trigger the integer overflow. Among them, the range of value type (e.g., Uint8) is the key to check values whether out of their scope, while the current tools such as Manticore \cite{ASE_Manticore} only works on Uint256/int256. Also, the paths that include the above situation but end abnormally may be false positives because the exceptions are caused by a "require'' or "assert'' statement that verifies the overflow. 

## (10) unchecked-lowlevel (UCL)

The external call returns a boolean value. If the contract does not check it, the remaining code will continue to be executed when the call fails, causing unexpected behaviors. For example, the user's deposits are reduced but does not get the corresponding Ether. In order to detect this defect, we first locate unchecked CALL instructions by checking whether their return values or taints are read by ISZERO instruction, generated by the condition expression. Then, we determine that CALL is generated by call().value(), which is detailed in the detection of RE. 

## (11) unchecked-send (UCS)

Similar to UCL, this defect can be detected by verifying that unchecked CALL instructions are derived from address.send(), whose gas limitation is a specific value "2300''. 

## (12) tx-origin (TO)

Attackers can bypass the check of tx.origin by using the intermediate calls. In order to identify this defect, we first locate the ORIGIN instruction, which is generated by tx.origin. We then taint its result and check whether there is a taint that is read by an EQ instruction, which is responsible for judging equal values. If the contract contains this kind of contract defect ORIGIN instruction will compare to an address value. Ethereum uses a 40-bit value to indicate an address, and all addresses conform to the EIP55 standard. 

## (13) timestamp (TS)

This defect can allow miners to know the timestamp value previously and further obtain random values. Similar to the detection of IE, the result of TIMESTAMP instruction is tainted by the label "TIMESTAMP'' and this defect will be reported if its taints are used in operations, such as conditional judgments and numerical operations. 

## (14) block-other-parameters (BP)

Similar to TS, this defect can be identified if the taints of other block related instructions are used in operations, e.g., BLOCKHASH, COINBASE, NUMBER, DIFFICULTY, GASLIMIT, and GASPRICE. 

## (15) low-level-calls (LLC)

This informal item is designed to highlight CALL instruction of call().value(), whose gas limitation is not a specific value "2300''. 

## (16) msgvalue-equals-zero (MEZ)

Determining whether msg.value is zero sometimes has no effect. This item can be first located by identifying the CALLVALUE instruction, which is generated by the statement "msg.value''. Meanwhile, its result value is stored in the global context and tainted with "CALLVALUE'' label. Then, this item is detected when the arguments of EQ instruction are zero value and previous stored value (also tainted with "CALLVALUE''). 

## (17) send-transfer (ST)

The operation address.send() can be replaced with address.transfer() to improve the contract security. Thus, this optimization is designed to detect the send operation that meets the following conditions. (i) The gas limitation of CALL instruction is "2300''. (ii) The number of ISZERO instructions until the end of the block is less than 2, so as to distinguish send and transfer operations. 

## (18) boolean-equal (BE)

The boolean variables used in equal judgment waste additional Gas. This optimization can be identified when there exists an EQ instruction whose arguments include boolean values input by PUSH instructions (otherwise false positives), i.e., False (0) and True (1). 