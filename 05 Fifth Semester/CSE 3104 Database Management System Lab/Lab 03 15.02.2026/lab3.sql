-- CREATE DATABASE Atif

USE Atif
GO

-- CREATE TABLE WORKER (
--     WORKER_ID INT PRIMARY KEY,
--     FIRST_NAME VARCHAR(50) UNIQUE,
--     LAST_NAME VARCHAR(50),
--     SALARY INT CHECK (SALARY > 100),
--     DEPT_NAME VARCHAR(50),
--     JOINING_DATE DATETIME
-- );


-- INSERT INTO WORKER VALUES
-- (1, 'Rana', 'Hamid', 100000, 'HR', '2014-02-20 09:00:00'),
-- (2, 'Sanjoy', 'Saha', 80000, 'Admin', '2014-06-11 09:00:00'),
-- (3, 'Mahmudul', 'Hasan', 300000, 'HR', '2014-02-20 09:00:00'),
-- (4, 'Asad', 'Zaman', 500000, 'Admin', '2014-02-20 09:00:00'),
-- (5, 'Sajib', 'Mia', 500000, 'Admin', '2014-06-11 09:00:00'),
-- (6, 'Alamgir', 'Kabir', 200000, 'Account', '2014-06-11 09:00:00'),
-- (7, 'Foridul', 'Islam', 75000, 'Account', '2014-01-20 09:00:00'),
-- (8, 'Keshob', 'Ray', 90000, 'Admin', '2014-04-11 09:00:00');

-- -- -- ==============================
-- -- QUERIES
-- -- ==============================

-- 1. Display all information of WORKER table

-- SELECT * FROM WORKER;

-- -- 2. Display first 5 employees with FULL_NAME
-- SELECT 
--     WORKER_ID,
--     CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME,
--     SALARY,
--     DEPT_NAME,
--     JOINING_DATE
-- FROM WORKER LIMIT 5;

-- -- 3. FIRST_NAME + LAST_NAME as FULL_NAME
-- SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME
-- FROM WORKER;

-- -- 4. Employees working in Admin department
-- SELECT *
-- FROM WORKER
-- WHERE DEPT_NAME = 'Admin';

-- -- 5. Employees whose salary is greater than 10000
-- SELECT FIRST_NAME, LAST_NAME
-- FROM WORKER
-- WHERE SALARY > 10000;

-- -- 6. Employees whose salary is more than Sanjoy
-- SELECT *
-- FROM WORKER
-- WHERE SALARY > (
--     SELECT SALARY
--     FROM WORKER
--     WHERE FIRST_NAME = 'Sanjoy'
-- );

-- -- 7. Update salary of worker whose ID is 8 to 95000
-- UPDATE WORKER
-- SET SALARY = 95000
-- WHERE WORKER_ID = 8;

-- -- 8. Delete employee whose FIRST_NAME is Asad
-- DELETE FROM WORKER
-- WHERE FIRST_NAME = 'Asad';

SELECT
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FULL_NAME,
    UPPER(CONCAT(FIRST_NAME, ' ', LAST_NAME)) AS FULL_NAME_UPPER,
    LOWER(CONCAT(FIRST_NAME, ' ', LAST_NAME)) AS FULL_NAME_LOWER,
    LEN(FIRST_NAME) AS FIRST_NAME_LENGTH,
    ASCII(FIRST_NAME) AS FIRST_CHAR_ASCII,
    CHARINDEX('a', FIRST_NAME) AS POSITION_OF_A,
    LTRIM(FIRST_NAME) AS LTRIMMED_FIRST_NAME,
    RTRIM(FIRST_NAME) AS RTRIMMED_FIRST_NAME,
    REVERSE(FIRST_NAME) AS FIRST_NAME_REVERSED,
    SUBSTRING(FIRST_NAME, 1, 3) AS FIRST_3_LETTERS,
    REPLICATE(FIRST_NAME, 2) AS FIRST_NAME_REPEATED,
    REPLACE(FIRST_NAME, 'a', '@') AS FIRST_NAME_REPLACED
FROM WORKER;

SELECT 
    Department,
    COUNT(*) AS TotalEmployees,           -- Count of employees per department
    SUM(Salary) AS TotalSalary,           -- Total salary per department
    AVG(Salary) AS AvgSalary,             -- Average salary per department
    MAX(Salary) AS MaxSalary,             -- Highest salary per department
    MIN(Salary) AS MinSalary              -- Lowest salary per department
FROM Employees
GROUP BY Department
HAVING SUM(Salary) > 150000              -- Only departments with total salary > 150k
ORDER BY TotalSalary DESC;

-- Add a new column for department
ALTER TABLE WORKER
ADD DEPT_NAME VARCHAR(50);

UPDATE WORKER
SET DEPT_NAME = 'HR' WHERE WORKER_ID IN (1, 3);
UPDATE WORKER
SET DEPT_NAME = 'Admin' WHERE WORKER_ID IN (2, 4, 5, 8);
UPDATE WORKER
SET DEPT_NAME = 'Account' WHERE WORKER_ID IN (6, 7);

SELECT 
    DEPT_NAME,
    COUNT(*) AS TotalEmployees,
    SUM(SALARY) AS TotalSalary,
    AVG(SALARY) AS AvgSalary,
    MAX(SALARY) AS MaxSalary,
    MIN(SALARY) AS MinSalary
FROM WORKER
GROUP BY DEPT_NAME
HAVING SUM(SALARY) > 150000      -- Only departments with total salary > 150k
ORDER BY TotalSalary DESC;
