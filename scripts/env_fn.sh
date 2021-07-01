#!/usr/bin/env bash


function print() {
    local ts=`date "+%F, %H:%M:%S"`
    echo $ts, $*
}



function get_bare_name() {
    local file_path="$1"
    local file_name="${file_path##*/}"
    local bare_name="${file_name%%.*}"
    echo $bare_name
}
