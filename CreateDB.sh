#!/usr/bin/bash
#description this script: create DB 

#create data as directory ---->okay
#vaildation input for database name--->okay
#vaildation already exist or no --->okay



isValidDB() {
 
  local re='^([A-Za-z]+)[_-]*[A-Za-z0-9]*$'
  (( ${#1} > 16 )) && return 1 #check lenght first argument is greater than 16 return one
  [[ $1 =~ $re ]] # return value of this comparison is used for the function
}


testValidDBname() {
  if isValidDB "$1"; then 
    return 0
  else
     return 1 
  fi
}

echo "Please, Enter Database Name"
read DBname
testValidDBname "$DBname" #call function
if [ $? -eq 0  -a ! ${#DBname} -eq 0 ]
then 
    if [ ! -d ./DB ]
    then
    mkdir ./DB
    fi 

    if [ ! -d ./DB/$DBname ]  
    then
        mkdir ./DB/$DBname #create new DB dir inside DB dir on current directory
         echo "-----------------------------"
         echo "Data Base Created Succesfully"
         echo "-----------------------------"
       

    else 
     
        echo "this DB already exist"
    fi 
else 
    echo "you must enter valid DB Name"
fi







