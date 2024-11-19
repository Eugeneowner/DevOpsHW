#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename=$1

if [ ! -f "$filename" ]; then
  echo "Error: File '$filename' does not exist or is not a regular file."
  exit 1
fi

if [ ! -r "$filename" ]; then
  echo "Error: File '$filename' is not readable."
  exit 1
fi

line_count=$(wc -l < "$filename")

echo "The file '$filename' contains $line_count lines."

