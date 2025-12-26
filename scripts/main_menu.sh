#! /bin/bash

#create main menu
select choice in "Create Database" "List Databases" "Connect To Databases" "Drop Database"
do 
case $REPLY in
1)
./create_database.sh
echo "Create Database"
;;
2)
#./list_database.sh
echo "List Databases"
;;
3)
#./conect_to_database.sh
echo "Connect To Databases"
;;
4)
#./drop_database.sh
echo "Drop Database"
;;
*)
echo "print $REPLY is not one of the choices"
exit
;;

esac
done

