#! /bin/bash

#create main menu
select choice in "Create Database" "List Databases" "Connect To Databases" "Drop Database"
do 
case $REPLY in
1)
echo "Create Database"
;;
2)
echo "List Databases"
;;
3)
echo "Connect To Databases"
;;
4)
echo "Drop Database"
;;
*)
echo "print $REPLY is not one of the choices"
exit
;;

esac
done

