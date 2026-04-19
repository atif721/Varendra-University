
/*
    CSE 314 DBMS Lab Manual (Pages 9-39)
    MSSQL single-file solution for all LAB ASSIGNMENT questions.
    Source PDF: adms lab manual spring 2025.pdf
    Covered sections:
      - Experiment 01 / 02 / 03 / 04 lab assignments
      - Pages 18, 32, 37, 38, 39

    Notes / assumptions:
      1) SQL Server (T-SQL) syntax is used throughout.
      2) Some questions in the PDF are slightly inconsistent or ambiguous.
         - "EMPLOYEE" is treated as WORKER where appropriate.
         - "age bigger than Sanjoy" appears in Worker assignment, but Worker has no AGE column.
           A commented placeholder query is included.
         - Bonus / Title tables are created because later queries depend on them.
      3) This file includes setup + answers.
*/

SET NOCOUNT ON;

------------------------------------------------------------
-- CLEANUP
------------------------------------------------------------
IF OBJECT_ID('dbo.WorkerClone', 'U') IS NOT NULL DROP TABLE dbo.WorkerClone;
IF OBJECT_ID('dbo.WorkerBackup', 'U') IS NOT NULL DROP TABLE dbo.WorkerBackup;
IF OBJECT_ID('dbo.Bonus', 'U') IS NOT NULL DROP TABLE dbo.Bonus;
IF OBJECT_ID('dbo.Title', 'U') IS NOT NULL DROP TABLE dbo.Title;
IF OBJECT_ID('dbo.Worker', 'U') IS NOT NULL DROP TABLE dbo.Worker;
IF OBJECT_ID('dbo.TeacherCopy', 'U') IS NOT NULL DROP TABLE dbo.TeacherCopy;
IF OBJECT_ID('dbo.Teacher', 'U') IS NOT NULL DROP TABLE dbo.Teacher;
IF OBJECT_ID('dbo.DepartmentInfo', 'U') IS NOT NULL DROP TABLE dbo.DepartmentInfo;

------------------------------------------------------------
-- EXPERIMENT 01 + 02 + 03 BASE TABLE SETUP (WORKER)
------------------------------------------------------------

/* Lab Assignment 1.1
   Create a table Worker with schema:
   (WORKER_ID(PK), FIRST_NAME, LAST_NAME, SALARY, DEPT_NAME)
*/
CREATE TABLE dbo.Worker
(
    WORKER_ID   INT NOT NULL,
    FIRST_NAME  VARCHAR(50) NULL,
    LAST_NAME   VARCHAR(50) NULL,
    SALARY      INT NULL,
    DEPT_NAME   VARCHAR(50) NULL
);
GO

/* Lab Assignment 1.2
   Add new column JOINING_DATE
*/
ALTER TABLE dbo.Worker
ADD JOINING_DATE DATETIME NULL;
GO

/* Lab Assignment 1.3
   Change datatype of SALARY
*/
ALTER TABLE dbo.Worker
ALTER COLUMN SALARY DECIMAL(12,2) NULL;
GO

/* Lab Assignment 1.4
   Rename DEPT_NAME to DEPARTMENT
*/
EXEC sp_rename 'dbo.Worker.DEPT_NAME', 'DEPARTMENT', 'COLUMN';
GO

/* Lab Assignment 1.5
   Modify column width of DEPARTMENT
   (PDF says EMPLOYEE table; treated as Worker table)
*/
ALTER TABLE dbo.Worker
ALTER COLUMN DEPARTMENT VARCHAR(100) NULL;
GO

/* Lab Assignment 2.1
   Allow NULL for all columns except WORKER_ID
   (already handled in table design)
*/

/* Lab Assignment 2.2
   Add CHECK constraint SALARY > 100
*/
ALTER TABLE dbo.Worker
ADD CONSTRAINT CHK_Worker_Salary CHECK (SALARY > 100);
GO

/* Lab Assignment 2.3
   Define FIRST_NAME as UNIQUE
*/
ALTER TABLE dbo.Worker
ADD CONSTRAINT UQ_Worker_FirstName UNIQUE (FIRST_NAME);
GO

