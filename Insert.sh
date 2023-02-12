#!/usr/bin/bash
#description: insert row into table 

#move to database tables
cd ./DB/Cloud 
#ask table name to insert row into this table --->okay
#validation is table exist or no --->okay
#approach 
#go to file.Mdata 
#id:int:YES    ---->$f1,$f2,$f3
#first_name:string:NO
#last_name:string:NO
#ask user enter $f2 into $f1 Column--->
#echo user enter int into id Column--> mahmoud --->error
#validation value is verify datatype or no 
#validation if first column is pk check is unique and not null

# echo "Enter table name to insert row into this table: "
# read InTable
# if [ -f "./$InTable" -a -f "./$InTable.Mdata" ]
# then 
#         # numRow=$(awk -F":" '{print $s1}' "./$InTable.Mdata")
#        # awk '{print $0}' "./$InTable.Mdata"
#         valueCol=0
#         awk -F":" -V read "$valueCol" '{for(i=1; i<=NF; i++) { 
#             print Please,Enter your i Column
            
#             print $}
#             }' "./$InTable.Mdata"
#         # echo $numRow
#         # while read p; do 
#         # echo "$p"
#         # done <"./$InTable.Mdata"

# else 
# echo "You must enter valid table name to insert"
# fi
myvar=0
awk -v myvar="$myvar" '{print myvar}'

