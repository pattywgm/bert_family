#!/usr/bin/env bash

split_fn=$1
python -m utils.preprocessing $split_fn --input data/ChnSentiCorp_htl_all.csv --output data