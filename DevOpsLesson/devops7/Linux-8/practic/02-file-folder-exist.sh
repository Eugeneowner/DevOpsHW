#!/bin/bash

read -p "Enter a path: " path

if [ -e ${path} ]; then
	if [ -f ${path} ]; then
		echo "${path} is a file"
	elif [ -d ${path} ]; then
		echo "${path} is a directory"
	else
		echo "${path} is another type"
	fi
else
	echo "The path ${path} does not exists!"
fi