/* Lab Assignment 2.4
   Create primary key constraint on WORKER_ID
*/
ALTER TABLE dbo.Worker
ADD CONSTRAINT PK_Worker PRIMARY KEY (WORKER_ID);
GO

/* Supporting tables needed for later assignments */
CREATE TABLE dbo.Bonus
(
    WORKER_REF_ID INT NOT NULL,
    BONUS_DATE    DATE NULL,
    BONUS_AMOUNT  DECIMAL(10,2) NULL
);
GO

CREATE TABLE dbo.Title
(
    WORKER_REF_ID  INT NOT NULL,
    WORKER_TITLE   VARCHAR(50) NULL,
    AFFECTED_FROM  DATE NULL
);
GO

------------------------------------------------------------
-- EXPERIMENT 03: INSERT SAMPLE DATA
------------------------------------------------------------

/* Lab Assignment 3.1
   Insert at least 10 rows in Worker table
*/
INSERT INTO dbo.Worker (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT, JOINING_DATE)
VALUES
(1,  'Rana',      'Hamid',   100000, 'HR',      '2014-02-20T09:00:00'),
(2,  'Sanjoy',    'Saha',     80000, 'Admin',   '2014-06-11T09:00:00'),
(3,  'Mahmudul',  'Hasan',   300000, 'HR',      '2014-02-20T09:00:00'),
(4,  'Asad',      'Zaman',   500000, 'Admin',   '2014-02-20T09:00:00'),
(5,  'Sajib',     'Mia',     500000, 'Admin',   '2014-06-11T09:00:00'),
(6,  'Alamgir',   'Kabir',   200000, 'Account', '2014-06-11T09:00:00'),
(7,  'Foridul',   'Islam',    75000, 'Account', '2014-01-20T09:00:00'),
(8,  'Keshob',    'Ray',      90000, 'Admin',   '2014-04-11T09:00:00'),
(9,  'Karim',     'Uddin',   120000, 'Sales',   '2014-05-15T09:00:00'),
(10, 'Nafis',     'Rahman',   95000, 'IT',      '2014-07-01T09:00:00');
GO

INSERT INTO dbo.Bonus (WORKER_REF_ID, BONUS_DATE, BONUS_AMOUNT)
VALUES
(1, '2019-02-20', 5000),
(2, '2019-06-11', 3000),
(3, '2019-02-20', 4000),
(4, '2019-02-20', 4500),
(5, '2019-06-11', 3500),
(6, '2019-06-12', NULL);
GO

INSERT INTO dbo.Title (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM)
VALUES
(1, 'Manager',       '2019-02-20'),
(2, 'Executive',     '2019-06-11'),
(8, 'Executive',     '2019-06-11'),
(5, 'Manager',       '2019-06-11'),
(4, 'Asst. Manager', '2019-06-11'),
(7, 'Executive',     '2019-06-11'),
(6, 'Lead',          '2019-06-11'),
(3, 'Lead',          '2019-06-11');
GO

------------------------------------------------------------
-- EXPERIMENT 03 - LAB ASSIGNMENT 3 (Page 18)
------------------------------------------------------------

-- 3.2 Display all information of WORKER table
SELECT * FROM dbo.Worker;

-- 3.3 Display first 5 employees with FULL_NAME
SELECT TOP 5
    WORKER_ID,
    FIRST_NAME + ' ' + LAST_NAME AS FULL_NAME,
    SALARY,
    DEPARTMENT,
    JOINING_DATE
FROM dbo.Worker
ORDER BY WORKER_ID;

-- 3.4 Complete record of employees working in Admin department
SELECT *
FROM dbo.Worker
WHERE DEPARTMENT = 'Admin';

-- 3.5 Name of employees whose salary is greater than 10000
SELECT FIRST_NAME, LAST_NAME
FROM dbo.Worker
WHERE SALARY > 10000;

-- 3.6 The PDF says: "find out which age has bigger that is more than Sanjoy"
-- Worker table has no AGE column, so this question is ambiguous.
-- Placeholder if an AGE column existed:
-- SELECT * FROM dbo.Worker WHERE AGE > (SELECT AGE FROM dbo.Worker WHERE FIRST_NAME = 'Sanjoy');

