#!usr/bin/bash
#description : update specific value in specific Column 

cd ./DB/Cloud

echo "Enter table name to insert row into this table: "
read InTable
if [ -f "./$InTable" -a -f "./$InTable.Mdata" ]
then 
     



    echo "Update Sucessfully :)"
else 
echo "You must enter valid table name to update"
fi
