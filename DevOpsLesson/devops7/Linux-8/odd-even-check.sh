#!/bin/bash

echo -n "Enter a number: "; read number

#if [ $(( number % 2 == 0 )) ]; then
#	echo "The number ${number} is even"
#else 
#	echo "The number ${number} is odd"
#fi

if [ "$(( number % 2 ))" -eq 0 ]; then
	echo "The number ${number} is event"
else
	echo "The number ${number} is odd"
fi
