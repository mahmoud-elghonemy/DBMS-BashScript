#!/usr/bin/bash
#description for this script: Menu Operation

# if exist DB change directory or no 
# because access DB
# if true exit DB 
# operation :
# - Create Table
# - List Tables
# - Drop Table
# - Insert into Table
# - Select From Table
# - Delete From Table
# - Update Table


#menu Operation
echo "Select what do you do on Database "
select operation in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Exit"
do
echo $operation
done

