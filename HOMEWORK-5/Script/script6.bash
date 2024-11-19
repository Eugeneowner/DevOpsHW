#!/bin/bash

echo "Enter a sentence:"
read -r user_input

if [ -z "$user_input" ]; then
    echo "Error: No input provided. Please enter a sentence."
    exit 1
fi

reversed_sentence=$(echo "$user_input" | awk '{for(i=NF; i>0; i--) printf "%s ", $i; print ""}')

echo "Reversed sentence: $reversed_sentence"

