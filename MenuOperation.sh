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

PS3="Please Select From Operation: "
select operation in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Return to Back Menu"

do

        case $operation in 
         "Create Table")
          ../../CreateTable.sh
         ;;
         "List Tables")
         ../../ListTables.sh
         ;;
         "Drop Table")
         ../../DropTable.sh
        ;;
         "Insert into Table")
          ../../Insert.sh
         ;;
         "Select From Table")
         ../../Select.sh
         ;;
         "Delete From Table")
         ../../DelFromTable.sh
         ;;
         "Update Table")
          ../../Update.sh
         ;;

         "Return to Back Menu") clear 
          break

         ;;
         *)
         echo "Please ,Choose a Number of operation"
         ;;
        esac
done

