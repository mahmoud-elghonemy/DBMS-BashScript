#!/bin/bash
# description: Droping Table 
read -p "Enter Table name you want to drop: " delTBName 
if [ ! ${#delTBName} -eq 0 ]
then
if [ -f  ./$delTBName ]
    then
        rm -r ./$delTBName
        rm -r ./$delTBName.Mdata
        echo "-----------------------------------"
        echo "$delTBName dropped Sucessfully :)"
        echo "-----------------------------------"
    else
        echo "Not Valid Table Name"
fi
else 
echo "You must input , Can't input empty"
fi