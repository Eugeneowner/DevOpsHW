#!/bin/bash

read -p "Enter a command: " input

case $input in
	$(command -v ${input}))
		echo "${input} is a valid command"
		;;
	*@*)
		echo "This is email"
		;;	
