#!/usr/bin/bash
#description file : menu to create DB or list DB or Drop DB


###### Create DB
#Menu-Main select 
#create DB ,list DB,Connect BD ,Drop DB
PS3="Welcome,Please choose from the Menu select: "
select element in CreateDB ListDB ConnectDB DropDB Exist
do 

    case $element in
     "CreateDB") 
  
          ./CreateDB.sh
       ;;
       "ListDB") 
          ./ListDB.sh
       ;;
       "ConnectDB") 
          ./ConnectDB.sh
       ;;
       "DropDB") 
          ./DropDB.sh
       ;;
       "Exist") clear
       break
       ;;
       *)
         echo "Not Vaild, Please Select a Number From Menu"
       ;;      
    esac
done