# File and Folder introduction of Dataset3

## Transactions
The folder "Transactions" includes 11,964 contract transactions (2,762 benign and 9,202 malicious) in Dataset_3. Among them, the file "tx_labels.json" illustrates their labels, where 0 is safe and 1 is unsafe.

## Metrics

Due to the transaction identification baseline (i.e., ContractGuard) performs the binary classification, i.e., norm and abnormal, we collate fine-grained detection results of SymX for each transaction sequence to a binary result. In this way, the number $ \#TN $ of TN ( benign transaction sequence) can be calculated, and the ACC of transaction identification is computed as follows.
$$
	ACC(tx) = \frac{\#TP + \#TN}{\#TP + \#TN +\#FP + \#FN}
$$
Also, the precision, recall, F-Measure for transaction identification is the same to vulnerability detection. 
$$
P = \frac{\#TP}{\#TP + \#FP}, R = \frac{\#TP}{\#TP + \#FN}, F1 = \frac{2 \times P \times R}{P + R}
$$