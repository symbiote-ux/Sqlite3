-- Recreate the table
DROP TABLE IF EXISTS student_exercise_1; 
CREATE TABLE  student_exercise_1 (

roll_no  NUMERIC(5)  NOT NULL UNIQUE,
name     VARCHAR(30) NOT NULL DEFAULT 'No Name Defined',
mark_1   NUMERIC(3),
mark_2   NUMERIC(3),
mark_3   NUMERIC(3)
);

-- populate values
INSERT INTO student_exercise_1 VALUES
( 1,    'AB', 49,   67,     90),
( 2,    'AB', 95,   70,     100),
( 3,    'BB', 55,   100,    91),
( 4,    'CA', 100,  100,    100),
( 5,    'DD', 100,  89,     83),
( 6,    'AD', 87,   67,     97),
( 7,    'AE', 35,   87,     86),
( 8,    'AF', 67,   74,     93),
( 9,    'AG', 58,   71,     59),
( 10,   'AH', 49,   71,     76),
( 11,   'AI', 100,   86,    91),
( 12,   'AJ', 66,   57,     100),
( 13,   'AK', 87,   63,     80),
( 14,   'B2', 74,   69,     84),
( 15,   'B4', 40,  100,     87),
( 16,   'B6', 93,   85,     73),
( 17,   'C8', 100,  91,     35),
( 18,   'A6', 38,   59,     90),
( 19,   'AB', 57,   74,     90),
( 20,   'A*', 71,   81,     90),
( 21,   'YY', 0,     0,     NULL)
;

SELECT * from student_exercise_1;

--aggregate function
SELECT count(mark_3) from student_exercise_1;


SELECT roll_no,name,(mark_1 + mark_2 + mark_3) total from student_exercise_1;

SELECT roll_no,name,(mark_1 + mark_2 + mark_3) total, 
ROUND((mark_1 + mark_2 + mark_3) / 300.2 *100,2) as percentage 
from student_exercise_1;

SELECT sum(mark_1) from student_exercise_1;

--literals as column value
SELECT name,'dehradun' as city from student_exercise_1;

SELECT roll_no,name,(mark_1 + mark_2 + mark_3) as total from student_exercise_1
WHERE mark_1 >= 70
and mark_2 >= 50
and mark_3 >= 50; 

SELECT name,mark_3,IFNULL(mark_3,0) from student_exercise_1;

SELECT count(mark_3) as countOfMark_3, count(IFNULL(mark_3,0)) as new_count from student_exercise_1;

-- case Statement
SELECT name,mark_1,
CASE WHEN mark_1 >= 80 THEN 'INTELLIGENT'
     WHEN mark_1 >= 60 THEN 'AVERAGE'
     ELSE 'Very luck next time'
     END as Grades
     from student_exercise_1;

SELECT count(*) as passed from student_exercise_1 
WHERE mark_1 >= 40 or mark_2 >=40;

select name,roll_no,mark_1,
200 as max_mark, ROUND((mark_1/200.0)*100,2) as percentage,
case when mark_1 >= 40 then mark_1
else 0
END as Grades
from student_exercise_1;

 -- progress report
  -- roll_no, name, mark_1, mark_2, mark_3, total, total_percentage, result
-- Maximum score per subject = 100
-- Convert NULLs to 0
-- Round percentages to 2 decimal places

select roll_no,name,mark_1,mark_2,mark_3,
(mark_1+ mark_2 + mark_3) as total, 100 as max_marks,
ROUND(((IFNULL(mark_1,0) + IFNULL(mark_2,0) + IFNULL(mark_3,0)) /300.0)*100,2) as total_percentage
from student_exercise_1;

 -- Common table expression / CTE

 with students_score as (
   select name,roll_no,
   IFNULL(mark_1,0) as English,
   IFNULL(mark_2,0) as PHYSICS,
   IFNULL(mark_3,0) as Maths,
   mark_3 as math_with_null
   from student_exercise_1
 ) 

-- aggregated  AVG
select avg(mark_3) as average,COUNT(mark_3) from student_exercise_1; 

select avg(IFNULL(mark_3,0)) as average,COUNT(IFNULL(mark_3,0)) from student_exercise_1;

-- usage of table alias

select st.roll_no,st.name,st.mark_1 from student_exercise_1 st;












