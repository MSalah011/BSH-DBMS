#!/bin/bash
# This script inserts a record into a specified table in a specified database
db_path="./Databases"
database_name="$1"
read -p"Enter table name: " table_name
table_path="$db_path/$database_name/$table_name"
# Check if table exists
if [[ -f "$table_path" ]]; then
    # Read the second line to get column data types
    IFS=':' read -r -a data_type <<< $(sed -n '2p' "$table_path")
    # Read the third line to get column names
    IFS=':' read -r -a column <<< $(sed -n '3p' "$table_path")
    for (( i=0; i<${#column[@]}; i++ )); do
        read -p"Enter value for ${column[$i]}: " value
        if [[ "${data_type[$i]}" == "int" ]]; then   #### float check and date check can be added here as further enhancement ####
            # Validate integer input
            while ! [[ "$value" =~ ^-?[0-9]+$ ]]; do
                echo "Invalid input. Please enter an integer value for ${column[$i]}."
                read -p"Enter value for ${column[$i]}: " value
            done
        fi
        if [[ -z "$values" ]]; then
            values="$value"
        else
        values="$values":"$value"
        fi
    done
    echo "$values" >> "$table_path"
    echo "Record inserted successfully into '$table_name'."
else
    echo "Table '$table_name' does not exist in database '$database_name'."
fi