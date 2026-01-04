#! /bin/bash
db_path="./Databases"

echo -n "Enter database name to drop: "
read db_name

#check for empty database name
if [[ -z "$db_name" ]]; then
    echo "Cannot drop database: name cannot be empty!"
    exit 1
fi

# check database is exist
if [[ -d "$db_path/$db_name" ]]; then
    echo -n "Are you sure you want to delete '$db_name'? (y/n): "
    read confirm
    
#check confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        rm -r "$db_path/$db_name"
        echo "Database '$db_name' deleted successfully."
    else
        echo "Drop cancelled."
    fi
else
    echo "Database '$db_name' does not exist."
fi