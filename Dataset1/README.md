# File and Folder introduction of Dataset1

## Contracts

The folder "Contracts" includes 158 smart contract source codes in Dataset_1.

## Detection_result

The file "results_dataset1.xlsx" describes the detection result of each method in detail.

## Metrics

We define the discovery of vulnerable contracts as a problem. By comparing the methods' detection results with the previous vulnerability labels, we can measure whether the problem occurs, which can be regarded as a binary classification. In this way, all problems found by methods are marked as true positive (TP), false positive (FP), and false negative (FN). TP indicate the vulnerable code was correctly identified. In contrast, FP and FN describe false detection. Note that due to the negative instances are challenging to be determined in scenarios of fine-grained contract vulnerability detection (i.e., a contract may have multiple vulnerable code of the same vulnerability), true negative (TN) cannot be calculated. Thus, the accuracy (ACC), precision (P), recall (R), and F-Measure (F1) are calculated as follows to evaluate each method, where $ \#TP $, $ \#FP $, and $ \#FN $ refer to the number of contracts marked accordingly.
$$
ACC = \frac{\#TP}{\#TP +\#FP + \#FN} \\
	P = \frac{\#TP}{\#TP + \#FP}, R = \frac{\#TP}{\#TP + \#FN}, F1 = \frac{2 \times P \times R}{P + R}
$$
Furthermore, Time (T) and Memory (M) overheads are evaluated for method efficiency. 
