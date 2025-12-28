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
# save path 
table_path=$db_path/$database_name/$table_name

#check if table exists or not
if [ -f "$table_path" ];then
    echo "the table already exist"
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
        #check if column is the frist or not
        if [ $i -eq 1 ]; then
            columns="$col_name"
            data_types="$col_type"
        else
            columns="$columns:$col_name"
            data_types="$data_types:$col_type"
        fi
    done
    #read pk for which col from user
    echo -n "Enter Primary key column name: "
    read pk
    #create table
    touch "$table_path"
    #write pk of table
    echo "PK:$pk" >> "$table_path"
    #write datatype of columns 
    echo "$data_types" >> "$table_path"
    #write name of columns 
    echo "$columns" >> "$table_path"
   
   
    echo "the $table_name table is created"
fi
