#!/bin/bash
read -p "Enter the file name: " filename

if [ -f "$filename" ]; then
  echo "You requested an existing file: '$filename'"
else
  echo "You requested a file that does not exist: '$filename'"
fi
