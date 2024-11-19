#!/bin/bash

read -p "Enter a number: " number

if [ $number > 1 ]; then
	echo "Yes"
elif [ $number < 10 ]; then
	echo "Yes"
else
	echo "No"
fi


if [ $number > 1 -o $number < 10 ]; then
	echo "Yes"
else
	echo "No"
fi

if [ $number > 1 ] || [ $number < 10 ]; then
	echo "Yes"
else
	echo "No"
fi
