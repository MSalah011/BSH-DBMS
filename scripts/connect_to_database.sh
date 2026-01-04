#!/bin/bash
# This script connects to a specified database
db_path="./Databases" 
read -p"Enter database name to connect: " db_name

#check for empty input
if [[ -z "$db_name" ]]; then
    echo "Database name cannot be empty!"
    exit 1
fi

# Check if the database exists
if [[ -d "$db_path/$db_name" ]]; then
    ./scripts/db_menu.sh "$db_name"
else
    echo "Database '$db_name' does not exist."
    echo "Returning to main menu..."
    sleep 2
    exit 1
fi  
