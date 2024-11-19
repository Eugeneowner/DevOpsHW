#!/bin/bash

echo -n "Enter folder path: "; read dir_path

if [ -d "${dir_path}" ]; then
	echo "The folder ${dir_path} is exists"
else
	echo "The folder ${dir_path} does not exist!"
fi
