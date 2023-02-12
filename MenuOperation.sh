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
         #echo $operation
          #pwd #/home/hopa/Documents/DBMS-BashScript/DB/Cloud
          ../../CreateTable.sh
         ;;
         "List Tables")
         ../../ListTables.sh
         ;;
         "Drop Table")
         ../../DropTable.sh
        ;;
         "Insert into Table")
         echo $operation
         ;;
         "Select From Table")
         ../../Select.sh
         ;;
         "Delete From Table")
         ../../DelFromTable.sh
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

