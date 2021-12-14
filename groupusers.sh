#!/bin/bash
file="/etc/group"
f=0
name=""
for opt in "$@"
do
	if [[ f=1 ]]
	then
	    file=$opt
	    f=2
	elif [[ $f = 0 && $opt = "-f" ]]
	then
	    f=1
	else
	    name=$opt
	fi
done
if ! [[ -f $file ]]
then
	echo "file is not exist" >&2
	exit 2
fi
grep "$name:*" $file
if ! [[ $? = 0 ]]
then
echo "don't find this group" >&2
exit 1
fi
grep "$name:*" $file | cut -d ":" -f 4 | cut -d "," -f 1- | while read -d "," file; do echo $file; done

