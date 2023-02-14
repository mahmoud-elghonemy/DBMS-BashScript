#!/usr/bin/bash
#description this script: Create Tables

#fucntion check regex table name 

function isValidTB() {
 
  local re='^([A-Za-z]+)[_]*[A-Za-z]*$'
  (( ${#1} > 16 )) && return 1 #check lenght first argument is greater than 16 return one
  [[ "$1" =~ $re ]] # return value of this comparison is used for the function
}

function testValidTableName() {
  if isValidTB "$1"; then
    return 0
  else
     return 1
  fi
}
function OnlyNumber()
{
  local re='^([0-9]+)*$'
  (( ${#1} > 16 )) && return 1 #check lenght first argument is greater than 16 return one
  [[ "$1" =~ $re ]] # return value of this comparison is used for the function
     
}
function testOnlyNumber() {
  if OnlyNumber "$1"; then
    return 0
  else
     return 1
  fi
}


#ask what is name table--->okay
#vaildation table name ---->okay
#check file table is exist or no -->okay
#check file table.Mdata--->okay


#  two cases
#  cancat inputs columns id : integer : YES >>table name.Mdata-->okay
#  cancat inputs columns fname : string :NO >>table name.Mdata--->okay
#input user columns name --->okay
#input datatype column --->int or string --->ask evey columns-->okay
#input assume first columns is pk--->okay

#don't implem
#validation NColumns --->okay
#assume first columns is pk in all table when created 
#validation Name Column is unique --->

read -p "Please,Enter Table Name: " TName 
#check Tname is valid or no ---->yes
testValidTableName "$TName"
if [ $? -eq 0 -a ! ${#TName} -eq 0 ] 
then
      if [ ! -f ./$TName  -a  ! -f "./${TName}.Mdata" ]
      then
                touch ./$TName
                touch "./${TName}.Mdata"

                
                read -p "Enter number of Columns and You must Number at least 2 Columns: " NColumns 
                testOnlyNumber "$NColumns" 
          
          if [ $? -eq 0 ]
          then
      
              if [ $NColumns -gt 1 ] #if not zero and string 
              then 
                      for i in $(eval echo "{1..$NColumns}")
                      do
                         
                         while [ true ]
                         do
                                read -p "Enter Column name: " ColName
                                #check unique Names Column
                                testValidTableName "$ColName"
                                if [ $? -eq 0 ]
                                then
                                        while (( `cut -d":" -f1 "./$TName.Mdata" | grep -x $ColName |wc -w` > 0 ))
                                                  do 
                                                      while [ true ]
                                                      do
                                                      read -p "$ColName should be unique, please enter another Name to this Column: " ColName 
                                                      testValidTableName "$ColName"
                                                      if [ $? -eq 0 ]
                                                      then
                                                             break
                                                      else 
                                                          echo "please, Enter Vaild name table"
                                                      fi
                                                      done
                                                  done

                                        echo "Please,choose Datatypes column ?"
                                          select DtypeCol in int string
                                          do 
                                              case $DtypeCol in 
                                              "int")
                                                break
                                                  ;;
                                              "string")
                                                break
                                                ;;
                                            
                                              *)
                                              echo select valid datatype for column
                                              ;;
                                              esac 
                                          done  
                                            if [ $i -eq 1 ]
                                           then 
                                            PK=YES 
                                           else 
                                           Pk=NO
                                           fi 

                                    echo $ColName:$DtypeCol:$Pk >>"$TName.Mdata" 
                                    break

                                else 
                                  
                                  echo "Sorry,Can't enter invalid Characters"

                                  


                                fi 
                          
                                  


                            done
                          done
                         
                    echo "Table is Created :)"
              else 
              echo "you must enter at least two columns"
              rm ./$TName
              rm "./${TName}.Mdata"
              fi 
            else
              echo "Sorry,Please enter only Numbers"
              rm ./$TName
              rm "./${TName}.Mdata"
            fi
          
     else
        echo "Table is already Exist"
      fi
else 
echo "Please,Enter valid table name"
fi 






