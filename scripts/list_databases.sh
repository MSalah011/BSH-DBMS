#!/bin/bash
# where databases are stored
db_path="./Databases"

# Check if Databases directory exists 
if [[ -d "$db_path" ]]; then
    # Check if folder database is empty or not
    if [ -z "$(ls -A "$db_path")" ]; then
        echo "Database is empty"
    else
        echo "Available Databases:"
        ls -d "$db_path"/*/
    fi
else
    echo "No databases found."
fi
