#! /bin/bash
database_name=$1
db_path="./Databases"
echo -n "Enter table name: "
read table_name
table_path="$db_path/$database_name/$table_name"
# check table exists
if [ -f "$table_path" ]; then
    # select all from table
    echo "1) Select All"
    echo "2) Select With WHERE"
    echo -n "Choose option: "
    read choice
    case $choice in
        1)
             #print name of columns
            columns=$(sed -n '3p' "$table_path")
            echo "----------------------------"
            echo "$columns"
            echo "----------------------------"
            # -------- Select All --------
            awk -F: 'NR > 3 { print }' "$table_path"
            ;;
        2)
            # -------- Select With WHERE --------
            echo -n "Enter column name: "
            read col_name
           #get operator  
            echo "1) ="
            echo "2) >"
            echo "3) <"
            echo "4) !="
            echo "5) >="
            echo "6) <="
            echo "7) BETWEEN"
            echo -n "Choose operator:"
            read op
            # read value(s)
            if [ "$op" -eq 7 ]; then
                echo -n "Enter start value: "
                read start
                echo -n "Enter end value: "
                read end
            else
                echo -n "Enter value: "
                read value
            fi
            #print name of columns
            columns=$(sed -n '3p' "$table_path")
            echo "----------------------------"
            echo "$columns"
            echo "----------------------------"
            # get column number
            col_num=$(echo "$columns" | awk -F: -v col="$col_name" '{
                for (i=1; i<=NF; i++) {
                    if ($i == col) {
                        print i
                        exit
                    }
                }
            }')
            # check column exists
            if [ -z "$col_num" ]; then
                echo "Column not found!"
                exit 1
            fi
            # select rows
            case $op in
            1)
                # =
                awk -F: -v c="$col_num" -v v="$value" \
                    'NR > 3 && $c == v { print }' "$table_path"
                ;;
            2)
                 # >
                awk -F: -v c="$col_num" -v v="$value" \
                    'NR > 3 && $c > v { print }' "$table_path"
                ;;
            3)
                # <
                awk -F: -v c="$col_num" -v v="$value" \
                    'NR > 3 && $c < v { print }' "$table_path"
                ;; 
            4)
                 # !=
                awk -F: -v c="$col_num" -v v="$value" \
                    'NR > 3 && $c != v { print }' "$table_path"
                ;;
            5)
                # >=
                awk -F: -v c="$col_num" -v v="$value" \
                    'NR > 3 && $c >= v { print }' "$table_path"
                ;;
            6)
                # <=
                awk -F: -v c="$col_num" -v v="$value" \
                    'NR > 3 && $c <= v { print }' "$table_path"
                ;;
            7)
                # between
                awk -F: -v c="$col_num" -v s="$start" -v e="$end" \
                    'NR > 3 && $c >= s && $c <= e { print }' "$table_path"
                ;;
            *)
                echo "Invalid operator!"
                ;;
            esac
                ;;

        *)
            echo "Invalid choice!"
            ;;
        esac

else
    echo "Table does not exist!"
    exit 1
fi 