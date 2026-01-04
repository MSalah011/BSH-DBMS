#!/bin/bash
# This script drops a specified table from a database
db_path="./Databases"
database_name="$1"
read -p"Enter table name to drop: " table_name
# check if table exists
if [[ -f "$db_path/$database_name/$table_name" ]]; then
    echo -n "Are you sure you want to delete table '$table_name'? (y/n): "
    read confirm
    # check confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        rm "$db_path/$database_name/$table_name"
        rm "$db_path/$database_name/$table_name".metadata
        echo "Table '$table_name' deleted successfully from database '$database_name'."
    else
        echo "Drop cancelled."
    fi
else
    echo "Table '$table_name' does not exist in database '$database_name'."
fi