-- 3.7 Update salary of worker by 95000 whose ID is 8
UPDATE dbo.Worker
SET SALARY = 95000
WHERE WORKER_ID = 8;

-- 3.8 Delete the record whose FIRST_NAME is Asad
DELETE FROM dbo.Worker
WHERE FIRST_NAME = 'Asad';

------------------------------------------------------------
-- EXPERIMENT 03 / FUNCTIONS & OPERATORS - LAB ASSIGNMENT (Page 32)
------------------------------------------------------------

-- 1. First three characters of FIRST_NAME
SELECT FIRST_NAME, LEFT(FIRST_NAME, 3) AS FIRST_THREE_CHAR
FROM dbo.Worker;

-- 2. Workers who joined from Feb 2014 to March 2014
SELECT *
FROM dbo.Worker
WHERE JOINING_DATE >= '2014-02-01'
  AND JOINING_DATE <  '2014-04-01';

-- 3. Workers who have served for at least 6 months
SELECT *
FROM dbo.Worker
WHERE DATEDIFF(MONTH, JOINING_DATE, GETDATE()) >= 6;

-- 4. Update all worker salary whose title is manager
UPDATE W
SET W.SALARY = W.SALARY + 10000
FROM dbo.Worker AS W
INNER JOIN dbo.Title AS T
    ON W.WORKER_ID = T.WORKER_REF_ID
WHERE T.WORKER_TITLE = 'Manager';

-- 5. Update worker bonus:
--    10% if joining_date before 2014-04-11 09:00:00
--    otherwise 5%
--    only for department = 'Admin'
UPDATE B
SET BONUS_AMOUNT =
    CASE
        WHEN W.JOINING_DATE < '2014-04-11T09:00:00' THEN W.SALARY * 0.10
        ELSE W.SALARY * 0.05
    END
FROM dbo.Bonus AS B
INNER JOIN dbo.Worker AS W
    ON B.WORKER_REF_ID = W.WORKER_ID
WHERE W.DEPARTMENT = 'Admin';

-- 6. Delete all workers who have not taken any bonus
DELETE W
FROM dbo.Worker AS W
LEFT JOIN dbo.Bonus AS B
    ON W.WORKER_ID = B.WORKER_REF_ID
WHERE B.BONUS_AMOUNT IS NULL;

-- 7. Details for workers with first name Rana and Sajib
SELECT *
FROM dbo.Worker
WHERE FIRST_NAME IN ('Rana', 'Sajib');

-- 8. Details excluding first names Rana and Sajib
SELECT *
FROM dbo.Worker
WHERE FIRST_NAME NOT IN ('Rana', 'Sajib');

-- 9. Workers whose FIRST_NAME contains 'a'
SELECT *
FROM dbo.Worker
WHERE FIRST_NAME LIKE '%a%';

-- 10. Workers whose FIRST_NAME starts with 'k'
SELECT *
FROM dbo.Worker
WHERE FIRST_NAME LIKE 'k%';

-- 11. Workers whose FIRST_NAME ends with 'r' and has seven alphabets
SELECT *
FROM dbo.Worker
WHERE FIRST_NAME LIKE '%r'
  AND LEN(FIRST_NAME) = 7;

-- 12. Position of alphabet 'n' in the word 'Sanjoy'
SELECT CHARINDEX('n', 'Sanjoy') AS POSITION_OF_N;

-- 13. Average salary of employees for each department
SELECT DEPARTMENT, AVG(SALARY) AS AVG_SALARY
FROM dbo.Worker
GROUP BY DEPARTMENT;

-- 14. Employees who have maximum or minimum salary in each department
SELECT *
FROM dbo.Worker AS W
WHERE W.SALARY IN
(
    SELECT MAX(SALARY) FROM dbo.Worker GROUP BY DEPARTMENT
    UNION
    SELECT MIN(SALARY) FROM dbo.Worker GROUP BY DEPARTMENT
);

-- 15. Position of alphabet 'r' in the word 'Rana'
SELECT CHARINDEX('r', 'Rana') AS POSITION_OF_R_CASE_INSENSITIVE;
-- If case-sensitive collation is needed:
-- SELECT CHARINDEX('r', 'Rana' COLLATE Latin1_General_CS_AS) AS POSITION_OF_R_CASE_SENSITIVE;

