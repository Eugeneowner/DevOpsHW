#!/bin/bash

echo -n "Enter path: "; read path
ls ${path} > /dev/null 2> ./log.txt
exit=$?
if [ ${exit} -eq 0 ]; then
	echo "Command succeeded"
else
	echo "Command failed"
	echo "Exit code: ${exit}"
fi
