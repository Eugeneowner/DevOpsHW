#!/bin/bash

echo -n "Enter a number: "; read number

if [ $number -lt 0 ]; then
	echo "The number ${number} is negative"
elif [ $number -gt 0 ]; then
       echo "The number ${number} is positive"
else
	echo "The ${number} is zero"
fi	
