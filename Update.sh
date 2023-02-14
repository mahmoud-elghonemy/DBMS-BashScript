#!/usr/bin/bash
#description : update specific value in specific Column 

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
testValidInt() {
  if checkInt "$1"; then 
    return 0
  else
     return 1 
  fi
}
testValidString() {
  if checkString "$1"; then 
    return 0
  else
     return 1 
  fi
}


 
echo "Enter table name to Update row into this table: "
read updateTable
if [ ! ${#updateTable} -eq 0 ]
then
if [ -f "./$updateTable" -a -f "./$updateTable.Mdata" ]
then 
         NumCol=($(awk 'BEGIN{FS=":";} {print NF}' ./$updateTable.Mdata)) 
         ColsName=($(awk 'BEGIN{FS=":";} {print $1}' ./$updateTable.Mdata))
         
       

         echo "Please, Enter you Name Column"
         read NameCal
          testValidString "$NameCal" 
          if [ $? -eq 0 -a ! ${#NameCal} -eq 0 ]
          then
            #check exist column name is exist in table or no 
            while (( `cut -d":" -f1 "./$updateTable.Mdata" | grep -x $NameCal | wc -w` == 0 ))
            do      
                   while [ true ]
                   do
                    read -p "$NameCal Column should be Exist in $updateTable table, please enter Correct Column: " NameCal
                    testValidString "$NameCal" 
                    if [ $? -eq 0  -a  ! ${#NameCal} -eq 0  ]
                    then
                          break
                    else 
                       echo "you must enter String datatype in this "${ColsName[i]}
                    fi
                   done
            done
           fi
        
            NumsCols=($(awk 'BEGIN{FS=":";} END{print NR}' ./$updateTable.Mdata)) 
            numCol=`awk -v myvar=$NameCal 'BEGIN{FS=":";} {
                        if($1==myvar)
                        {print NR}
                        }' ./$updateTable.Mdata`
            

            DatatypeCol=`awk -v myvar=$NameCal 'BEGIN{FS=":";} {
                        if($1==myvar)
                        {print $2}
                        }' ./$updateTable.Mdata`

           echo $DatatypeCol
                  
       
         
      
        echo "Please , your old value in field "
        read OldValue
           
        
        if [ ! ${#OldValue} -eq 0 ]
        then
        while (( `cut -d":" -f$numCol "./$updateTable" | grep -x $OldValue | wc -w` == 0 ))
        do   
             while [ true ]
             do
                read -p "Sorry $OldValue Doesn't Exist, please enter Exist value to Update : " OldValue
                if [ ! ${#OldValue} -eq 0  ]
                    then
                          break
                    else 
                       echo "Can't input value,you must enter Value datatype in this "${ColsName[i]}
                    fi
            
        
              done
        
        done
        fi

  
         echo "Please,Enter you new value"
          if [ $DatatypeCol == "int" ]
          then
                while [ true ]
                do
                read NewValue
                testValidInt $NewValue
                         if [ $? -eq 0 -a ! ${#NewValue} -eq 0 ]
                         then
                              
                                   #if Column is PK
                                   if (( $numCol == 1 )) ;then
                                    while (( `cut -d":" -f1 "./$updateTable" | grep -x $NewValue |wc -w` > 0 ))
                                    do   
                                        while [ true ]
                                        do
                                        read -p "${ColsName[i]} should be unique, please enter another value: " NewValue
                                        testValidInt $NewValue 
                                         if [ $? -eq 0 -a ! ${#NewValue} -eq 0 ]
                                         then
                                              break
                                         fi
                                         done

                                    done
                                    fi    
                                 
                                #replace or update value
                                if [ $numCol -eq 1 ]
                                then
                                sed  "s/$OldValue:/$NewValue:/g" ./$updateTable > ./tempFile
                                mv ./tempFile ./$updateTable
                                elif [ $numCol  -eq $NumsCols ]
                                then 
                                    sed  "s/:$OldValue/:$NewValue/g" ./$updateTable > ./tempFile
                                    mv ./tempFile ./$updateTable
                                else
                                sed  "s/:$OldValue:/:$NewValue:/g" ./$updateTable > ./tempFile
                                mv ./tempFile ./$updateTable
                                fi
                              
                              break
                         else  
                             echo "Sorry,Please you must enter $DatatypeCol in this $NameCal column"
                             echo "Please,Enter another once your value ?"
                         fi 
                done
          else 
              while [ true ]
                do
                read NewValue
                testValidString $NewValue
                       if [ $? -eq 0 -a ! ${#NewValue} -eq 0 ]
                         then  
                               #if Column is PK
                                   if (( $numCol == 1 )) ;then
                                    while (( `cut -d":" -f1 "./$updateTable" | grep -x $NewValue |wc -w` > 0 ))
                                    do 
                                       while [ true ]
                                        do
                                        read -p "${ColsName[i]} should be unique, please enter another value: " NewValue
                                        testValidString $NewValue 
                                         if [ $? -eq 0 -a ! ${#NewValue} -eq 0 ]
                                         then
                                              break
                                         fi
                                         done
                                    done
                                    fi    
                               
                            
                                  #replace or update value
                                if [ $numCol -eq 1 ]
                                then
                                sed  "s/$OldValue:/$NewValue:/g" ./$updateTable > ./tempFile
                                mv ./tempFile ./$updateTable
                                elif [ $numCol  -eq $NumsCols ]
                                then 
                                    sed  "s/:$OldValue/:$NewValue/g" ./$updateTable > ./tempFile
                                    mv ./tempFile ./$updateTable
                                else
                                sed  "s/:$OldValue:/:$NewValue:/g" ./$updateTable > ./tempFile
                                mv ./tempFile ./$updateTable
                                fi

                               break
                         else  
                             echo "Sorry,Please you must enter $DatatypeCol in this $NameCal column"
                             echo "Please,Enter another once your value ?"
                         fi 

               done
          fi 

    echo "-----------------------"
    echo "Update Sucessfully :)"
    echo "-----------------------"
else 
echo "You must enter valid table name to update"
fi
else 
echo "You must enter input,Can't input Empty"
fi