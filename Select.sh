#!/usr/bin/bash
#description: select all table or select specifc column or select sepecific row 
 
#select all table -->okay
#check table is exist or no --->okay

#select column check is exist in table or no
#select this column if it is exist 

# function CheckCol
# {
   
# }


cd ./DB/Cloud

read -p "Please,Enter name table  to select it: " selTable

if [ -f ./$selTable ]
then 
echo "Please,choose what do you want to select from menu? "
select sel in "Select all Table" "Select Column" "Select Row" "Exit"
do 

     case $sel in 
       "Select all Table") 
           echo "Select this Table"
           awk 'BEGIN{FS=":";ORS=" "; print `awk -F: '{print $1}' test.Mdata`;} {for(i=1; i<=NF; i++) {print $i,"\t\t";} print "\n" } END { print "---------\nTable Complete\n" }' ./$selTable
   
    #   awk 'BEGIN{FS=":";ORS=" "; print "id\t\tfname\t\tlname\t\t\tage\t\t\n---------------------------------------\n";} {for(i=1; i<=NF; i++) {print $i,"\t\t";} print "\n" } END { print "---------\nTable Complete\n" }' ./$selTable
   
    #    awk 'BEGIN { FS=":"; print "User\t\tUID\t\tGID\t\tHome\t\tShell\n---------------------------------------"; }
    #        {print $1,"\t\t",$3,"\t\t",$4,"\t\t",$6,"\t\t",$7;}
    #         END { print "---------\nFile Complete" }' /etc/passwd

# awk '{printf "%s ",$2}' file

    

        ;;
       
       "Select Column")
       echo -p "Please, Enter specific Column Name " ColNamePtr
        
       awk -V -F: '{print $1}' test.Mdata
    #    to search in specific column
        awk '$2 ~ /^sa/' favorite_food.txt
       
       ;;
       "Select Row");;
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