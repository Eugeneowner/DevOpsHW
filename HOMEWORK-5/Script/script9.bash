#!/bin/bash
if [ -z "$1" ]; then
  echo "Error: No file path provided. Usage: $0 <file_path>"
  exit 1
fi

file_path="$1"

if [ -e "$file_path" ]; then
  echo "File exists. Displaying contents:"
  echo "-----------------------------------"
  cat "$file_path"
  echo "\n-----------------------------------"
else
  echo "Error: File '$file_path' does not exist."
  exit 1
fi

