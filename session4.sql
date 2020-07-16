/* WORKBOOK
 * Classroom 4
*/

DROP TABLE IF EXISTS student_exercise_2; 
CREATE TABLE  student_exercise_2 (

roll_no  NUMERIC(5)  NOT NULL UNIQUE,
dept     VARCHAR(5),
name     VARCHAR(30) NOT NULL DEFAULT 'No Name Defined',
mark_1   NUMERIC(3),
mark_2   NUMERIC(3),
mark_3   NUMERIC(3)
);

-- populate values
INSERT INTO student_exercise_2 VALUES
( 1, 'CSE',   'AB', 49,   67,     90),
( 2, 'CSE',   'AB', 95,   70,     100),
( 3, 'CSE',   'BB', 55,   100,    91),
( 4, 'CSE',   'CA', 100,  100,    100),
( 5, 'CSE',   'DD', 100,  89,     83),
( 6, 'EEE',   'AD', 87,   67,     97),
( 7, 'EEE',   'AE', 35,   87,     86),
( 8, 'EEE',   'AF', 67,   74,     93),
( 9, 'EEE',   'AG', 58,   71,     59),
( 10,'EEE',   'AH', 49,   71,     76),
( 11, 'IT',  'AI', 100,   86,    91),
( 12, 'IT',  'AJ', 66,   57,     100),
( 13, 'IT',  'AK', 87,   63,     80),
( 14, 'IT',  'B2', 74,   69,     84),
( 15, 'MECH',  'B4', 40,  100,     87),
( 16, 'MECH',  'B6', 93,   85,     73),
( 17, 'MECH',  'C8', 100,  91,     35),
( 18, 'MECH',  'A6', 38,   59,     90),
( 19, 'CSE',  'AB', 57,   74,     90),
( 20, 'CSE',  'A*', 71,   81,     90),
( 21, 'CSE',  'YY', 0,     0,     NULL)
;

select * from student_exercise_2;


-- Aggregate functions
select count(*) from student_exercise_2;

select min(mark_1) as min_marks, max(mark_2) as max_marks 
from student_exercise_2;

-- AVG without GROUP BY
select avg(mark_1) from student_exercise_2;
select DISTINCT dept from student_exercise_2;

-- GROUP BY
select dept, avg(mark_1) as mark_1_avg from 
student_exercise_2 GROUP BY dept;

 -- assuming pass score = 40 
 --show avg of every subject - where someone has scored a pass mark. Also show the number of students passed.

 select avg(IFNULL(mark_1,0)) as mark_1_avg,
 avg(IFNULL(mark_2,0)) as mark_2_avg,
 avg(IFNULL(mark_3,0)) as mark_3_avg,count(*) as total_passed
 from student_exercise_2
 where mark_1 >= 40 
 and mark_2 >= 40
 and mark_3 >= 40
 group by dept;

-- find name of students who scored more than the overall average for mark_1 
select name from student_exercise_2
where mark_1 > 
(
  select avg(mark_1) from student_exercise_2
);

-- same problem solved using CTE
with students as (
  select name,roll_no,mark_1,mark_2,mark_3,(mark_1 + mark_2 + mark_3) as total, dept as department
  from student_exercise_2
),
overall_averages as (
  select avg(mark_1) as mark_1_avg,
  avg(mark_2) as mark_2_avg,
  avg(mark_3) as mark_3_avg,
  avg(total) as avg_total
  from students
)
select name from students 
where total >= (select avg_total from overall_averages);

/*
 find name, department, rollno,
-- who scored more than the department average for mark_1 
*/

with students_by_dept as 
(
  SELECT
  name,
  dept,
  roll_no,
  mark_1,
  avg(mark_1) OVER (partition by dept) as avg_marks 
  FROM student_exercise_2
)

select name, roll_no,dept,mark_1,avg_marks
FROM students_by_dept WHERE mark_1 >= avg_marks;


-- Window functions  (analytical functions)

select 
roll_no,
dept,
mark_1,
avg(mark_1) over() mark_1_avg,
avg(mark_1) over(partition by dept) mark_1_avg_dept,
RANK() over(order by mark_1 DESC) rank_overall,
DENSE_RANK() over(order by mark_1 desc) rank_overall_2
from student_exercise_2
order by rank_overall;

-- equivalent aggregate functions

select avg(mark_1) from student_exercise_2;
select dept, avg(mark_1) from student_exercise_2 group by dept;


/*
 - find name, department, rollno, who scored more than the department average for mark_1 
 - Provide details of all students and their rank in their departments
*/

select name
, roll_no
, (mark_1 + mark_2 + mark_3) as total
, dept
, dense_rank() over (partition by dept order by (mark_1 + mark_2 + mark_3) desc)  as rank 
from student_exercise_2;


--provide pass and fail count of whole class

select case when (mark_1 >= 40 and mark_2 >= 40 and mark_3 >= 40) then 'Pass'
else 'Fail'
END
as result,
count(*) as total_count
from student_exercise_2
GROUP by result;

--provide pass count per department
 select dept,count(*) as total_passed
 from student_exercise_2
 where mark_1 >= 40 
 and mark_2 >= 40
 and mark_3 >= 40
 group by dept;

 -- Provide pass and fail count for each department
 select dept,
 sum(case when (mark_1 >= 40  and mark_2 >= 40 and mark_3 >= 40) then 1
 else 0
 end) as Passed,
 sum(case when (mark_1 >= 40  and mark_2 >= 40 and mark_3 >= 40) then 0
 else 1
 end) as Fail
 from student_exercise_2
 GROUP by dept;


--provide the count of students who scored above avg per department.
with score_by_dept as (
  select name,dept,(mark_1 + mark_2 + mark_3) as total,
  avg(mark_1 + mark_2 + mark_3) over(partition by dept) dept_avg
  from student_exercise_2
)
select dept,
sum(case when total > dept_avg then 1
else 0
end) as Above
from score_by_dept
GROUP by dept;

--null as zero
with score_by_dept as (
  select name,dept,(IFNULL(mark_1,0) + IFNULL(mark_2,0) + IFNULL(mark_3,0)) as total,
  avg(IFNULL(mark_1,0) + IFNULL(mark_2,0) + IFNULL(mark_3,0)) over(partition by dept) dept_avg
  from student_exercise_2
)
select dept,
sum(case when total > dept_avg then 1
else 0
end) as Above
from score_by_dept
GROUP by dept;

--provide the name, department of students who have scored highest and lowest per department, and the difference between their total and department_avg_total (deviation from the department_avg_total)

