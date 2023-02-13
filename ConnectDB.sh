#!/usr/bin/bash
#description for this script: Connect DB

#Connect DB 
#two approach 1)select DB 2)input user

read -p "Please,Enter DataBase Name To Connect: " ConDBName
#check $ConDBName and check DB is exist or no 
#valid nanme 
if [ ! ${#ConDBName} -eq 0 ]
then
if [ -d ./DB ] 
then
    if [ -d ./DB/$ConDBName ] 
    then
        #don't work source with cd 
        cd ./DB/$ConDBName
        clear
        echo "$ConDBName DB is selected.."
        ../../MenuOperation.sh

        #echo $ConDBName
    else
       echo "This DataBase Name Not Exist"
    fi
else 
  echo "Not Exist any DataBases"
fi
else 
echo "Can't input empty"
fi