-- 16. FIRST_NAME after removing white spaces from right side
SELECT RTRIM(FIRST_NAME) AS TRIMMED_FIRST_NAME
FROM dbo.Worker;

-- 17. Unique FIRST_NAME values with their length
SELECT DISTINCT FIRST_NAME, LEN(FIRST_NAME) AS NAME_LENGTH
FROM dbo.Worker;

-- 18. FIRST_NAME after replacing 'a' with 'A'
SELECT FIRST_NAME, REPLACE(FIRST_NAME, 'a', 'A') AS MODIFIED_FIRST_NAME
FROM dbo.Worker;

------------------------------------------------------------
-- EXPERIMENT 04 - JOIN & SUBQUERY LAB ASSIGNMENT (Pages 37-39)
------------------------------------------------------------

-- 1. List all employees except 'Manager' and 'Asst. Manager'
SELECT W.*, T.WORKER_TITLE
FROM dbo.Worker AS W
INNER JOIN dbo.Title AS T
    ON W.WORKER_ID = T.WORKER_REF_ID
WHERE T.WORKER_TITLE NOT IN ('Manager', 'Asst. Manager');

-- 2. Workers in ascending order of designations who joined after April 2014
SELECT W.*, T.WORKER_TITLE
FROM dbo.Worker AS W
INNER JOIN dbo.Title AS T
    ON W.WORKER_ID = T.WORKER_REF_ID
WHERE W.JOINING_DATE > '2014-04-30T23:59:59'
ORDER BY T.WORKER_TITLE ASC;

-- 3. Number of employees working in department Admin
SELECT COUNT(*) AS ADMIN_EMPLOYEE_COUNT
FROM dbo.Worker
WHERE DEPARTMENT = 'Admin';

-- 4. Worker names with salaries >= 50000 and <= 100000
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM dbo.Worker
WHERE SALARY BETWEEN 50000 AND 100000;

-- 5. Number of workers for each department in descending order
SELECT DEPARTMENT, COUNT(*) AS TOTAL_WORKERS
FROM dbo.Worker
GROUP BY DEPARTMENT
ORDER BY TOTAL_WORKERS DESC;

-- 6. Details of the workers who are also Managers
SELECT W.*, T.WORKER_TITLE
FROM dbo.Worker AS W
INNER JOIN dbo.Title AS T
    ON W.WORKER_ID = T.WORKER_REF_ID
WHERE T.WORKER_TITLE = 'Manager';

-- 7. Show only odd rows from a table
SELECT *
FROM
(
    SELECT W.*, ROW_NUMBER() OVER (ORDER BY WORKER_ID) AS RN
    FROM dbo.Worker AS W
) AS X
WHERE X.RN % 2 = 1;

-- 8. Show only even rows from a table
SELECT *
FROM
(
    SELECT W.*, ROW_NUMBER() OVER (ORDER BY WORKER_ID) AS RN
    FROM dbo.Worker AS W
) AS X
WHERE X.RN % 2 = 0;

-- 9. Clone a new table from another table
SELECT *
INTO dbo.WorkerClone
FROM dbo.Worker;

-- 10. Show current date and time
SELECT GETDATE() AS CURRENT_DATE_TIME;

-- 11. Show top 10 records of a table with Name and Designation
SELECT TOP 10
    W.FIRST_NAME + ' ' + W.LAST_NAME AS FULL_NAME,
    T.WORKER_TITLE
FROM dbo.Worker AS W
LEFT JOIN dbo.Title AS T
    ON W.WORKER_ID = T.WORKER_REF_ID
ORDER BY W.WORKER_ID;

-- 12. Determine the 5th highest salary
SELECT DISTINCT TOP 1 SALARY AS FIFTH_HIGHEST_SALARY
FROM
(
    SELECT DISTINCT TOP 5 SALARY
    FROM dbo.Worker
    ORDER BY SALARY DESC
) AS X
ORDER BY SALARY ASC;

-- 13. Employees with the same salary
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM dbo.Worker
WHERE SALARY IN
(
    SELECT SALARY
    FROM dbo.Worker
    GROUP BY SALARY
    HAVING COUNT(*) > 1
)
ORDER BY SALARY;

