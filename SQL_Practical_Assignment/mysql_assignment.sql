{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "e920233f-040e-4d6f-b5ca-530b79ba0f0b",
   "metadata": {},
   "outputs": [],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "import pandas as pd\n",
    "import numpy as np\n",
    "import seaborn as sns\n",
    "import matplotlib .pyplot as plt"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "1f2231e7-906e-4dd7-aa0d-5bf27f9012e2",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "MySQL Database connection successful\n",
      "<mysql.connector.connection_cext.CMySQLConnection object at 0x7f8eb59e8110>\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "\n",
    "def create_server_connection(host_name, user_name, user_password):\n",
    "    connection = None\n",
    "    try:\n",
    "        connection = mysql.connector.connect(\n",
    "            host = host_name,\n",
    "            user = user_name,\n",
    "            password = user_password\n",
    "        )\n",
    "        print(\"MySQL Database connection successful\")\n",
    "    except Error as err:\n",
    "        print(f\"Error: '{err}'\")\n",
    "    return connection\n",
    "#Put your MySQL terminal password\n",
    "password = \"Ruby@2020\"\n",
    "\n",
    "#Database name\n",
    "db = \"edu_institute\"\n",
    "connection = create_server_connection(\"localhost\", \"root\", password)\n",
    "print(connection)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "a28e3fd7-4c67-4e77-9e77-d4f6fc323893",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL server\n",
      "Database created successfully\n",
      "MySQL connection closed\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "\n",
    "def create_database(connection, query):\n",
    "    cursor = connection.cursor()\n",
    "    try:\n",
    "        cursor.execute(query)\n",
    "        print(\"Database created successfully\")\n",
    "    except Error as err:\n",
    "        print(f\"Error: {err}\")\n",
    "\n",
    "try:\n",
    "    # Connect to MySQL server\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\"\n",
    "    )\n",
    "    print(\"Connected to MySQL server\")\n",
    "\n",
    "    # Define the query to create the database\n",
    "    create_database_query = \"CREATE DATABASE IF NOT EXISTS edu_institute\"\n",
    "\n",
    "    # Call the function to create the database\n",
    "    create_database(connection, create_database_query)\n",
    "\n",
    "except Error as e:\n",
    "    print(f\"Error: {e}\")\n",
    "\n",
    "finally:\n",
    "    if 'connection' in locals() and connection.is_connected():\n",
    "        connection.close()\n",
    "        print(\"MySQL connection closed\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "29ef8a20-026c-4a10-9fec-3c34871cc326",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL database\n",
      "Table dropped successfully\n",
      "Table created successfully\n",
      "Data inserted successfully\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "\n",
    "def create_table(connection, create_table_query):\n",
    "    cursor = connection.cursor()\n",
    "    try:\n",
    "        cursor.execute(create_table_query)\n",
    "        print(\"Table created successfully\")\n",
    "    except Error as err:\n",
    "        print(f\"Error: {err}\")\n",
    "\n",
    "def insert_data(connection, insert_data_query, data):\n",
    "    cursor = connection.cursor()\n",
    "    try:\n",
    "        cursor.executemany(insert_data_query, data)\n",
    "        connection.commit()\n",
    "        print(\"Data inserted successfully\")\n",
    "    except Error as err:\n",
    "        connection.rollback()\n",
    "        print(f\"Error: {err}\")\n",
    "\n",
    "try:\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\",\n",
    "        database=\"edu_institute\"\n",
    "    )\n",
    "    print(\"Connected to MySQL database\")\n",
    "except Error as err:\n",
    "    print(f\"Error: {err}\")\n",
    "\n",
    "# Define the SQL queries separately\n",
    "drop_table_query = \"DROP TABLE IF EXISTS students\"\n",
    "create_table_query = \"\"\"\n",
    "CREATE TABLE students (\n",
    "    student_id INT AUTO_INCREMENT PRIMARY KEY,\n",
    "    name VARCHAR(50),\n",
    "    age INT,\n",
    "    gender CHAR(1),\n",
    "    enrollment_date DATE,\n",
    "    program VARCHAR(50)\n",
    ")\n",
    "\"\"\"\n",
    "\n",
    "insert_query = \"\"\"\n",
    "INSERT INTO students (name, age, gender, enrollment_date, program) \n",
    "VALUES (%s, %s, %s, %s, %s)\n",
    "\"\"\"\n",
    "data = [\n",
    "    ('John Doe', 25, 'M', '2022-01-15', 'Computer Science'),\n",
    "    ('Jane Smith', 22, 'F', '2022-02-20', 'Data Science'),\n",
    "    ('Michael Johnson', 28, 'M', '2021-12-10', 'Mathematics'),\n",
    "    ('Emily Brown', 23, 'F', '2022-03-05', 'Engineering'),\n",
    "    ('David Lee', 27, 'M', '2022-02-10', 'Data Science')\n",
    "]\n",
    "\n",
    "if connection.is_connected():\n",
    "    # Drop the existing table\n",
    "    cursor = connection.cursor()\n",
    "    cursor.execute(drop_table_query)\n",
    "    print(\"Table dropped successfully\")\n",
    "    \n",
    "    # Create a new table\n",
    "    create_table(connection, create_table_query)\n",
    "    \n",
    "    # Insert data into the new table\n",
    "    insert_data(connection, insert_query, data)\n",
    "else:\n",
    "    print(\"Connection to MySQL database failed\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "8b31f79e-c744-4091-8898-399ac0f3b796",
   "metadata": {
    "scrolled": true
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL database\n",
      "+--------------+-----------------+-------+----------+-------------------+------------------+\n",
      "|   Student_Id | Name            |   Age | Gender   | Enrollment_Date   | Program          |\n",
      "+==============+=================+=======+==========+===================+==================+\n",
      "|            1 | John Doe        |    25 | M        | 2022-01-15        | Computer Science |\n",
      "+--------------+-----------------+-------+----------+-------------------+------------------+\n",
      "|            2 | Jane Smith      |    22 | F        | 2022-02-20        | Data Science     |\n",
      "+--------------+-----------------+-------+----------+-------------------+------------------+\n",
      "|            3 | Michael Johnson |    28 | M        | 2021-12-10        | Mathematics      |\n",
      "+--------------+-----------------+-------+----------+-------------------+------------------+\n",
      "|            4 | Emily Brown     |    23 | F        | 2022-03-05        | Engineering      |\n",
      "+--------------+-----------------+-------+----------+-------------------+------------------+\n",
      "|            5 | David Lee       |    27 | M        | 2022-02-10        | Data Science     |\n",
      "+--------------+-----------------+-------+----------+-------------------+------------------+\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "from tabulate import tabulate\n",
    "\n",
    "def display_table_contents(connection, students):\n",
    "    try:\n",
    "        cursor = connection.cursor()\n",
    "        cursor.execute(f\"SELECT * FROM {students}\")\n",
    "        rows = cursor.fetchall()\n",
    "        \n",
    "        if not rows:\n",
    "            print(f\"No records found in the '{students}' table.\")\n",
    "            return\n",
    "            \n",
    "        column_names = [col[0].title() for col in cursor.description]  # Capitalize column names\n",
    "        formatted_data = []\n",
    "        for row in rows:\n",
    "            formatted_row = [\n",
    "                row[0], \n",
    "                str(row[1]),  # Convert date to string\n",
    "                str(row[2]),  # Convert age to string\n",
    "                row[3].upper(), \n",
    "                row[4], \n",
    "                row[5]\n",
    "            ]\n",
    "            formatted_data.append(formatted_row)\n",
    "\n",
    "        print(tabulate(formatted_data, headers=column_names, tablefmt=\"grid\"))  \n",
    "\n",
    "    except Error as e:\n",
    "        print(f\"Error: {e}\")\n",
    "\n",
    "# Connect to MySQL database\n",
    "try:\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        database=\"edu_institute\",\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\"\n",
    "    )\n",
    "    print(\"Connected to MySQL database\")\n",
    "except Error as e:\n",
    "    print(f\"Error: {e}\")\n",
    "\n",
    "# Call the function to display contents of a table\n",
    "if connection.is_connected():\n",
    "    display_table_contents(connection, \"students\")  # Specify your table name here\n",
    "else:\n",
    "    print(\"Connection to MySQL database failed\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "8e8a666a-0650-4a78-81c9-0eaff99ec95a",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL database\n",
      "Total Students: 5\n",
      "Disconnected from MySQL database\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "\n",
    "def count_total_students(connection):\n",
    "    try:\n",
    "        cursor = connection.cursor()\n",
    "        cursor.execute(\"SELECT COUNT(*) AS total_students FROM students\")\n",
    "        result = cursor.fetchone()\n",
    "        total_students = result[0]\n",
    "        print(f\"Total Students: {total_students}\")\n",
    "    except Error as e:\n",
    "        print(f\"Error: {e}\")\n",
    "\n",
    "# Example usage:\n",
    "try:\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        database=\"edu_institute\",\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\"\n",
    "    )\n",
    "    print(\"Connected to MySQL database\")\n",
    "    count_total_students(connection)\n",
    "except Error as e:\n",
    "    print(f\"Error: {e}\")\n",
    "finally:\n",
    "    if connection.is_connected():\n",
    "        connection.close()\n",
    "        print(\"Disconnected from MySQL database\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "390ef9b4-e73e-4a2d-95d5-254f29ea57be",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL database\n",
      "Column 'Today's Date' added successfully to table 'students'.\n",
      "Disconnected from MySQL database\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "\n",
    "def add_current_date_column(connection, students, column_name=\"Today's Date\"):\n",
    "    \"\"\"Adds a new column named 'column_name' with the current date (DATE data type)\n",
    "       as the default value to the specified table, if it doesn't already exist.\n",
    "\n",
    "    Args:\n",
    "        connection (mysql.connector.connection): The connection object to the MySQL database.\n",
    "        table_name (str): The name of the table to add the column to.\n",
    "        column_name (str, optional): The desired name for the new column. Defaults to \"Today's Date\".\n",
    "\n",
    "    Returns:\n",
    "        None\n",
    "    \"\"\"\n",
    "\n",
    "    try:\n",
    "        cursor = connection.cursor()\n",
    "\n",
    "        # Check if the column already exists (optional)\n",
    "        check_query = f\"DESCRIBE {students}\"\n",
    "        cursor.execute(check_query)\n",
    "        existing_columns = [col[0] for col in cursor.fetchall()]\n",
    "\n",
    "        if column_name not in existing_columns:\n",
    "            query = f\"ALTER TABLE {students} ADD COLUMN `{column_name}` DATE DEFAULT (CURRENT_DATE())\"\n",
    "            cursor.execute(query)\n",
    "            print(f\"Column '{column_name}' added successfully to table '{students}'.\")\n",
    "        else:\n",
    "            print(f\"Column '{column_name}' already exists in table '{students}'.\")\n",
    "\n",
    "    except Error as err:\n",
    "        print(f\"Error adding column: {err}\")\n",
    "\n",
    "# Example usage with checking for existing column\n",
    "try:\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        database=\"edu_institute\",\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\"  # Replace with your actual password\n",
    "    )\n",
    "    print(\"Connected to MySQL database\")\n",
    "\n",
    "    add_current_date_column(connection, \"students\")\n",
    "\n",
    "except Error as err:\n",
    "    print(f\"Connection error: {err}\")\n",
    "\n",
    "finally:\n",
    "    if connection.is_connected():\n",
    "        connection.close()\n",
    "        print(\"Disconnected from MySQL database\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "efe850b0-9732-4d3b-8f9b-ef1ace94deb9",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL database\n",
      "Current Date: 2024-03-09\n",
      "Disconnected from MySQL database\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "\n",
    "def display_current_date(connection):\n",
    "    try:\n",
    "        cursor = connection.cursor()\n",
    "\n",
    "        # Define the query\n",
    "        query = \"SELECT CURRENT_DATE() AS `Today's Date`\"\n",
    "\n",
    "        # Execute the query\n",
    "        cursor.execute(query)\n",
    "\n",
    "        # Fetch and print the result\n",
    "        result = cursor.fetchone()\n",
    "        print(\"Current Date:\", result[0])\n",
    "\n",
    "    except Error as err:\n",
    "        print(f\"Error: {err}\")\n",
    "\n",
    "# Example usage\n",
    "try:\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        database=\"edu_institute\",\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\"  # Replace with your actual password\n",
    "    )\n",
    "    print(\"Connected to MySQL database\")\n",
    "\n",
    "    display_current_date(connection)\n",
    "\n",
    "except Error as err:\n",
    "    print(f\"Connection error: {err}\")\n",
    "\n",
    "finally:\n",
    "    if connection.is_connected():\n",
    "        connection.close()\n",
    "        print(\"Disconnected from MySQL database\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "48665972-c4d8-48bf-bbad-09ddb55b4b29",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL database\n",
      "+-----------------+-------------------+\n",
      "| Name            | Enrollment_Date   |\n",
      "+=================+===================+\n",
      "| JOHN DOE        | 2022-01-15        |\n",
      "+-----------------+-------------------+\n",
      "| JANE SMITH      | 2022-02-20        |\n",
      "+-----------------+-------------------+\n",
      "| MICHAEL JOHNSON | 2021-12-10        |\n",
      "+-----------------+-------------------+\n",
      "| EMILY BROWN     | 2022-03-05        |\n",
      "+-----------------+-------------------+\n",
      "| DAVID LEE       | 2022-02-10        |\n",
      "+-----------------+-------------------+\n",
      "MySQL connection closed\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "from tabulate import tabulate\n",
    "\n",
    "def query_students_with_enrollment_dates(connection):\n",
    "    try:\n",
    "        cursor = connection.cursor()\n",
    "        cursor.execute(\"SELECT UPPER(name) AS Name, enrollment_date FROM students\")\n",
    "        rows = cursor.fetchall()\n",
    "\n",
    "        if not rows:\n",
    "            print(\"No records found.\")\n",
    "            return\n",
    "\n",
    "        column_names = [col[0].title() for col in cursor.description]  # Capitalize column names\n",
    "        print(tabulate(rows, headers=column_names, tablefmt=\"grid\"))\n",
    "\n",
    "    except Error as e:\n",
    "        print(f\"Error: {e}\")\n",
    "\n",
    "# Connect to MySQL database\n",
    "try:\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        database=\"edu_institute\",\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\"\n",
    "    )\n",
    "    print(\"Connected to MySQL database\")\n",
    "\n",
    "    # Call the query function\n",
    "    query_students_with_enrollment_dates(connection)\n",
    "\n",
    "except Error as e:\n",
    "    print(f\"Error: {e}\")\n",
    "\n",
    "finally:\n",
    "    if connection.is_connected():\n",
    "        connection.close()\n",
    "        print(\"MySQL connection closed\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "45e80416-9901-45a4-b1f1-0d096a3f68d3",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL database\n",
      "+-----------------+-------------------+\n",
      "| Name            | Enrollment_Date   |\n",
      "+=================+===================+\n",
      "| JOHN DOE        | 2022-01-15        |\n",
      "+-----------------+-------------------+\n",
      "| JANE SMITH      | 2022-02-20        |\n",
      "+-----------------+-------------------+\n",
      "| MICHAEL JOHNSON | 2021-12-10        |\n",
      "+-----------------+-------------------+\n",
      "| EMILY BROWN     | 2022-03-05        |\n",
      "+-----------------+-------------------+\n",
      "| DAVID LEE       | 2022-02-10        |\n",
      "+-----------------+-------------------+\n",
      "MySQL connection closed\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "from tabulate import tabulate\n",
    "\n",
    "def query_students_with_enrollment_dates(connection):\n",
    "    try:\n",
    "        cursor = connection.cursor()\n",
    "        cursor.execute(\"SELECT UPPER(name) AS Name, enrollment_date FROM students\")\n",
    "        rows = cursor.fetchall()\n",
    "\n",
    "        if not rows:\n",
    "            print(\"No records found.\")\n",
    "            return\n",
    "\n",
    "        column_names = [col[0].title() for col in cursor.description]  # Capitalize column names\n",
    "        print(tabulate(rows, headers=column_names, tablefmt=\"grid\"))\n",
    "\n",
    "    except Error as e:\n",
    "        print(f\"Error: {e}\")\n",
    "\n",
    "# Connect to MySQL database\n",
    "try:\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        database=\"edu_institute\",\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\"\n",
    "    )\n",
    "    print(\"Connected to MySQL database\")\n",
    "\n",
    "    # Call the query function\n",
    "    query_students_with_enrollment_dates(connection)\n",
    "\n",
    "except Error as e:\n",
    "    print(f\"Error: {e}\")\n",
    "\n",
    "finally:\n",
    "    if connection.is_connected():\n",
    "        connection.close()\n",
    "        print(\"MySQL connection closed\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "3a1080bf-5f2f-4312-9205-e58242c7c315",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL database\n",
      "+------------------+----------------------+\n",
      "| Program          |   Number Of Students |\n",
      "+==================+======================+\n",
      "| Data Science     |                    2 |\n",
      "+------------------+----------------------+\n",
      "| Computer Science |                    1 |\n",
      "+------------------+----------------------+\n",
      "| Mathematics      |                    1 |\n",
      "+------------------+----------------------+\n",
      "| Engineering      |                    1 |\n",
      "+------------------+----------------------+\n",
      "MySQL connection closed\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "from tabulate import tabulate\n",
    "\n",
    "def count_students_by_program(connection):\n",
    "    try:\n",
    "        cursor = connection.cursor()\n",
    "        cursor.execute(\"\"\"\n",
    "            SELECT program, COUNT(*) AS `Number of Students`\n",
    "            FROM students\n",
    "            GROUP BY program\n",
    "            ORDER BY COUNT(*) DESC\n",
    "        \"\"\")\n",
    "        rows = cursor.fetchall()\n",
    "\n",
    "        if not rows:\n",
    "            print(\"No records found.\")\n",
    "            return\n",
    "\n",
    "        column_names = [col[0].title() for col in cursor.description]  # Capitalize column names\n",
    "        print(tabulate(rows, headers=column_names, tablefmt=\"grid\"))\n",
    "\n",
    "    except Error as e:\n",
    "        print(f\"Error: {e}\")\n",
    "\n",
    "# Connect to MySQL database with updated database name\n",
    "try:\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        database=\"edu_institute\",  # Updated database name here\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\"\n",
    "    )\n",
    "    print(\"Connected to MySQL database\")\n",
    "\n",
    "    # Call the query function\n",
    "    count_students_by_program(connection)\n",
    "\n",
    "except Error as e:\n",
    "    print(f\"Error: {e}\")\n",
    "\n",
    "finally:\n",
    "    if connection.is_connected():\n",
    "        connection.close()\n",
    "        print(\"MySQL connection closed\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "32e99996-4439-4d55-9987-ac1508150f2c",
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Connected to MySQL database\n",
      "Youngest student: Jane Smith, Age: 22\n",
      "MySQL connection closed\n"
     ]
    }
   ],
   "source": [
    "import mysql.connector\n",
    "from mysql.connector import Error\n",
    "\n",
    "def find_youngest_student(connection):\n",
    "    try:\n",
    "        cursor = connection.cursor()\n",
    "        cursor.execute(\"\"\"\n",
    "            SELECT name, age\n",
    "            FROM students\n",
    "            ORDER BY age ASC\n",
    "            LIMIT 1\n",
    "        \"\"\")\n",
    "        row = cursor.fetchone()\n",
    "\n",
    "        if row:\n",
    "            youngest_name, youngest_age = row\n",
    "            print(f\"Youngest student: {youngest_name}, Age: {youngest_age}\")\n",
    "        else:\n",
    "            print(\"No records found.\")\n",
    "\n",
    "    except Error as e:\n",
    "        print(f\"Error: {e}\")\n",
    "\n",
    "# Connect to MySQL database\n",
    "try:\n",
    "    connection = mysql.connector.connect(\n",
    "        host=\"localhost\",\n",
    "        database=\"mysql_python\",\n",
    "        user=\"root\",\n",
    "        password=\"Ruby@2020\"\n",
    "    )\n",
    "    print(\"Connected to MySQL database\")\n",
    "\n",
    "    # Call the query function\n",
    "    find_youngest_student(connection)\n",
    "\n",
    "except Error as e:\n",
    "    print(f\"Error: {e}\")\n",
    "\n",
    "finally:\n",
    "    if connection.is_connected():\n",
    "        connection.close()\n",
    "        print(\"MySQL connection closed\")\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "65a0a74d-5e90-4d10-90b6-4b5121f781a5",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.8"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
