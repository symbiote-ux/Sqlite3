drop table if exists exam_enrollments;
create table exam_enrollments
(
    roll_no NUMBER(5) PRIMARY KEY,
    exam_center  VARCHAR(10) ,
    score  NUMBER(3) NOT NULL,
    address VARCHAR(200)
);

insert into exam_enrollments  VALUES
(1, 'BENGALURU', 90, '73/4, Swamiji villa, Near Delhi sarees store, Koramagala 1st block, Bengaluru - 560035' ),
(2, 'DELHI', 67, 'Apartment 4G, Tower apt Complex, New Delhi'),
(3, 'DELHI', 87, 'Karnataka Bhavan, Govt of India complex, New Delhi'),
(4, 'BENGALURU', 76, ' Jayanth code & music school, Near Chennai silks, Bengaluru, Karnataka'),
(5, 'PUNE', 89, '#34, ABC Street, Pune Highway, Satara, Maharashtra - 415001'),
(6, NULL, 91, ' some address at Chennai on Bengaluru highway'),
(7, 'CHENNAI', 77, ''),
(8, 'HYDERABAD', 80, 'House 4, Near Bank of Maharashtra, Secunderabad, Telangana')
;

select *
  from exam_enrollments;

SELECT * 
from exam_enrollments
where score > 70;

SELECT * 
from exam_enrollments
where address like '%New Delhi%';


drop table if exists exam_enrollments;
create table exam_enrollments
(
    roll_no NUMBER(5) PRIMARY KEY,
    exam_center  VARCHAR(10) ,
    score  NUMBER(3) NOT NULL,
    address VARCHAR(200),
    address_line1 VARCHAR(100),
    address_line2 VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(30),
    country VARCHAR(20),
    pincode NUMERIC(6)
);

insert into exam_enrollments  VALUES
(1, 'BENGALURU', 90, '73/4, Swamiji villa, Near Delhi sarees store, Koramagala 1st block, Bengaluru - 560035' ),
(2, 'DELHI', 67, 'Apartment 4G, Tower apt Complex, New Delhi'),
(3, 'DELHI', 87, 'Karnataka Bhavan, Govt of India complex, New Delhi'),
(4, 'BENGALURU', 76, ' Jayanth code & music school, Near Chennai silks, Bengaluru, Karnataka'),
(5, 'PUNE', 89, '#34, ABC Street, Pune Highway, Satara, Maharashtra - 415001'),
(6, NULL, 91, ' some address at Chennai on Bengaluru highway'),
(7, 'CHENNAI', 77, ''),
(8, 'HYDERABAD', 80, 'House 4, Near Bank of Maharashtra, Secunderabad, Telangana')
;

select *
  from exam_enrollments;

select *
  from exam_enrollments 
 where address like '%Maharashtra%';

-- Ideas
-- additional columm for city
-- address to be split 

--- Update, Insert, delete 

-- Design 
-- Atomic values in each column, homogenous   - 1st Normal form (Normalisation)


-- Inventory of books in Step library 

/*
ISBN for a Book title written by authors (from the publisher), serial number (library issues serial)

/*
-- User
List the Title along with category, author name
Reserve a book (subject to availability)
Borrow the book
Return the book


-- Librarian
List the titles along with category, author name and number of copies
Enroll new titles in the library
Books that are in demand
Books that are not returned on time 
* Removing the titles from library
Some one reports of a lost copy of the book 

*/
*/
--
-- 2nd normal form 
Database for step_library 

create table book_titles
(
    ISBN  varchar(50) primary key,
    title varchar(50),
    author_1 varchar(50),
    author_2 varchar(50),
    author_3 varchar(50),
    number_of_copies_total  numeric(4),
    publisher_name varchar(50)
    book_category varchar(30)
)
;
/*
1001, 'Data structures', 'A', 'B', NULL, 2, 'XYZ Publishers', 'CS'

*/

create table book_copies 
(
serial_number  numeric(10),
ISBN           varchar(50),
is_available   boolean,
enrolled_date   date,
available_from  date 
issued_date
library_user_id

);
-- 15 days
LIB00001, 1001, false, 
LIB00002, 1001, True, xx-xxx-xxxx, xx-xxx-xxxx, 'Jun 1, 2020', userid


/*  
Borrow - Date, Who
Return - Date, Who

-- Out of scope : Reservation, renewal

*/

create table library_log (
action varchar(10)   -- 'ISSUE', 'RETURN'
date_of_action date,
library_user_id
serial_number

);

'ISSUE', 'June 1, 2020', userid, LIB00002








-- TRANSACTION

BEGIN TRANSACTION
step 1 - inserting a row in library log
step 2 - modify the row in book_copies
END TRANSACTION

-- X: 0 

BEGIN TRANSACTION
Step 1: +1  = 1  
Step 2: +3  = 4
END TRANSACTION   -- COMMIT, ROLLBACK

-- ACID properties of a TRANSACTION
Atomicity
Consistency
Isolation
Durable


select * 
  from book_copies
 where current_date > availabile_date
   and is_available = True 




-- create table library_users (
-- user_id
-- user_name
-- )













