#!/bin/bash
# This script lists all tables in a specified database
db_path="./Databases"
database_name="$1"
# check if database has tables
if [ -z "$(ls -A "$db_path/$database_name")" ]; then
    echo "No tables found in database '$database_name'."
else
    echo "Tables in database '$database_name':"
    echo "-------------------------------"
    ls "$db_path/$database_name" | grep -v "\.metadata$"
    echo "-------------------------------"
fi