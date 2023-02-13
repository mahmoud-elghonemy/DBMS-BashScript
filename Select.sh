#!/usr/bin/bash
#description: select all table or select specifc column or select sepecific row 
 
#select all table -->okay
#check table is exist or no --->okay

#select column check is exist in table or no --->okay
#select this column if it is exist --->okay
function checkInt()
{
    local re='^([0-9]+)*$'
    (( ${#1} > 16 )) && return 1
    [[ "$1" =~ $re ]]
    
}


testValidInt() {
  if checkInt "$1"; then 
    return 0
  else
     return 1 
  fi
}



read -p "Please,Enter name table  to select it: " selTable
if [ ! ${#selTable} -eq 0 ]
then
if [ -f ./$selTable ]
then 
echo "Please,choose what do you want to select from menu? "
select sel in "Select all data From Table" "Select Column" "Select Row" "Exit"
do 
     Numcol=($(awk 'BEGIN{FS=":";} END{print NR}' ./$selTable.Mdata)) 
     Numrows=($(awk 'BEGIN{FS=":";} END{print NR}' ./$selTable)) 
     case $sel in 
       "Select all data From Table") 
           echo "Select this Table"
           echo "-------------------------------------"
           cat $selTable
           echo "-------------------------------------"

        ;;
       
       "Select Column")
    
       read -p "Enter Column Number: " cnum
       testValidInt "$cnum"
       if [ $? -eq 0  ]
       then
       if [ $cnum -le $Numcol ]
       then
       echo "-------------------------------------"
       cat $selTable | cut -d: -f$cnum # -f field 
       echo "-------------------------------------"
       else 
       echo "Doesn't Exist $cnum Numbers Columns"
       fi
       else 
       echo "Sorry,You Must enter number column only"
       fi
       ;;
       "Select Row")
       read -p "Enter Row Number: " nrow
      testValidInt "$nrow"
       if [ $? -eq 0 ]
       then
       if [ $nrow -le $Numrows ]
       then
       echo "-------------------------------------"
       sed -n "$nrow p" ./$selTable  # -n  for number of row
       echo "-------------------------------------"
       else 
       echo "Doesn't Exist $nrow Numbers Rows"
       fi
       else 
       echo "echo "Sorry,You Must enter number row only""
       fi
       ;;
       "Exit")
         break
         ;;
       *)
       echo "You must choose correct number in this menu"
       ;;
     esac
done
else 
echo "Doesn't Exist this table"
fi
else 
echo "You must enter input,Can't input Empty"
fi