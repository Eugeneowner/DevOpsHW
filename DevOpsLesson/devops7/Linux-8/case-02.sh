#!/bin/bash

read -p "Enter time: " hour

case $hour in
	0|1|2|3|4|5|6)
		echo "Good night"
		;;
	7|8|9|10|11|12)
		echo "Good morning"
		;;
	13|14|15|16|17|18)
		echo "Good day"
		;;
	18|19|20|21|22)
		echo "Good evening"
		;;
	*)
		echo "Wrong hour"
		;;
esac
