### 2021-06-30
* 初始化创建项目
* 切分语料
```
  sh scripts/run_dataset_preprocess.sh task_train_test_val_split
```
### 2021-07-01
* 运行模型
 ```shell script
 bash scripts/run_classification.sh bert bert
 bash scripts/run_classification.sh bert_wwm bert
 bash scripts/run_classification.sh chinese_macbert bert
 bash scripts/run_classification.sh roberta bert
 bash scripts/run_classification.sh albert albert
 ``` 
