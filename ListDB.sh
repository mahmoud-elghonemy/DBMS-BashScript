#!/usr/bin/bash
#description for this script: List DB

#validation list Directory file only---> okay
#validation directory database is exist or no --->okay
#validation DB is exist or no ---> okay

#enhancement to remove slash "/" in the end of character names DB

if [ -d ./DB ]
then
   echo "-----------------"
   echo "List of DataBase:"
   echo "-----------------"
   ls -F ./DB |  grep /  #list all directories in DB only
   if [ $? -ne 0 ]
   then
    echo "No exist Any Databases in DB Storage or Directory"
   else 
   echo "-----------------"
   fi

else
   echo "No exist Any Databases"
fi
