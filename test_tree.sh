#!/bin/bash

folder_recurse(){
cd "$1"
#echo "$1 $arg2"
for i in *
    do
    	for ((x=0; $x<$depth-1; x++))
    	do
    		printf "   ";
		done
        if [ -d "$i" ]
        	then
        	if [ "$arg2" == "-f" ]
        		then
        		echo "|-- `pwd`/$i"
        	else
            	echo "|-- $i"
            fi
            dir=`expr $dir + 1`
        elif [ -f "$i" ] 
        	then
        	if [ "$arg2" != "-d" ] && [ "$arg2" != "-f" ] 
        		then
            	echo "|-- $i"
            elif [ "$arg2" == "-f" ]
            	then
            	echo "|-- `pwd`/$i"
            else
            	echo -ne "\r\033/"
        	fi
            files=`expr $files + 1`
        fi
        if [ -d "$i" ]
        	then
        	depth=$depth+1
        	folder_recurse "$i";
        	cd ".."
        fi
    done
    depth=$depth-1
}

if [ -d "$1" ]
	then
	depth=1
	dir=0
	files=0
	arg2="$2"
	pattern="$3"
	echo "$1"
	folder_recurse "$1"
	echo "$dir directories, $files files"
else
	echo "No such folder"
fi
