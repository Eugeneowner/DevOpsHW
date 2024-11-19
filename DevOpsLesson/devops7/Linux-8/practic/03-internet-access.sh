#!/bin/bash

ping -c 1 google.com &> /dev/null

if [ ! $? -eq 0 ]; then
	echo "Internet is working"
else
	echo "No Internet connection"
fi

