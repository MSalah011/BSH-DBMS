# Bash Shell Script DBMS

##  Project Overview

This project is a **Database Management System (DBMS)** implemented using **Bash Shell Scripting**. It simulates core DBMS functionalities such as creating databases and tables, inserting, selecting, updating, and deleting records using plain text files as storage.

The project was developed for **Bash Scripting Course** as a part of the **ITI Telecom Applications Development Track**, but it goes beyond the basic requirements by supporting advanced SQL-like operations.

---

##  Features

###  Database Operations

* Create Database
* List Databases
* Connect to Database
* Drop Database

###  Table Operations

* Create Table (with column names, data types, and Primary Key)
* List Tables
* Drop Table

###  Data Operations 

* Insert into Table

  * Data type validation (int / string)
  * Primary Key enforcement (NOT NULL & UNIQUE)

* Select From Table

  * Select all columns or specific columns
  * WHERE conditions with:

    * `=` , `!=` , `>` , `<` , `>=` , `<=`
    * `BETWEEN`
    * `IN`
    * Logical operators `AND` / `OR`

* Update Table

  * Update records using condition (column=value)
  * Data type validation

* Delete From Table

  * Delete records based on condition

---

##  Project Structure

```
DBMS/
│
├── main.sh
├── setup.sh
├── Databases/
│   └── (created databases stored here)
│
├── scripts/
│   ├── main_menu.sh
│   ├── create_database.sh
│   ├── list_databases.sh
│   ├── connect_to_database.sh
│   ├── drop_databases.sh
│   ├── db_menu.sh
│   ├── create_table.sh
│   ├── list_tables.sh
│   ├── drop_table.sh
│   ├── insert_into_table.sh
│   ├── select_from_table.sh
│   ├── update_table.sh
│   └── delete_from_table.sh
```

---

## How to Run

### 1-Give Execute Permissions

```bash
chmod +x setup.sh
./setup.sh
```

### 2-Start the Application

```bash
./main.sh
```

---

## Table File Format

Each table is stored as a text file with the following structure:

```
PK:id
dataType1:dataType2:dataType3
column1:column2:column3
-------------------------------
value1:value2:value3
value1:value2:value3
```

* Line 1 → Primary Key
* Line 2 → Data Types
* Line 3 → Column Names
* Line 4+ → Table Records

---

## Concepts Used

* Bash scripting fundamentals
* File handling
* `awk`, `sed`, `grep`
* Loops and conditionals
* Menus using `select`
* Input validation
* Modular scripting

---

##  Validation Rules

* Database and table names cannot be empty or contain invalid characters
* Primary Key:

  * Cannot be NULL
  * Must be UNIQUE
* Integer columns accept only numeric values

---

## Possible Enhancements

* Support for additional data types (float, date)
* Foreign key support

---

## Authors

* Ahmed Omar
* Mahmoud Salah

---

##  License

This project is for educational purposes only.