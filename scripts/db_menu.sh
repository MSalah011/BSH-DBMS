#!/bin/bash
echo $1 "Database Menu"
select option in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table"  "Delete From Table" "Update Table" "Back to Main Menu"
do 
    case $REPLY in 
        1) 
        echo Create Table 
        #./scripts/create_table.sh 
        ;;
        2) 
        echo List tables 
        #./scripts/list_tables.sh 
        ;;
        3) 
        echo Drop Table 
        #./scripts/drop_table.sh 
        ;;
        4) 
        echo Insert into Table 
        #./scripts/insert_into_table.sh 
        ;;
        5) 
        echo Select from Table 
        #./scripts/select_from_table.sh 
        ;;
        6) 
        echo Delete from Table 
        #./scripts/delete_from_table.sh 
        ;;
        7) 
        echo Delete Table 
        #./scripts/update_table.sh 
        ;;
        8) 
        echo back to menu 
        ./scripts/main_menu.sh
        exit
        ;;
        *) echo "Invalid option. Please try again." 
        ;;
    esac
done
