#!/usr/bin/bash
#description: select all table or select specifc column or select sepecific row 


select sel in "Select all Table" "Select Column" "Select Row" "Exit"
do 

     case $sel in 
       "Select all Table") 
        echo $sel
        ;;
       "Select Column");;
       "Select Row");;
       "Exit")
         break
         ;;
       *)
       echo "You must choose correct number in this menu"
       ;;
     esac
done