#!/usr/bin/bash
#description: insert row into table 


#ask table name to insert row into this table --->okay
#validation is table exist or no --->okay
#approach 
#go to file.Mdata --->to count numbers columns and get first column and second column--->okay
#ask user enter $f2 into $f1 Column---> okay
#echo user enter int into id Column--> okay
#validation value is verify datatype or no ---->okay
#validation if first column is pk check is unique and not null




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

function checkPK()
{
    local first_Column=($(awk 'BEGIN{FS=":";} {print $1}' ./"$2"))
    for i in ${first_Column[@]}
    do
         if [ "$1" -eq $i  ]
         then
            return 1
         fi
        
    done
    return 0
    
}
# function repeatInputPK()
# {
    
#     if [ $i -eq 0 ] #check if is pk or no
#     then
#     checkPK "$inputInt" "$InTable"   
#           if [ $? -ne 0 ]
#           then 
#              echo "Please,Enter input secific PK"
#              read newPK
#              repeatInputPK
#           else 
             
#           fi                                
#     fi 
    
    
# }

echo "Enter table name to insert row into this table: "
read InTable
if [ -f "./$InTable" -a -f "./$InTable.Mdata" ]
then 
    NumRows=($(awk 'BEGIN{FS=":";} {print NF}' ./$InTable.Mdata))
    ColsName=($(awk 'BEGIN{FS=":";} {print $1}' ./$InTable.Mdata))
    ColsDataTypes=($(awk 'BEGIN{FS=":";} {print $2}' ./$InTable.Mdata))
    output=""
    for i in $(seq 0 $NumRows);
    do 
    echo "please,Enter" ${ColsName[i]}":"
    
            if [ ${ColsDataTypes[i]} == "int" ]
            then 
                        while [ true ]
                        do
                            read inputInt
                            checkInt "$inputInt"
                            if [ $? -eq 0 ]
                            then 
                            output+=$inputInt
                            if [ $i -ne $NumRows ]
                             then
                                 output+=:
                            fi
                            break
                            else 
                                echo "you must enter integer datatype in this "${ColsName[i]}
                                echo "Please, Enter another once "${ColsName[i]}
                    
                            fi
                            done
            else 
                        while [ true ]
                        do
                                    read inputStr
                                    checkString "$inputStr"
                                        if [ $? -eq 0 ]
                                        then 
                                            #   if [ $i -eq 0 ] #check if is pk or no
                                            #   then
                                            #   checkPK "$inputInt" "$InTable"
                                            #   fi 




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
    echo "Insert Sucessfully :)"

else 
echo "You must enter valid table name to insert"
fi

