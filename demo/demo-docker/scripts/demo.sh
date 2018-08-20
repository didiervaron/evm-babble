#!/bin/bash

set -eu

N=${1:-4}
PORT=${2:-8080}
SOL_FILE=${3:-"../nodejs/fund.sol"}
KEY_DIR=${4:-"conf/keystore"}
PWD_FILE=${5:-"conf/pwd.txt"}


ips="172.77.5,0"
for i in  $(seq 1 $(($N-1)))
do
    h=$(($i+5))
    ips="$ips,172.77.5.0.$h"
done

/usr/local/bin/node ../nodejs/demo.js --ips=$ips \
    --port=$PORT \
    --contract=$SOL_FILE \
    --keystore=$KEY_DIR \
    --pwd=$PWD_FILE
