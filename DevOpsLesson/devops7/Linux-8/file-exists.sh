#!/bin/bash

echo -n "Enter the filename to check: "; read filename

if [ -e "${filename}" ]; then
	echo; echo; echo "The file ${filename} exists"
else
	echo; echo; echo "The file ${filename} does not exists"
fi
