-- SQLite
DROP TABLE IF EXISTS students;
CREATE TABLE students (
roll_no NUMERIC(5) NOT NULL UNIQUE,
name VARCHAR(30) NOT NULL DEFAULT 'No Name defined',
mark_1 NUMERIC(3), 
mark_2 NUMERIC(3), 
mark_3 NUMERIC(3),
total NUMERIC(3)
);

INSERT INTO students (roll_no,name,mark_1,mark_2,mark_3)
VALUES (1,'saurabh',40,67,100),(2,'drishya',34,55,56)
;

INSERT INTO students 
VALUES (3,'nikhil',23,45,67,100)
;

SELECT * FROM students;

UPDATE students 
SET total = mark_1 + mark_2 + mark_3;

SELECT name,mark_1 FROM students WHERE mark_1 > 30;

SELECT name,roll_no,mark_1 + mark_2 AS sub_total FROM students;

DROP VIEW IF EXISTS students_view;
CREATE VIEW students_view AS SELECT name,roll_no,total FROM students;

SELECT * FROM students_view;

SELECT * FROM students ORDER BY total;

