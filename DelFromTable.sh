#!/bin/bash
#description : 
# Steps of deleting column:
#   1- Read column name from user
#   2- Validate column name (column name exists in Mdata/$tableName)
#   3- Get column number
#   4- Delete column from Data/$tableName
#   5- Delete row from Metadata/$tableName.metadata

# read column name from user
cd ./DB/Cloud
read -p "Please,Enter name table  to select it: " delFormTable

if [ -f ./$delFormTable ]
then 
echo "Please,choose what do you want to select from menu? "
select sel in "Delete all data From Table" "Delete Column" "Delete Row" "Exit"
do   
    
     
    case $sel in 
       "Delete all data From Table")
       sed -i "${NR}d" ./$delFormTable
       echo "Delete Sucessfully :) "

       ;;
        "Delete Column")
                    read -p "Enter column name: " colName;

                    # get column names from Mdata/$tableName
                    colNames=($(awk -F: '{print $1}' ./$delFormTable.Mdata))

                    colFlag=1   #false

                    # get column number
                    for i in "${!colNames[@]}"
                    do 
                        if [[ $colName == "${colNames[$i]}" ]]; then
                            colFlag=0   #true
                            colNum=$(($i+1));  #column-Number
                        fi   
                    done

                    # validate colName
                    if [[ $colFlag == 0 ]]; then
                    # valid colName

                        # delete column from Data/$tableName
                        # cut -d':' --complement -f./$delFormTable 
                        # sed -i "$colNum"d ./$delFormTable
                        cut -d':' --complement -f./$delFormTable  > ./$delFormTable.tmp
                        mv ./$delFormTable.tmp ./$delFormTable
                        # delete line containing column from Mdata/$tableName
                        sed -i "$colNum"d ./$delFormTable.Mdata
                    else
                        echo "ERROR:In-valid column name.";
                    fi
                        
               echo "Delete Column Sucessfully :) "
        ;;
        "Delete Row")

        ;;
        "Exit")
        break
        ;;
        *)
         echo "You Must correct Choose from this menu "
        ;;

           
    esac
done 


fi

# echo "Select this Table"
# cat $selTable


