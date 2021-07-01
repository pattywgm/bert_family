#!/usr/bin/env bash
BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export PROJECT_HOME="$(cd $BIN_DIR/.. && pwd)"
export MODEL_DIR=$HOME/bert_models