-- 14. Second highest salary
SELECT MAX(SALARY) AS SECOND_HIGHEST_SALARY
FROM dbo.Worker
WHERE SALARY < (SELECT MAX(SALARY) FROM dbo.Worker);

-- 15. First 50% records from a table
SELECT TOP 50 PERCENT *
FROM dbo.Worker
ORDER BY WORKER_ID;

-- 16. Departments that have less than five people
SELECT DEPARTMENT
FROM dbo.Worker
GROUP BY DEPARTMENT
HAVING COUNT(*) < 5;

-- 17. All departments along with number of people
SELECT DEPARTMENT, COUNT(*) AS TOTAL_PEOPLE
FROM dbo.Worker
GROUP BY DEPARTMENT;

-- 18. Last record from table
SELECT TOP 1 *
FROM dbo.Worker
ORDER BY WORKER_ID DESC;

-- 19. First row of table
SELECT TOP 1 *
FROM dbo.Worker
ORDER BY WORKER_ID ASC;

-- 20. Last five records from table
SELECT TOP 5 *
FROM dbo.Worker
ORDER BY WORKER_ID DESC;

-- 21. Name of employees having highest salary in each department
SELECT W.DEPARTMENT, W.FIRST_NAME, W.LAST_NAME, W.SALARY
FROM dbo.Worker AS W
INNER JOIN
(
    SELECT DEPARTMENT, MAX(SALARY) AS MAX_SALARY
    FROM dbo.Worker
    GROUP BY DEPARTMENT
) AS M
    ON W.DEPARTMENT = M.DEPARTMENT
   AND W.SALARY = M.MAX_SALARY;

-- 22. Three max salaries from table
SELECT DISTINCT TOP 3 SALARY
FROM dbo.Worker
ORDER BY SALARY DESC;

------------------------------------------------------------
-- SUBQUERY ASSIGNMENT SETUP (Pages 38-39)
------------------------------------------------------------

CREATE TABLE dbo.Teacher
(
    TID        INT PRIMARY KEY,
    FirstName  VARCHAR(50),
    LastName   VARCHAR(50),
    Dept       VARCHAR(50),
    Age        INT,
    Salary     DECIMAL(12,2)
);
GO

CREATE TABLE dbo.DepartmentInfo
(
    deptID    INT PRIMARY KEY,
    deptName  VARCHAR(50),
    location  VARCHAR(50)
);
GO

INSERT INTO dbo.Teacher (TID, FirstName, LastName, Dept, Age, Salary)
VALUES
(1, 'Mizanur', 'Rahman',  'CSE',     28, 35000),
(2, 'Delwar',  'Hossain', 'CSE',     26, 33000),
(3, 'Shafiul', 'Islam',   'EEE',     24, 30000),
(4, 'Faisal',  'Imran',   'CSE',     30, 50000),
(5, 'Ahsan',   'Habib',   'English', 28, 28000),
(6, 'Karim',   'Ali',     'BBA',     29, 27000),
(7, 'Sajib',   'Khan',    'English', 25, 31000),
(8, 'Kamal',   'Roy',     'CSE',     27, 42000);
GO

INSERT INTO dbo.DepartmentInfo (deptID, deptName, location)
VALUES
(1, 'CSE',     'Talaimari'),
(2, 'EEE',     'Talaimari'),
(3, 'English', 'Kazla'),
(4, 'BBA',     'Talaimari');
GO

------------------------------------------------------------
-- SUBQUERY LAB ASSIGNMENT 01 (Pages 38-39)
------------------------------------------------------------

-- 1. Update salary by 15% whose DeptName is CSE, otherwise 10%
UPDATE dbo.Teacher
SET Salary =
    CASE
        WHEN Dept = 'CSE' THEN Salary * 1.15
        ELSE Salary * 1.10
    END;

-- 2. Insert/copy all attributes from one table to another using ID IN subquery
CREATE TABLE dbo.TeacherCopy
(
    TID        INT,
    FirstName  VARCHAR(50),
    LastName   VARCHAR(50),
    Dept       VARCHAR(50),
    Age        INT,
    Salary     DECIMAL(12,2)
);
GO

