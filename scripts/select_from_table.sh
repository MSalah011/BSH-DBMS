#! /bin/bash
database_name=$1
db_path="./Databases"
echo -n "Enter table name: "
read table_name
table_path="$db_path/$database_name/$table_name"
# check table exists
if [ -f "$table_path" ]; then
    #print name of columns
    columns=$(sed -n '3p' "$table_path")
    echo "----------------------------"
    echo "$columns"
    echo "----------------------------"
    # select all from table
    sed -n '4,$p' "$table_path"
else
    echo "Table does not exist!"
    exit 1
fi 