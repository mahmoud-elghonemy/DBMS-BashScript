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

        case $operation in 
         "Create Table")
          echo $operation
         ;;
         "List Tables")
         echo $operation
         ;;
         "Drop Table")
         echo $operation
        ;;
         "Insert into Table")
         echo $operation
         ;;
         "Select From Table")
         ;;
         "Delete From Table")
         ;;
         "Update Table")
         ;;
         "Exit")
         ;;
         *)
         echo "Please , choose correct operation"
         ;;
        esac
done

