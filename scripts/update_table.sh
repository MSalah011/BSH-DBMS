#!/bin/bash
# This script updates a database table cell with new data
db_path="./Databases"
database_name="$1"
clear
echo "--- DATABASE MANAGEMENT SYSTEM ---"
echo "----------------------------------"
echo "---------- UPDATE TABLE ----------"
echo "----------------------------------"
echo ""
./scripts/list_tables.sh $database_name
echo ""
read -p"Enter table name: " table_name
table_path="$db_path/$database_name/$table_name"
# Check if table exists
if [[ -f "$table_path" ]]; then
    # Read column names from the third line of the table file
    columns=$(sed -n '3p' "$table_path".metadata)
    IFS=':' read -r -a col_array <<< "$columns"
    
    echo "Columns in the table: "
    for i in "${!col_array[@]}"; do
        echo "$((i+1)). ${col_array[i]}"
    done
    
    read -p"Enter the column number to update: " col_num
    if (( col_num < 1 || col_num > ${#col_array[@]} )); then
        echo "Invalid column number."
        exit 1
    fi
    
    col_name=${col_array[$((col_num-1))]}
    read -p"Enter the condition value to identify rows to update (e.g., ID=5): " condition
    # Extract condition column and value
    IFS='=' read -r cond_col cond_value <<< "$condition"

    # Get the index of the condition column
    cond_index=$(awk -F':' -v col="$cond_col" 'NR==3 { for(i=1; i<=NF; i++) { if($i == col) { print i; exit } } }' "$table_path".metadata)
    if [ -z "$cond_index" ]; then
        echo "Column $cond_col not found"
        exit 1
    fi
    IFS=':' read -r -a data_type <<< $(sed -n '2p' "$table_path".metadata)
    read -p"Enter the new value for column '$col_name': " new_value
    if [[ "${data_type[$col_num-1]}" == "int" ]]; then   #### float check and date check can be added here as further enhancement ####
        # Validate integer input
        while ! [[ "$new_value" =~ ^-?[0-9]+$ ]]; do
            if [[ -z "$new_value" ]]; then
                break
            fi
            echo "Invalid input. Please enter an integer value for ${column[$i]}."
            read -p"Enter value for ${column[$i]}: " new_value
        done
    fi
    IFS=':' read -r PK PK_col <<< "$(sed -n '1p' "$table_path".metadata)"
    if [[ "$col_name" == "$PK_col" ]]; then
        if [[ -z "$new_value" ]]; then
            echo "Primary key value cannot be NULL. Please enter a valid value."
            exit 1
        fi
        # Check for uniqueness of primary key
        if awk -F: -v c="$col_num" -v val="$new_value" '$c == val {exit 1}' "$table_path".metadata; then
            :
        else
            echo "Value '$new_value' already exists in column $col_name. Please enter a unique value."
            exit 1
        fi
    fi
    # Update the table
    awk -F: -v OFS=: -v col_idx="$((col_num))" -v cond_idx="$cond_index" -v cond_val="$cond_value" -v new_val="$new_value" '
    NR <= 3 { print; next }
    $((cond_idx)) == cond_val { $((col_idx)) = new_val }
    { print }
    ' "$table_path" > "${table_path}.tmp" && mv "${table_path}.tmp" "$table_path"
    
    echo "Table '$table_name' updated successfully."
else
    echo "Table '$table_name' does not exist in database '$database_name'."
fi