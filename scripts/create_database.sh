#!/bin/bash

# Path where all databases will be stored
db_path="./Databases"

# (-p) prevents error if the directory already exists
mkdir -p "$db_path"

# read database name from user
echo "Enter Database Name: "
read db_name

# Check if the database already exists
if [[ -d "$db_path/$db_name" ]]; then
    echo "Database already exists!"
else
    
    mkdir "$db_path/$db_name"
    echo "Database '$db_name' created successfully."
fi
