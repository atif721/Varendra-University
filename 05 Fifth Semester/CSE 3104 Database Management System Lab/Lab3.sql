Create Database Lab3;

use Lab3;

Create Table
  Worker (
    Worker_ID int Primary Key Not Null,
    First_Name Varchar(30) unique,
    Last_Name Varchar(30),
    Salary int,
    Dept_Name varchar(10),
    Joining_Date Datetime,
    Check (Salary > 100)
  );

drop table Worker;

insert into
  Worker (
    Worker_ID,
    First_Name,
    Last_Name,
    Salary,
    Dept_Name,
    Joining_Date
  )
Values
  (
    1,
    'Rana',
    'Hamid',
    100000,
    'HR',
    '2014-02-20 09:00:00'
  ),
  (
    2,
    'Sanjoy',
    'Saha',
    80000,
    'Admin',
    '2014-06-11 09:00:00'
  ),
  (
    3,
    'Mahmudul',
    'Hasan',
    300000,
    'HR',
    '2014-02-20 09:00:00'
  ),
  (
    4,
    'Asad',
    'Zaman',
    500000,
    'Admin',
    '2014-02-20 09:00:00'
  ),
  (
    5,
    'Sajib',
    'Mia',
    500000,
    'Admin',
    '2014-06-11 09:00:00'
  ),
  (
    6,
    'Alamgir',
    'Kabir',
    200000,
    'Account',
    '2014-06-11 09:00:00'
  ),
  (
    7,
    'Foridul',
    'Islam',
    75000,
    'Account',
    '2014-01-20 09:00:00'
  ),
  (
    8,
    'Kesob',
    'Ray',
    90000,
    'Admin',
    '2014-04-11 09:00:00'
  );

insert into
  Worker (
    Worker_ID,
    First_Name,
    Last_Name,
    Salary,
    Dept_Name,
    Joining_Date
  )
Values
  (
    1,
    'Rana',
    'Hamid',
    100000,
    'HR',
    '2014-02-20 09:00:00'
  ),
  (
    3,
    'Mahmudul',
    'Hasan',
    300000,
    'HR',
    '2014-02-20 09:00:00'
  ),
  (
    4,
    'Asad',
    'Zaman',
    500000,
    'Admin',
    '2014-02-20 09:00:00'
  );

select
  *
from
  Worker;

--DML 
--Delete 
Delete from Worker
where
  Joining_Date = '2014-02-20 09:00:00';

--update 
--single value 
Update Worker
SET
  Dept_Name = 'Admin',
  Salary = 250000
where
  Worker_ID = 6;

--multiple value
update Worker
SET
  Salary = 500000
where
  Joining_Date = '2014-02-20 09:00:00';

-- Query 
-- thoose who have cgpa above or equal 3.25 find out their details. 
-- Attribute: Student_ID, Std_Name, Dept, Mobile, CGPA 
-- Select * from Student where CGPA >= 3.25; 
Select
  First_Name,
  Worker_ID
from
  Worker
where
  Last_Name = 'Hasan';

Select
  TOP 5 *
from
  Worker
Order by
  worker_ID ASC;

Select
  Name = concat (First_Name, ' ', Last_name)
from
  Worker;

-- First_Name + ' ' + Last_Name