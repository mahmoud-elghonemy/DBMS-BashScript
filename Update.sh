#!/usr/bin/bash
#description : update specific value in specific Column 

cd ./DB/Cloud
#Function check datatypes
function checkInt()
{
    local re='^([0-9]+)*$'
    (( ${#1} > 16 )) && return 1
    [[ "$1" =~ $re ]]
    
}

function checkString()
{
    local re1='^([A-Za-z]+)*$'
    (( ${#1} > 16 )) && return 1
    [[ "$1" =~ $re1 ]]
    
}

   



echo "Enter table name to insert row into this table: "
read InTable
if [ -f "./$InTable" -a -f "./$InTable.Mdata" ]
then 
         NumCol=($(awk 'BEGIN{FS=":";} {print NF}' ./$InTable.Mdata)) 
         ColsName=($(awk 'BEGIN{FS=":";} {print $1}' ./$InTable.Mdata))
         ColsDataTypes=($(awk 'BEGIN{FS=":";} {print $2}' ./$InTable.Mdata))
         output="" 

         echo "Please, Enter you Name Column"
         read NameCal
            #check exist column name is exist in table or no 
            while (( `cut -d":" -f1 "./$InTable.Mdata" | grep -x $NameCal | wc -w` == 0 ))
            do 
                    read -p "$NameCal Column should be Exist in $InTable table, please enter Correct Column: " NameCal
            done
        
         indexType=0
         #know datatype 
         for i in $ColsName 
         do

              if [ $i == $NameCal ]
              then
                  break
              fi
              ((indexType++))
         done
        #  echo ${ColsDataTypes[indexType]}

        echo "Please , your old value in field "
        read OldValue
        #check OldValue value is exist or no 
        #echo `cut -d":" -f$indexType "./$InTable" | grep -x $OldValue | wc -w`
        while (( `cut -d":" -f2 "./$InTable" | grep -x $OldValue | wc -w` == 0 ))
        do 
            read -p "Sorry $OldValue Doesn't Exist, please enter Exist value to Update : " OldValue
        done
                                

  
         echo "Please,Enter you new value"
          if [ ${ColsDataTypes[indexType]} == "int" ]
          then
                while [ true ]
                do
                read NewValue
                checkInt $NewValue
                         if [ $? -eq 0 ]
                         then
                              
                                   #if Column is PK
                                   if (( $indexType == 0 )) ;then
                                    while (( `cut -d":" -f1 "./$InTable" | grep -x $NewValue |wc -w` > 0 ))
                                    do 
                                        read -p "${ColsName[i]} should be unique, please enter another value: " NewValue
                                    done
                                    fi    
                                 
                                #replace or update value
                                sed  "s/:$OldValue:/:$NewValue:/g" ./$InTable > ./tempFile
                                mv ./tempFile ./$InTable
                               
                              
                              break
                         else  
                             echo "Sorry,Please you must enter ${ColsDataTypes[indexType]} in this $NameCal column"
                             echo "Please,Enter another once your value ?"
                         fi 
                done
          else 
              while [ true ]
                do
                read NewValue
                checkString $NewValue
                       if [ $? -eq 0 ]
                         then  
                               #if Column is PK
                                   if (( $indexType == 0 )) ;then
                                    while (( `cut -d":" -f1 "./$InTable" | grep -x $NewValue |wc -w` > 0 ))
                                    do 
                                        read -p "${ColsName[i]} should be unique, please enter another value: " NewValue
                                    done
                                    fi    
                               
                            
                              
                                #replace or update value
                                sed  "s/:$OldValue:/:$NewValue:/g" ./$InTable > ./tempFile
                                mv ./tempFile ./$InTable

                               break
                         else  
                             echo "Sorry,Please you must enter ${ColsDataTypes[indexType]} in this $NameCal column"
                             echo "Please,Enter another once your value ?"
                         fi 

               done
          fi 


    echo "Update Sucessfully :)"
else 
echo "You must enter valid table name to update"
fi
