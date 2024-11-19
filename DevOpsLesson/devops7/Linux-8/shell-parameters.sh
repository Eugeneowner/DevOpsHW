#!/bin/bash

num1=$1
num2=$2

params=$*
params_array=$@

my_sum=$(( num1 + num2 ))
echo "Result: ${my_sum}"



echo "Params: ${params}"
echo "Array: ${params_array}"

echo "My script name: $0"
