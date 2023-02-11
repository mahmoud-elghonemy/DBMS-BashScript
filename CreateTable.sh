#!/usr/bin/bash
#description this script: Create Tables

#fucntion check regex table name 

function isValidTB() {
 
  local re='^([A-Za-z]+)[_]*[A-Za-z]*$'
  (( ${#1} > 16 )) && return 1 #check lenght first argument is greater than 16 return one
  [[ $1 =~ $re ]] # return value of this comparison is used for the function
}

function testValidTableName() {
  if isValidTB "$1"; then
    return 0
  else
     return 1
  fi
}



#ask what is name table--->okay
#vaildation table name ---->okay
#check file table is exist or no -->okay
#check file table.Mdata--->okay
#pwd #/home/hopa/Documents/DBMS-BashScript/DB/Cloud 
#  two cases
#  cancat inputs columns id : integer : pk >>table name.Mdata
#  cancat inputs columns fname : string  >>table name.Mdata


read -p "Please,Enter Table Name: " TName 
#check Tname is valid or no 
testValidTableName "$TName"
if [ $? -eq 0 ] 
then
      if [ ! -f ./$TName  -a  ! -f "./${TName}.Mdata" ]
      then
           touch ./$TName
           touch "./${TName}.Mdata"
           typeset -i NColumns #NColumns integer 
          read -p "Enter number of Columns: " NColumns 
          #echo $NColumns
          if [ $NColumns -ne '0' ] #if not zero and string 
          then 
                  for i in $(eval echo "{1..$NColumns}")
                  do
                    read -p "Enter Column name: " ColName
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
                                echo "Please,choose this column is Primary key or no"
                                select Pk in YES NO
                                do
                                    case $Pk in
                                    
                                    "YES")
                                    
                                      break
                                        ;;
                                    "NO")
                                      break
                                      ;;
                                    *)
                                          echo Choose valid Number for column
                                      ;;
                                    esac

                                    
                                done 
                      else 
                      Pk=NO
                      fi

                    echo $ColName:$DtypeCol:$Pk >>"$TName.Mdata" 
                    
                  done
          else 
          echo "you must enter at least two columns "
          fi
          
          echo "Table is Created :)"
     else
        echo "Table is already Exist"
      fi
else 
echo "Please,Enter valid table name"
fi 





# ss="man"
# mn="woman"
# echo $ss:$mn











#two approach
# pk 


#input user columns name 
#input datatype column --->int or string --->ask evey columns
#input primary key or no  #1 mahmoud mohamed ---> ask every table 
#validation input column name
#validation input datatypes
#validation pk column is unique  
#write every value in file.Mdata