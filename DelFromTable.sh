#!/bin/bash
#description : 
# Steps of deleting column:
#   1- Read column name from user---->okay
#   2- Validate column name (column name exists in Mdata/$tableName)--->okay
#   3- Get column number -->okay
#   4- Delete column from Data/$tableName--->okay
#   5- Delete row from table--->okay

# read column name from user

read -p "Please,Enter name table  to select it: " delFormTable
if [ ! ${#delFormTable} -eq 0 ]
then
if [ -f ./$delFormTable ]
then 
echo "Please,choose what do you want to select from menu? "
select sel in "Delete all data From Table" "Delete Column" "Delete Row" "Return Back to Menu"
do   
    
     
    case $sel in 
       "Delete all data From Table")
        sed -i "d" ./$delFormTable
        echo "----------------------"
        echo "Delete Sucessfully :) "
        echo "----------------------"

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
                        

                        if [ $colNum -eq 1 ]
                        then
                            echo "Con't PK in Table :) "
                        else
                        touch ./$delFormTable.del
                        cut -d':' --complement -f$colNum ./$delFormTable > ./$delFormTable.del
                        mv ./$delFormTable.del ./$delFormTable
                        # delete line containing column from Mdata/$tableName
                        sed -i "$colNum"d ./$delFormTable.Mdata  
                        echo "------------------------------"
                        echo "Delete Column Sucessfully :) "
                         echo "------------------------------"
                        fi
                    else
                        echo "In-valid column name.";
                    fi
                        
               
        ;;
        
        "Delete Row")

                NumCol=($(awk 'BEGIN{FS=":";} {print NF}' ./$delFormTable.Mdata)) 
                ColsName=($(awk 'BEGIN{FS=":";} {print $1}' ./$delFormTable.Mdata))
                ColsDataTypes=($(awk 'BEGIN{FS=":";} {print $2}' ./$delFormTable.Mdata))
                  

                echo "Please, Enter you Value Condition in any Column ,Enter column Name"
                read NameCal
                #check exist column name is exist in table or no 
               while (( `cut -d":" -f1 "./$delFormTable.Mdata" | grep -x $NameCal | wc -w` == 0 ))
                do 
                        read -p "$NameCal Column should be Exist in $delFormTable table, please enter Correct Column: " NameCal
                done
                
              
    
                echo "Please , your Condition value in field "
                read DelValue
              
                   
                    numCol=`awk -v myvar=$NameCal 'BEGIN{FS=":";} {
                        if($1==myvar)
                        {print NR}
                        }' ./$delFormTable.Mdata`
                   


                   RowsNumToDel=`awk  -v myCol=$numCol -v myDelValue=$DelValue  'BEGIN{FS=":";} {
                                for(i=1; i<=NF; i++) 
                                {
                                if(i==myCol && $i==myDelValue){
                                    print NR;
                                    }
                                } 
                            
                            }' ./$delFormTable`
                   
                    NumDelDone=0
                    #loop elements to match specific this value and delete there rows
                    for i in $RowsNumToDel;
                    do
                    #    echo $i
                        ((numDel=$i-$NumDelDone)) #why need newvalue for row after delete first row and row second and so on
                            sed -i "$numDel"d ./$delFormTable
                        ((NumDelDone++))
                            
                    done
                   echo "-----------------------------"
                   echo "Delete Row Sucessfully :) "
                    echo "----------------------------"
        ;;
        "Return Back to Menu")
        break
        ;;
        *)
         echo "You Must correct Choose from this menu "
        ;;

           
    esac
done 
else 
 echo "Sorry,Please enter correct name table"
fi
else 
echo "You must input , Can't input empty"
fi
