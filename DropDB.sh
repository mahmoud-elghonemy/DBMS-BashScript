#!/usr/bin/bash
#description for this script: DropDB


#remove Database direcory in DB 
#validation 

# two approach 
# user input string for name db
# user select name DB in list DB

#first Approach 
read -p "Enter Name DB who want to delete it ? " delDBName 
if [ -d ./DB/$delDBName ]
then
    rm -r ./DB/$delDBName
    echo "$delDBName dropped Sucessfully :)"
else
   echo "This Database Doesn't Exist or Not vaild Database Name"
fi 

