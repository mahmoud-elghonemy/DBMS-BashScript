#!/usr/bin/bash
#description this script: create DB 

#create data as directory ---->okay
#vaildation input for database name
#vaildation already exist or no --->okay

# vaildName="([A-Za-z]*)([0-9]*)"
# function test()
# {
#     if [ $1 = ~${vaildName} ]
#     then 
#     echo true
#     else 
#     echo false
#     fi 
# }
isValidDB() {
 # local re='^[[:lower:]][[:lower:][:digit:]_-]{2,15}$'
  local re='^([A-Za-z]+)[_-]*[A-Za-z0-9]*$'
  (( ${#1} > 16 )) && return 1 #check lenght first argument is greater than 16 return one
  [[ $1 =~ $re ]] # return value of this comparison is used for the function
}


testValidDBname() {
  if isValidDB "$1"; then
    echo "$1 is a valid DB Name"
  else
    echo "$1 is not a DB name"
  fi
}

echo "Please, Enter Database Name"
read DBname
testValidDBname $DBname #call function


if [ ! -d ./DB ]
then
mkdir ./DB
fi 
if [ ! -d ./DB/$DBname ]  
then
    mkdir ./DB/$DBname #create new DB dir inside DB dir on current directory
else 
    echo "this DB already exist"
fi 







