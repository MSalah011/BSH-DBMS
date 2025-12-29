#!/bin/bash
clear
echo "--- DATABASE MANAGEMENT SYSTEM ---"
echo "----------------------------------"
echo "-------- CREATE DATABASE ---------"
echo "----------------------------------"
echo ""
# Path where all databases will be stored
db_path="./Databases"

# (-p) prevents error if the directory already exists
mkdir -p "$db_path"

# read database name from user
echo "Enter Database Name: "
read db_name

# Check for empty database name
if [[ -z "$db_name" ]]; then
    echo "Database name cannot be empty!"
    exit 1
fi

# Check for invalid characters in database name
if [[ "$db_name" =~ [/:\"\'\\\?\*\<\>\|] ]]; then
    echo "Database name contains invalid characters! Please avoid / : \" ' \ ? * < > |"
    exit 1
fi  

# Check if the database already exists
if [[ -d "$db_path/$db_name" ]]; then
    echo "Database already exists!"
else
    mkdir "$db_path/$db_name"
    echo "Database '$db_name' created successfully."
fi
