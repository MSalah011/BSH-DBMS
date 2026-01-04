#! /bin/bash
db_path="./Databases"
database_name="$1"
clear
echo "--- DATABASE MANAGEMENT SYSTEM ---"
echo "----------------------------------"
echo "--------- CREATE TABLE ----------"
echo "----------------------------------"
echo ""
#read name from user
echo -n "Enter the name of table: "
read table_name
# Check for empty table name
if [[ -z "$table_name" ]]; then
    echo "Table name cannot be empty!"
    exit 1
fi
# Check for invalid characters in table name
if [[ "$table_name" =~ [/:\"\'\\\?\*\<\>\|] ]]; then
    echo "Table name contains invalid characters! Please avoid / : \" ' \ ? * < > |"
    exit 1
fi

# save path 
table_path="$db_path"/"$database_name"/"$table_name"

#check if table exists or not
if [ -f "$table_path" ];then
    echo "the table already exist"
    sleep 2
    exit 1
else
    #read number of col from user
    echo -n "Enter number of columns: "
    read col_num

    columns=""
    data_types=""

    #read name and datatype of col from user
    for ((i=1; i<=col_num; i++ ))
    do
        echo -n "Enter name of column $i: "
        read col_name
        echo -n "Enter datatype of $col_name (int|string): "
        read col_type
        while [[ "$col_type" != "int" && "$col_type" != "string" ]]; do
            echo "Invalid datatype. Please enter 'int' or 'string'."
            echo -n "Enter datatype of $col_name (int|string): "
            read col_type
        done
        #check if column is the first or not
        if [ $i -eq 1 ]; then
            columns="$col_name"
            data_types="$col_type"
        else
            columns="$columns:$col_name"
            data_types="$data_types:$col_type"
        fi
    done
    IFS=':' read -ra col_array <<< "$columns"
    while true; do
        #read pk for which col from user
        echo -n "Enter Primary key column name(Leave blank if no primary key is needed): "
        read pk
        # Validate that the primary key exists in the columns
        if [[ -z "$pk" ]]; then
            echo "No primary key set for the table."
            break
        elif [[ ! " ${col_array[*]} " =~ " $pk " ]]; then
            echo "Column '$pk' does not exist in the table. Please enter a valid column name."
        else
            break
        fi
    done
    #create table
    touch "$table_path"
    touch "$table_path".metadata
    #write pk of table
    echo "PK:$pk" >> "$table_path".metadata
    #write datatype of columns  
    echo "$data_types" >> "$table_path".metadata
    #write name of columns 
    echo "$columns" >> "$table_path".metadata
   
    echo "the $table_name table is created successfully."
    sleep 2
    exit 0
fi
