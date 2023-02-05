#!/usr/bin/bash
#description file : menu to create DB or list DB or Drop DB


###### Create DB
#Menu-Main select 
#create DB ,list DB,Connect BD ,Drop DB
echo "Welcome,Please choose from the Menu select "
select element in CreateDB ListDB ConnectDB DropDB Exist
do 

    case $element in
     "CreateDB") 
  
          ./CreateDB.sh
       ;;
       "ListDB") echo $element
       ;;
       "ConnectDB") echo $element
       ;;
       "DropDB") echo $element
       ;;
       "Exist") break
       ;;
       *)
         echo "Please,use vaild select"
       ;;      
    esac
done