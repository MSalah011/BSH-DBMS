#!/bin/bash
# This script deletes records from a specified table in a database
db_path="./Databases"
database_name="$1"
clear
echo "--- DATABASE MANAGEMENT SYSTEM ---"
echo "----------------------------------"
echo "-------- DELETE FROM TABLE -------"
echo "----------------------------------"
echo ""
echo "Delete From Table in Database:" $database_name
read -p "Enter the table name to delete from: " table_name
table_path="$db_path/$database_name/$table_name"
if [ ! -f "$table_path" ]; then
    echo "Table $table_name does not exist in database $database_name."
    exit 1
fi
read -p "Enter the condition for deletion ( column=value ): " condition
IFS='=' read -r condition_column condition_value <<< "$condition"
if [ -z "$condition_column" ] || [ -z "$condition_value" ]; then
    echo "Invalid condition format. Use column=value."
    exit 1
fi
# Get the index of the condition column
col_index=$(awk -F':' -v col="$condition_column" 'NR==3 { for(i=1; i<=NF; i++) { if($i == col) { print i; exit } } }' "$table_path")
if [ -z "$col_index" ]; then
    echo "Column $condition_column not found"
    exit 1
fi
# Find the line number of the record to delete
line_num=$(awk -F':' -v col="$col_index" -v val="$condition_value" 'NR>3 && $col==val  { print NR }' "$table_path")

if [ -z "$line_num" ]; then
    echo "No record found matching condition $condition."
    exit 1
fi
delete_cmd=$(echo $line_num | awk '{for(i=1;i<=NF;i++) printf "%sd;", $i}')
sed -i "$delete_cmd" "$table_path"
echo "Record(s) matching condition $condition deleted successfully from table $table_name." 
