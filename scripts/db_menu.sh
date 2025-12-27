#!/bin/bash
database_name=$1
echo $database_name "Database Menu"
select option in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table"  "Delete From Table" "Update Table" "Back to Main Menu"
do 
    case $REPLY in 
        1) 
        echo Create Table 
        ./scripts/create_table.sh $database_name 
        ;;
        2) 
        echo List tables 
        ./scripts/list_tables.sh $database_name
        ;;
        3) 
        echo Drop Table 
        ./scripts/drop_table.sh $database_name
        ;;
        4) 
        echo Insert into Table 
        ./scripts/insert_into_table.sh $database_name
        ;;
        5) 
        echo Select from Table 
        ./scripts/select_from_table.sh $database_name
        ;;
        6) 
        echo Delete from Table 
        #./scripts/delete_from_table.sh $database_name
        ;;
        7) 
        echo Update Table 
        #./scripts/update_table.sh $database_name
        ;;
        8) 
        echo back to menu 
        exit
        ;;
        *) echo "Invalid option. Please try again." 
        ;;
    esac
done
