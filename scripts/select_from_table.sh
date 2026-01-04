#! /bin/bash
database_name="$1"
clear
echo "--- DATABASE MANAGEMENT SYSTEM ---"
echo "----------------------------------"
echo "-------- SELECT FROM TABLE -------"
echo "----------------------------------"
echo ""
./scripts/list_tables.sh $database_name
echo ""
db_path="./Databases"
echo -n "Enter table name: "
read table_name
table_path="$db_path/$database_name/$table_name"
# check table exists
if [ -f "$table_path" ]; then
    # select all from table
    echo "1) Select without condition"
    echo "2) Conditional Select"
    echo -n "Choose option: "
    read choice
    columns=$(sed -n '3p' "$table_path".metadata)
    echo "----------------------------"
    echo "$columns"
    echo "----------------------------"
    # Ask user which columns to display
    echo -n "Enter columns to display separated by colon (e.g. id:name:age) or * for all: "
    read display_cols
    if [ "$display_cols" = "*" ]; then
            display_indexes=""
    else
            display_indexes=""
            IFS=":" read -ra arr <<< "$display_cols"
            for col in "${arr[@]}"; do
                idx=$(echo "$columns" | awk -F: -v col="$col" '{
                    for(i=1;i<=NF;i++) if($i==col){print i; exit}
                }')
                if [ -z "$idx" ]; then
                    echo "Column $col not found!"
                    exit 1
                fi
                display_indexes="$display_indexes $idx"
            done
    fi
    #function to print all columns or part of columns
    print_selected_cols() {
        awk -F: -v cols="$display_indexes" '
        BEGIN {
            if (cols != "") {
                split(cols, sel, " ")
            }
        }

        NR==1 {
            # Header
            if (cols == "") {
                for (i=1;i<=NF;i++)
                    printf "| %-15s ", $i
            } else {
                for (i in sel)
                    printf "| %-15s ", $(sel[i])
            }
            print "|"

            # Separator
            for (i=1;i<= (cols==""?NF:length(sel)); i++)
                printf "+%.17s", "-----------------------"
            print "+"
            next
        }

        {
            if (cols == "") {
                for (i=1;i<=NF;i++)
                    printf "| %-15s ", $i
            } else {
                for (i=1; i<=length(sel); i++)
                    printf "| %-15s ", $(sel[i])
            }
            print "|"
        }
        '
    }

    case $choice in
        1)
            # Select All
            {
                echo $columns
                cat "$table_path"     
            } | print_selected_cols 
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
            echo "10) OR"
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
            # if user choice OR or AND    
            elif [ "$op" -eq 9 ] || [ "$op" -eq 10 ]; then
                echo "---- First Condition ----"
                read -p"Enter the condition value to identify rows to select (WHERE condition) (e.g., ID=5): " condition
                IFS='=' read -r col1 val1 <<< "$condition"
                echo "---- Second Condition ----"
                read -p"Enter the condition value to identify rows to select (WHERE condition) (e.g., ID=5): " condition
                IFS='=' read -r col2 val2 <<< "$condition" 
            else
                read -p"Enter the condition value to identify rows to select (WHERE condition) (e.g., ID=5): " condition
                IFS='=' read -r col_name value <<< "$condition"
            fi

            # if choice AND or OR
            if [ "$op" -eq 9 ] || [ "$op" -eq 10 ]; then
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
                {
                    echo $columns
                    awk -F: -v c="$col_num" -v v="$value" '
                    $c == v { print }' "$table_path"
                } | print_selected_cols
                ;;
            2)
                # >
                {
                    echo $columns
                    awk -F: -v c="$col_num" -v v="$value" '
                    $c > v { print }' "$table_path" 
                } | print_selected_cols
                ;;
            3)
                # <
                {
                    echo $columns
                    awk -F: -v c="$col_num" -v v="$value" '
                    $c < v { print }' "$table_path" 
                } | print_selected_cols
                ;; 
            4)
                # !=
                {
                    echo $columns
                    awk -F: -v c="$col_num" -v v="$value"'
                    $c != v { print }' "$table_path"
                } | print_selected_cols
                ;;
            5)
                # >=
                {
                    echo $columns
                    awk -F: -v c="$col_num" -v v="$value"'
                    $c >= v { print }' "$table_path" 
                } | print_selected_cols
                ;;
            6)
                # <=
                {
                    echo $columns
                    awk -F: -v c="$col_num" -v v="$value"'
                    $c <= v { print }' "$table_path" 
                } | print_selected_cols
                ;;
            7)
                # between
                {
                    echo $columns
                    awk -F: -v c="$col_num" -v s="$start" -v e="$end" '
                    $c >= s && $c <= e { print }' "$table_path" 
                } | print_selected_cols
                ;;
            8)
                # IN
                {
                    echo $columns
                    awk -F: -v c="$col_num" -v vals="$in_values" '
                    BEGIN {
                        split(vals, arr, ":")
                    }
                    {
                        for (i in arr) {
                            if ($c == arr[i]) {
                                print
                                break
                            }
                        }
                    }' "$table_path"
                } | print_selected_cols
                ;;
            9)
                #And
                {
                    echo $columns
                    awk -F: -v c1="$col_num1" -v v1="$val1" -v c2="$col_num2" -v v2="$val2" '
                    $c1 == v1 && $c2 == v2 { print }' "$table_path" 
                } | print_selected_cols
                ;;
            10) 
                # OR
                {
                    echo $columns
                    awk -F: -v c1="$col_num1" -v v1="$val1" -v c2="$col_num2" -v v2="$val2" '
                    $c1 == v1 || $c2 == v2 { print }' "$table_path" 
                } | print_selected_cols
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