#!/bin/bash
PS3="Please select an option: "
while true; do
    clear
    echo "--- DATABASE MANAGEMENT SYSTEM ---"
    echo "----------------------------------"
    echo "            Main Menu             "
    echo "----------------------------------"
    echo "" 
    # create main menu
    select choice in "Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit"
    do 
        case $REPLY in
            1)
            ./scripts/create_database.sh
            echo "\nPress any key to return to menu..."
            read
            break
            ;;
            2)
            ./scripts/list_databases.sh
            ;;
            3)
            ./scripts/connect_to_database.sh
            break
            ;;
            4)
            ./scripts/drop_databases.sh
            echo "\nPress any key to return to menu..."
            read
            break
            ;;
            5)
            clear
            echo "--- DATABASE MANAGEMENT SYSTEM ---"
            echo "----------------------------------"
            echo "" 
            echo "Goodbye!"
            exit 0
            ;;
            *)
            break
            ;;
        esac
    done
done