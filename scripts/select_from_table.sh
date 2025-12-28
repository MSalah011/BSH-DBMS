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
           #get operator  
            echo "1) ="
            echo "2) >"
            echo "3) <"
            echo "4) !="
            echo "5) >="
            echo "6) <="
            echo "7) BETWEEN"
            echo "8) IN"
            echo "9) AND"
            echo -n "Choose operator:"
            read op
            # read value(s)
            #if user choice between
            if [ "$op" -eq 7 ]; then
                #read name of column
                echo -n "Enter column name: "
                read col_name
                #get values
                echo -n "Enter start value: "
                read start
                echo -n "Enter end value: "
                read end
            #if user choice IN
            elif [ "$op" -eq 8 ]; then
                #read name of column
                echo -n "Enter column name: "
                read col_name
                #get values
                echo -n "Enter values separated by colon (e.g. 10:20:30): "
                read in_values
            elif [ "$op" -eq 9 ]; then
                echo "---- First Condition ----"
                #get name of column1
                echo -n "Column name: "
                read col1
                #get value of col1
                echo -n "Value: "
                read val1
                echo "---- Second Condition ----"
                #get name of col2
                echo -n "Column name: "
                read col2
                #get value of col2
                echo -n "Value: "
                read val2    
            else
                #read name of column
                echo -n "Enter column name: "
                read col_name
                #get value 
                echo -n "Enter value: "
                read value
            fi
            #print name of columns
            columns=$(sed -n '3p' "$table_path")
            echo "----------------------------"
            echo "$columns"
            echo "----------------------------"
           # Get column numbers
            if [ "$op" -eq 9 ]; then
                # AND: get numbers for both columns
                col_num1=$(echo "$columns" | awk -F: -v col="$col1" '{
                    for (i=1; i<=NF; i++) if ($i==col) {print i; exit}
                }')
                col_num2=$(echo "$columns" | awk -F: -v col="$col2" '{
                    for (i=1; i<=NF; i++) if ($i==col) {print i; exit}
                }')
                if [ -z "$col_num1" ] || [ -z "$col_num2" ]; then
                    echo "Column not found!"
                    exit 1
                fi
            else
                # Single column
                col_num=$(echo "$columns" | awk -F: -v col="$col_name" '{
                    for (i=1; i<=NF; i++) if ($i==col) {print i; exit}
                }')
                if [ -z "$col_num" ]; then
                    echo "Column not found!"
                    exit 1
                fi
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
            8)
                # IN
                awk -F: -v c="$col_num" -v vals="$in_values" '
                BEGIN {
                    split(vals, arr, ":")
                }
                NR > 3 {
                    for (i in arr) {
                        if ($c == arr[i]) {
                            print
                            break
                        }
                    }
                }' "$table_path"
                ;;
            9)
                #And
                awk -F: -v c1="$col_num1" -v v1="$val1" \
                    -v c2="$col_num2" -v v2="$val2" \
                'NR > 3 && $c1 == v1 && $c2 == v2 { print }' "$table_path"
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