INSERT INTO dbo.TeacherCopy (TID, FirstName, LastName, Dept, Age, Salary)
SELECT TID, FirstName, LastName, Dept, Age, Salary
FROM dbo.Teacher
WHERE TID IN (SELECT TID FROM dbo.Teacher);
GO

-- 3. Find fullname and age whose salary is maximum
SELECT
    FirstName + ' ' + LastName AS FullName,
    Age
FROM dbo.Teacher
WHERE Salary = (SELECT MAX(Salary) FROM dbo.Teacher);

-- 4. Find firstname, age, dept whose age is between 23 to 27
SELECT FirstName, Age, Dept
FROM dbo.Teacher
WHERE Age BETWEEN 23 AND 27;

-- 5. Find TID, firstname whose salary is less than average salary
SELECT TID, FirstName
FROM dbo.Teacher
WHERE Salary < (SELECT AVG(Salary) FROM dbo.Teacher);

-- 6. Update Dept by 'English' where Dept is 'EEE' using subquery
UPDATE dbo.Teacher
SET Dept = (SELECT deptName FROM dbo.DepartmentInfo WHERE deptName = 'English')
WHERE Dept = (SELECT deptName FROM dbo.DepartmentInfo WHERE deptName = 'EEE');

-- 7. Update salary by multiplying by 100 where salary is greater than 5000 using subquery
UPDATE dbo.Teacher
SET Salary = Salary * 100
WHERE TID IN
(
    SELECT TID
    FROM dbo.Teacher
    WHERE Salary > 5000
);

-- 8. Find the name that starts with 'k/s' using subquery
SELECT FirstName
FROM dbo.Teacher
WHERE TID IN
(
    SELECT TID
    FROM dbo.Teacher
    WHERE FirstName LIKE 'K%' OR FirstName LIKE 'S%'
);

-- 9. Firstname, salary for all CSE teachers having higher salary than Delwar Hossain
SELECT FirstName, Salary
FROM dbo.Teacher
WHERE Dept = 'CSE'
  AND Salary >
    (
        SELECT Salary
        FROM dbo.Teacher
        WHERE FirstName = 'Delwar' AND LastName = 'Hossain'
    );

-- 10. ID and names of all teachers who belong to same department as Mizanur
SELECT TID, FirstName, LastName
FROM dbo.Teacher
WHERE Dept =
(
    SELECT Dept
    FROM dbo.Teacher
    WHERE FirstName = 'Mizanur'
);

-- 11. Find TID, salary, deptID whose salary is greater than average salary
SELECT
    T.TID,
    T.Salary,
    D.deptID
FROM dbo.Teacher AS T
INNER JOIN dbo.DepartmentInfo AS D
    ON T.Dept = D.deptName
WHERE T.Salary > (SELECT AVG(Salary) FROM dbo.Teacher);

-- 12. Min salary from Teacher for each department where min salary is less than average salary
SELECT Dept, MIN(Salary) AS MIN_SALARY
FROM dbo.Teacher
GROUP BY Dept
HAVING MIN(Salary) < (SELECT AVG(Salary) FROM dbo.Teacher);

-- 13. Find firstname, lastname, dept where location name is Kazla
SELECT FirstName, LastName, Dept
FROM dbo.Teacher
WHERE Dept IN
(
    SELECT deptName
    FROM dbo.DepartmentInfo
    WHERE location = 'Kazla'
);

-- 14. Find TID, firstname, salary where length of firstname is at least 6
SELECT TID, FirstName, Salary
FROM dbo.Teacher
WHERE LEN(FirstName) >= 6;

------------------------------------------------------------
-- OPTIONAL CHECK SELECTS
------------------------------------------------------------
SELECT 'Worker Data' AS SectionName;
SELECT * FROM dbo.Worker;

SELECT 'Bonus Data' AS SectionName;
SELECT * FROM dbo.Bonus;

SELECT 'Title Data' AS SectionName;
SELECT * FROM dbo.Title;

SELECT 'Teacher Data' AS SectionName;
SELECT * FROM dbo.Teacher;

SELECT 'DepartmentInfo Data' AS SectionName;
SELECT * FROM dbo.DepartmentInfo;
