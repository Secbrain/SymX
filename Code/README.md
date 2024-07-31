# The source code

The code is shown in this dir, and we suggest the usage of docker. 

### The usage of SymX (in docker environment)

Update the current running dir. 

```bash
cd /symx/symx-master
```

Detect contract source code and output the detailed and simply reports.

```bash
/symx/symx-master/dist/method_testcase_num_contracts_sourcedetection_system/method_testcase_num_contracts_sourcedetection_system /symx/test/RealOldFuckMaker.sol 0.4.24 /data/RealOldFuckMaker1 all,main
```

Detect contract bytecode and output the detailed and simply reports.

```bash
/symx/symx-master/dist/method_testcase_num_contracts_binarydetection_system/method_testcase_num_contracts_binarydetection_system /symx/test/RealOldFuckMaker_bin.json /data/RealOldFuckMaker2 all,main
```

Detect contrac opcode and output the detailed and simply reports.

```bash
/symx/symx-master/dist/method_testcase_num_contracts_evmdetection_system/method_testcase_num_contracts_evmdetection_system /symx/test/RealOldFuckMaker_evm.json /data/RealOldFuckMaker3 all,main
```

Detect contrac source code.

```bash
/symx/symx-master/dist/method_testcase_num_contracts_sourcedetection/method_testcase_num_contracts_sourcedetection /symx/test/RealOldFuckMaker.sol 0.4.24 /data/RealOldFuckMaker1-1
```

Detect contrac bytecode.

```bash
/symx/symx-master/dist/method_testcase_num_contracts_binarydetection/method_testcase_num_contracts_binarydetection /symx/test/RealOldFuckMaker_bin.json /data/RealOldFuckMaker2-1
```

Detect contrac opcode.

```bash
/symx/symx-master/dist/method_testcase_num_contracts_evmdetection/method_testcase_num_contracts_evmdetection /symx/test/RealOldFuckMaker_evm.json /data/RealOldFuckMaker3-1
```

Identify contrac behavior with source code.

```bash
/symx/symx-master/dist/method_testcase_transaction_detection_source/method_testcase_transaction_detection_source /symx/test/RealOldFuckMaker.sol 0.4.24 /symx/test/user_0000000f.tx.json /data/RealOldFuckMaker1-2
```

Identify contrac behavior with bytecode.

```bash
/symx/symx-master/dist/method_testcase_transaction_detection_binary/method_testcase_transaction_detection_binary /symx/test/RealOldFuckMaker_bin.json /symx/test/user_0000000f.tx.json /data/RealOldFuckMaker2-2
```

Identify contrac behavior with opcode.

```bash
/symx/symx-master/dist/method_testcase_transaction_detection_evm/method_testcase_transaction_detection_evm /symx/test/RealOldFuckMaker_evm.json /symx/test/user_0000000f.tx.json /data/RealOldFuckMaker3-2
```

Identify contrac behavior with init transaction.

```bash
/symx/symx-master/dist/method_testcase_transaction_detection_tx/method_testcase_transaction_detection_tx /symx/test/user_0000000f_init.tx.json /symx/test/user_0000000f.tx.json /data/RealOldFuckMaker3-2
```

Validate detection result of *arbitrary-send* vulnerability.

```bash
/symx/symx-master/dist/arbitrary-send_transaction_verification/arbitrary-send_transaction_verification /symx/test/Arbitrarysend_validation.sol 0.4.24 /symx/test/Arbitrarysend_validation/user_00000005.tx.json /data/Arbitrarysend-1
```

Validate detection result of *reentrancy-eth* vulnerability.

```bash
/symx/symx-master/dist/reentrancy_transaction_verification/reentrancy_transaction_verification /symx/test/Reentrance_validation.sol 0.4.24 /symx/test/Reentrance_validation/user_00000001.tx.json /data/Reentrance-1
```

Validate detection result of *suicidal* vulnerability.

```bash
/symx/symx-master/dist/suicidal_transaction_verification/suicidal_transaction_verification /symx/test/Suicidal_validation.sol 0.4.24 /symx/test/Suicidal_validation/user_00000001.tx.json /data/Suicidal_validation-1
```