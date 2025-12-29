#!/bin/bash
PS3="Please select an option: "
database_name="$1"
while true; do
    clear
    echo "--- DATABASE MANAGEMENT SYSTEM ---"
    echo "----------------------------------"
    echo "    '$database_name' Database Menu"
    echo "----------------------------------"
    echo "" 
    # create database menu 
    select option in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table"  "Delete From Table" "Update Table" "Back to Main Menu"
    do 
        case $REPLY in 
            1) 
            ./scripts/create_table.sh $database_name 
            echo -e "\nPress any key to return to menu..."
            read
            break
            ;;
            2) 
            ./scripts/list_tables.sh $database_name
            ;;
            3) 
            ./scripts/drop_table.sh $database_name
            echo -e "\nPress any key to return to menu..."
            read
            break
            ;;
            4) 
            ./scripts/insert_into_table.sh $database_name
            echo -e "\nPress any key to return to menu..."
            read
            break
            ;;
            5) 
            ./scripts/select_from_table.sh $database_name
            echo -e "\nPress any key to return to menu..."
            read
            break
            ;;
            6) 
            ./scripts/delete_from_table.sh $database_name
            echo -e "\nPress any key to return to menu..."
            read
            break
            ;;
            7) 
            ./scripts/update_table.sh $database_name
            echo -e "\nPress any key to return to menu..."
            read
            break
            ;;
            8) 
            exit 0
            ;;
            *)
            break
            ;;
        esac
    done
done
