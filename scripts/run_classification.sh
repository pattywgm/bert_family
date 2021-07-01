#!/usr/bin/env bash
set -euox pipefail

BIN_DIR=./scripts
source $BIN_DIR/env_fn.sh
source $BIN_DIR/env_setting.sh


model_name=$1
pkg_name=$2

print "start to run ${model_name} classification  args: $@"
work_out_dir=$PROJECT_HOME/local/temp/${model_name}

if [ ! -d "${work_out_dir}" ]; then
  mkdir -p "${work_out_dir}"
fi

declare -A datasets
  datasets=(["albert"]=albert_small_zh_google
            ["chinese_macbert"]=chinese_macbert
            ["bert"]=chinese_L-12_H-768_A-12
            ["bert_wwm"]=bert-wwm)

dataset_name=${datasets["$model_name"]}
echo "dataset_name is ${dataset_name}"

BERT_BASE_DIR=$MODEL_DIR/$dataset_name
print "model dir is: ${BERT_BASE_DIR}"

python \
-u $PROJECT_HOME/${pkg_name}/run_classifier.py \
--task_name=sentiment_classification \
--do_train=true \
--do_eval=true \
--data_dir=$PROJECT_HOME/data \
--vocab_file=$BERT_BASE_DIR/vocab.txt \
--bert_config_file=$BERT_BASE_DIR/${model_name}_config.json \
--init_checkpoint=$BERT_BASE_DIR/${model_name}_model.ckpt \
--max_seq_length=128 \
--train_batch_size=16 \
--learning_rate=5e-5 \
--num_train_epochs=3 \
--output_dir=$work_out_dir/output \
--predict_batch_size=16 \
--eval_batch_size=16 \
--bert_dropout_rate=0.1