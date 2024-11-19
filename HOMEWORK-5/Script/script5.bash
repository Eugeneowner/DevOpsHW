#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_file destination_file"
    exit 1
fi

SOURCE_FILE="$1"
DESTINATION_FILE="$2"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file '$SOURCE_FILE' does not exist."
    exit 2
fi

cp "$SOURCE_FILE" "$DESTINATION_FILE"

if [ "$?" -eq 0 ]; then
    echo "File copied successfully from '$SOURCE_FILE' to '$DESTINATION_FILE'."
else
    echo "Error: File copy failed."
    exit 3
fi
