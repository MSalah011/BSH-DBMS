#!/bin/bash
# This script inserts a record into a specified table in a specified database
db_path="./Databases"
database_name="$1"
clear
echo "--- DATABASE MANAGEMENT SYSTEM ---"
echo "----------------------------------"
echo "-------- INSERT INTO TABLE -------"
echo "----------------------------------"
echo ""
./scripts/list_tables.sh $database_name
echo ""
read -p"Enter table name: " table_name
table_path="$db_path/$database_name/$table_name"
# Check if table exists
if [[ -f "$table_path" ]]; then
    # Read the first line to get primary key column
    IFS=':' read -r PK primary_key <<< $(sed -n '1p' "$table_path")
    # Read the second line to get column data types
    IFS=':' read -r -a data_type <<< $(sed -n '2p' "$table_path")
    # Read the third line to get column names
    IFS=':' read -r -a column <<< $(sed -n '3p' "$table_path")
    for (( i=0; i<${#column[@]}; i++ )); do
        if [[ "${column[$i]}" == "$primary_key" ]]; then
            while true; do
                read -p"Enter value for primary key ${column[$i]}: " pk_value
                # Check for NULL value
                if [[ -z "$pk_value" ]]; then
                    echo "Primary key value cannot be NULL. Please enter a valid value."
                    continue
                fi
                # Validate integer input for primary key if its data type is int
                if [[ "${data_type[$i]}" == "int" && ! "$pk_value" =~ ^-?[0-9]+$ ]]; then
                    echo "Invalid input. Please enter an integer value for primary key ${column[$i]}."
                    continue
                fi
                # Check for uniqueness of primary key
                if awk -F: -v c="$((i+1))" -v val="$pk_value" 'NR>3 && $c == val {exit 1}' "$table_path"; then
                :
                else
                    echo "Value '$pk_value' already exists: Primary key should be unique."
                    continue
                fi
                break
            done
            value=$pk_value
        else
            read -p"Enter value for ${column[$i]}: " value
        fi
        if [[ "${data_type[$i]}" == "int" ]]; then   #### float check and date check can be added here as further enhancement ####
            # Validate integer input
            while ! [[ "$value" =~ ^-?[0-9]+$ ]]; do
                if [[ -z "$value" ]]; then
                    break
                fi
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