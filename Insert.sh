#!/usr/bin/bash
#description: insert row into table 


#ask table name to insert row into this table --->okay
#validation is table exist or no --->okay
#approach 
#go to file.Mdata --->to count numbers columns and get first column and second column--->okay
#ask user enter $f2 into $f1 Column---> okay
#echo user enter int into id Column--> okay
#validation value is verify datatype or no ---->okay
#validation if first column is pk check is unique and not null---->okay


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


echo "Enter table name to insert row into this table: "
read InTable
if [ ! ${#InTable} -eq 0 ]
then
if [ -f "./$InTable" -a -f "./$InTable.Mdata" ]
then 
    NumRows=($(awk 'BEGIN{FS=":";} END{print NR}' ./$InTable.Mdata))
    ColsName=($(awk 'BEGIN{FS=":";} {print $1}' ./$InTable.Mdata))
    ColsDataTypes=($(awk 'BEGIN{FS=":";} {print $2}' ./$InTable.Mdata))
    output=""

((NumRows--))
    for i in $(seq 0 $NumRows);
    do 
         echo "please,Enter" ${ColsName[i]}":"
    
            if [ "${ColsDataTypes[i]}" == "int" ]
            then 
                        while [ true ]
                        do  
                            
                                    read inputInt
                                    testValidInt "$inputInt"
                                    if [ $? -eq 0  -a  ! ${#inputInt} -eq 0 ]
                                    then 
                                 
                                        
                                            #unique id
                                            if (( $i == 0 )) ;then
                                                while (( `cut -d":" -f1 "./$InTable" | grep -x $inputInt |wc -w` > 0 ))
                                                do 
                                                    
                                                        while [ true ]
                                                        do  
                                                            read -p "${ColsName[i]} should be unique, please enter another value: " inputInt
                                                            testValidInt "$inputInt" 
                                                            if [ $? -eq 0  -a  ! ${#inputInt} -eq 0  ]
                                                            then
                                                                        break
                                                            else 
                                                                    echo "you must enter integer datatype in this "${ColsName[i]}
                                                            fi
                                                        done
                                                done
                                            fi
                                                    
                                                    output+=$inputInt
                                                    if [ $i -ne $NumRows ]
                                                    then
                                                        output+=:
                                                    fi

                                            break
                                        

                                    
                                
                                    else 
                                            echo "you must Input enter integer datatype in this "${ColsName[i]}
                                            echo "Please, Enter another once "${ColsName[i]}
                            
                                    fi
                        done
            else 
                        while [ true ]
                        do
                                    read inputStr
                                    testValidString "$inputStr"
                                        if [ $? -eq 0 -a ! ${#inputStr} -eq 0 ]
                                        then 
                                                  #unique id
                                                    if (( $i == 0 )) ;then
                                                    while (( `cut -d":" -f1 "./$InTable" | grep -x $inputStr |wc -w` > 0 ))
                                                    do 
                                                        
                                                            while [ true ]
                                                            do  
                                                                read -p "${ColsName[i]} should be unique, please enter another value: " inputStr
                                                                testValidString "$inputStr" 
                                                                    if [ $? -eq 0 -a ! ${#inputStr} -eq 0 ]
                                                                    then
                                                                            break
                                                                    else 
                                                                        echo "you must enter String datatype in this "${ColsName[i]}
                                                                    fi
                                                            done
                                                    done
                                                    fi

                                        output+=$inputStr
                                            if [ $i -ne $NumRows ]
                                            then
                                            output+=:
                                            fi
                                        break
                                        else 
                                        echo "you must enter String datatype in this "${ColsName[i]}
                                        echo "Please, Enter another once "${ColsName[i]}
                                        fi
                        done
                        

            fi
        
    done
    echo $output >> ./$InTable
    echo "----------------------"
    echo "Insert Sucessfully :)"
    echo "----------------------"

else 
echo "You must enter valid table name to insert"
fi
else 
echo "You must input , Can't input empty"
fi
