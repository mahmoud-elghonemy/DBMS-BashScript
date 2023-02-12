#!/bin/bash
#$DBname
# description: List Tables >>> Done
tables=`ls -F | grep -v / | grep -v !*.Mdata`

    if [[ "$tables" == "" ]]
        then
        echo "Nothing to list"
    else
        echo "$tables"
    fi

#ls -p | grep -v !*.Mdata | grep -v /    