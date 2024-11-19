#!/bin/bash

echo -n "Enter a string: "; read input_string

if [ -z "${input_string}" ]; then
	echo "The string is empty"
	exit 3
else
	echo "You entered: ${input_string}"
fi

echo "Hello"
echo "World"

/root/bash/odd-even-check.sh
