drop table if exists entrance_exam_results;
create table entrance_exam_results
(
    roll_no NUMBER(5) PRIMARY KEY,
    city  VARCHAR(10) ,
    score  NUMBER(3) NOT NULL
);

insert into entrance_exam_results  VALUES
(1, 'BENGALURU', 90),
(2, 'DELHI', 67),
(3, 'DELHI', 87),
(4, 'BENGALURU', 76),
(5, 'PUNE', 89),
(6, NULL, 91 ),
(7, 'CHENNAI', 77),
(8, 'HYDERABAD', 80)
;

drop table if exists city_bonus_points;

create table city_bonus_points
(
    city VARCHAR(10),
    bonus_score  NUMBER(2)  

);

insert into city_bonus_points VALUES
( 'BENGALURU', 10 ),
( 'DELHI', 9),
( 'PUNE', 11),
( 'CHENNAI', 10 ),
( 'COIMBATORE', 12 ),
( 'NAGPUR', 13 ),
( 'Nagpur', 13 )
; 

select * from entrance_exam_results;
select * from city_bonus_points;

select count(*) 
from entrance_exam_results;
select count(*)
from city_bonus_points;

-- cartesian product aka  CROSS JOIN

select * from entrance_exam_results,city_bonus_points;

select tab1.roll_no,tab1.city,tab1.score,tab2.city as tab2_city, tab2.bonus_score from entrance_exam_results as tab1 CROSS JOIN city_bonus_points as tab2;


select tab1.roll_no,tab1.city,tab1.score,tab2.city as tab2_city, tab2.bonus_score, tab1.score + tab2.bonus_score as total_score from entrance_exam_results as tab1 
cross join city_bonus_points as  tab2  on tab1.city = tab2.city;


