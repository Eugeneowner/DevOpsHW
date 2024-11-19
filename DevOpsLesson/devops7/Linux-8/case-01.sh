#!/bin/bash

read -p "Enter a path: " file_path

if [ -e ${file_path} ]; then
	echo "The path does not exists!"
	exit 1
fi

case $(file --mime-type -b "${file_path}") in
	text/plain)
		echo "The file is a plain text"
		;;
	application/pdf)
		echo "The file is a PDF doc"
		;;
	image/*)
		echo "The file is an image"
		;;
	*)
		echo "The file is unknown"
		;;
esac

if [ $(file --mime-type -b "${file_path}") == "text/plain" ]; then
	echo "The file is a plain text"
elif [ $(file --mime-type -b "${file_path}") == "application/pdf" ]; then
	echo "the file is a PDF doc"
fi
