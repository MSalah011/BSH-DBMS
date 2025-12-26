#!/bin/bash
# This script connects to a specified database
db_path="./Databases" 
read -p"Enter database name to connect: " db_name
# Check if the database exists
if [[ -d "$db_path/$db_name" ]]; then
    echo "Connected to database '$db_name'."
    ./scripts/database_menu.sh "$db_name"
else
    echo "Database '$db_name' does not exist."
fi  
