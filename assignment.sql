SHOW DATABASES;

DROP DATABASE IF EXISTS edu_institute;
GO

CREATE DATABASE edu_institute;
GO

USE edu_institute;

CREATE TABLE students
(
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender CHAR(1),
    enrollment_date DATE,
    program VARCHAR(50)
);
