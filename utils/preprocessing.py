#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    Author: Gaomin Wu / wugm@ruyi.ai
    Time: 2021/6/30 9:07 上午
    TODO:
"""
import pandas
import logging
from sklearn.model_selection import train_test_split
from kg2020util.util.core import main_subtask


def task_train_test_val_split(args=None):
    """
    train:dev:test=8:1:1
    :param args:
    :return:
    """
    output_dir = args['output']
    df = pandas.read_csv(args['input'], header=0, sep=',', names=['label', 'review'])
    y = df['label']
    X = df['review']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=50)

    X_train, X_val, y_train, y_val = train_test_split(X_train, y_train, test_size=0.125,
                                                      random_state=50)  # 0.125 x 0.8 = 0.1
    logging.info(f'Train size:{y_train.shape}, Dev size:{y_val.shape}, Test size:{y_test.shape}')
    write_df(X_train, y_train, 'train', output_dir)
    write_df(X_test, y_test, 'test', output_dir)
    write_df(X_val, y_val, 'dev', output_dir)


def write_df(x, y, set_type, output_dir):
    df = pandas.concat([y, x], axis=1)
    df.to_csv(f'{output_dir}/{set_type}.tsv', header=0, index=0, sep='\t')


if __name__ == '__main__':
    logging.basicConfig(format='[%(asctime)s %(levelname)s][%(module)s][%(funcName)s][%(lineno)s] %(message)s',
                        level=logging.INFO)

    optional_params = {
        '--input': '输入（文件名或字符串',
        '--output': '输出（文件名或字符串）',
    }
    main_subtask(__name__, optional_params=optional_params)
    '''
    python -m utils.preprocessing task_train_test_val_split --input data/ChnSentiCorp_htl_all.csv --output data/
    '''
