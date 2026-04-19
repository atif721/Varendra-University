-- =============================================
-- COMPREHENSIVE SQL PRACTICE FILE
-- All Functions & Operations Combined
-- =============================================

-- =============================================
-- STEP 1: CREATE DATABASE
-- =============================================
CREATE DATABASE ComprehensivePractice;
GO

USE ComprehensivePractice;
GO

-- =============================================
-- STEP 2: CREATE TABLE - Employee
-- =============================================
CREATE TABLE Employee
(
    EmployeeId INT PRIMARY KEY,
    FirstName VARCHAR(50) UNIQUE,
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Salary INT CHECK (Salary > 0),
    Department VARCHAR(50),
    JoinDate DATETIME,
    ProbationEnd DATETIME,
    Status VARCHAR(20) DEFAULT 'Active'
);
GO

-- =============================================
-- STEP 3: INSERT DATA
-- =============================================
INSERT INTO Employee
    (EmployeeId, FirstName, LastName, Email, Salary, Department, JoinDate, Status)
VALUES
    (1, 'Rahim', 'Ahmed', 'rahim.ahmed@email.com', 85000, 'Engineering', '2023-01-15 09:00:00', 'Active'),
    (2, 'Fatema', 'Begum', 'fatema.begum@email.com', 95000, 'Engineering', '2022-06-20 09:00:00', 'Active'),
    (3, 'Karim', 'Hossain', 'karim.hossain@email.com', 75000, 'Marketing', '2023-03-10 09:00:00', 'Active'),
    (4, 'Nusrat', 'Jahan', 'nusrat.jahan@email.com', 120000, 'Engineering', '2021-11-05 09:00:00', 'Active'),
    (5, 'Sorif', 'Mia', 'sorif.mia@email.com', 55000, 'HR', '2024-01-08 09:00:00', 'Active'),
    (6, 'Tonima', 'Islam', 'tonima.islam@email.com', 80000, 'Marketing', '2022-08-15 09:00:00', 'Active'),
    (7, 'Rashid', 'Khan', 'rashid.khan@email.com', 65000, 'HR', '2023-07-22 09:00:00', 'Active'),
    (8, 'Sabina', 'Akter', 'sabina.akter@email.com', 70000, 'Finance', '2022-02-28 09:00:00', 'Active'),
    (9, 'Jamal', 'Uddin', 'jamal.uddin@email.com', 90000, 'Finance', '2021-09-12 09:00:00', 'Active'),
    (10, 'Mina', 'Sultana', 'mina.sultana@email.com', 45000, 'Marketing', '2024-06-01 09:00:00', 'Active');
GO

-- =============================================
-- STEP 4: ADD PROBATION END COLUMN & UPDATE
-- =============================================
ALTER TABLE Employee
ADD ProbationEnd DATETIME;

UPDATE Employee
SET ProbationEnd = DATEADD(MONTH, 6, JoinDate);
GO

-- =============================================
-- PART 1: BASIC SELECT QUERIES
-- =============================================

-- 1.1 Display all employees
SELECT * FROM Employee;

-- 1.2 Display first 5 employees
SELECT TOP 5 * FROM Employee;

-- 1.3 Display specific columns with full name
SELECT
    EmployeeId,
    FirstName,
    LastName,
    CONCAT(FirstName, ' ', LastName) AS FullName,
    Email,
    Salary,
    Department,
    JoinDate
FROM Employee;

-- =============================================
-- PART 2: STRING FUNCTIONS
-- =============================================

SELECT
    -- Basic string functions
    FirstName,
    UPPER(FirstName) AS NameUpper,
    LOWER(FirstName) AS NameLower,
    LEN(FirstName) AS NameLength,
    ASCII(FirstName) AS FirstCharASCII,

    -- String manipulation
    CHARINDEX('a', FirstName) AS PositionOfA,
    LTRIM(FirstName) AS LeftTrimmed,
    RTRIM(FirstName) AS RightTrimmed,
    REVERSE(FirstName) AS NameReversed,
    SUBSTRING(FirstName, 1, 3) AS First3Letters,
    REPLICATE(FirstName, 2) AS NameRepeated,
    REPLACE(FirstName, 'a', '@') AS NameReplaced,

    -- Full name combinations
    CONCAT(FirstName, ' ', LastName) AS FullName,
    CONCAT(LEFT(FirstName, 1), '. ', LastName) AS ShortName
FROM Employee;

-- =============================================
-- PART 3: AGGREGATE FUNCTIONS
-- =============================================

-- 3.1 Basic aggregates
SELECT
    COUNT(*) AS TotalEmployees,
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AverageSalary,
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary
FROM Employee;

-- 3.2 Aggregates by department
SELECT
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AvgSalary,
    MAX(Salary) AS MaxSalary,
    MIN(Salary) AS MinSalary
FROM Employee
GROUP BY Department;

-- 3.3 Aggregates by department with HAVING clause
SELECT
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Department
HAVING SUM(Salary) > 200000
ORDER BY TotalSalary DESC;

-- =============================================
-- PART 4: DATE FUNCTIONS
-- =============================================

-- 4.1 Current date/time functions
SELECT
    GETDATE() AS CurrentDateTime,
    CURRENT_TIMESTAMP AS CurrentTimestamp,
    SYSDATETIME() AS SystemDateTime,
    GETUTCDATE() AS UTCDateTime;

-- 4.2 Extract date parts
SELECT
    DAY(GETDATE()) AS CurrentDay,
    MONTH(GETDATE()) AS CurrentMonth,
    YEAR(GETDATE()) AS CurrentYear,
    DATEPART(HOUR, GETDATE()) AS CurrentHour,
    DATEPART(WEEKDAY, GETDATE()) AS DayOfWeek;

-- 4.3 DATEADD - Add to dates
SELECT
    JoinDate,
    DATEADD(DAY, 10, JoinDate) AS Plus10Days,
    DATEADD(MONTH, 3, JoinDate) AS Plus3Months,
    DATEADD(YEAR, 1, JoinDate) AS Plus1Year,
    DATEADD(HOUR, 2, JoinDate) AS Plus2Hours
FROM Employee;

-- 4.4 DATEDIFF - Date differences
SELECT
    FirstName,
    JoinDate,
    DATEDIFF(DAY, JoinDate, GETDATE()) AS DaysSinceJoining,
    DATEDIFF(MONTH, JoinDate, GETDATE()) AS MonthsSinceJoining,
    DATEDIFF(YEAR, JoinDate, GETDATE()) AS YearsSinceJoining
FROM Employee;

-- 4.5 Date formatting with CONVERT
SELECT
    FirstName,
    JoinDate,
    CONVERT(VARCHAR(10), JoinDate, 101) AS USFormat,
    CONVERT(VARCHAR(10), JoinDate, 103) AS UKFormat,
    CONVERT(VARCHAR(10), JoinDate, 112) AS ISOFormat,
    CONVERT(VARCHAR(10), JoinDate, 120) AS ODBCFormat
FROM Employee;

-- 4.6 CAST with dates
SELECT
    CAST(GETDATE() AS DATE) AS OnlyDate,
    CAST(GETDATE() AS TIME) AS OnlyTime,
    CAST(JoinDate AS DATE) AS JoinDateOnly
FROM Employee;

-- 4.7 ISDATE - Validate dates
SELECT
    ISDATE('2026-04-17') AS ValidDate1,
    ISDATE('31/02/2026') AS InvalidDate,
    ISDATE(Email) AS IsEmailValid; -- Test with non-date column

-- =============================================
-- PART 5: SALARY CONVERSIONS
-- =============================================

SELECT
    FirstName,
    LastName,
    Salary AS SalaryBDT,
    CONVERT(DECIMAL(10,2), Salary/120) AS SalaryUSD,
    CONVERT(DECIMAL(10,2), Salary/90) AS SalaryEUR
FROM Employee;

-- =============================================
-- PART 6: WHERE CLAUSE CONDITIONS
-- =============================================

-- 6.1 Equal condition
SELECT * FROM Employee WHERE Department = 'Engineering';

-- 6.2 Greater than
SELECT * FROM Employee WHERE Salary > 80000;

-- 6.3 Multiple conditions
SELECT * FROM Employee
WHERE Department = 'Engineering' AND Salary > 90000;

-- 6.4 IN operator
SELECT * FROM Employee
WHERE Department IN ('Engineering', 'Marketing');

-- 6.5 LIKE operator
SELECT * FROM Employee
WHERE FirstName LIKE 'R%'; -- Names starting with R

SELECT * FROM Employee
WHERE Email LIKE '%@email.com';

-- 6.6 BETWEEN operator
SELECT * FROM Employee
WHERE Salary BETWEEN 60000 AND 100000;

-- =============================================
-- PART 7: SUBQUERIES
-- =============================================

-- 7.1 Subquery in WHERE
SELECT * FROM Employee
WHERE Salary > (
    SELECT AVG(Salary) FROM Employee
);

-- 7.2 Subquery with IN
SELECT * FROM Employee
WHERE Department IN (
    SELECT Department
    FROM Employee
    GROUP BY Department
    HAVING AVG(Salary) > 75000
);

-- 7.3 Correlated subquery - employees earning more than their department average
SELECT
    FirstName,
    LastName,
    Salary,
    Department
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE Department = e.Department
);

-- =============================================
-- PART 8: UPDATE OPERATIONS
-- =============================================

-- 8.1 Update single record
SELECT * FROM Employee WHERE EmployeeId = 5;
UPDATE Employee SET Salary = 60000 WHERE EmployeeId = 5;
SELECT * FROM Employee WHERE EmployeeId = 5;

-- 8.2 Update multiple records
UPDATE Employee
SET Status = 'Probation'
WHERE JoinDate > DATEADD(MONTH, -6, GETDATE());
SELECT * FROM Employee;

-- 8.3 Update with calculation
UPDATE Employee
SET Salary = Salary * 1.10
WHERE Department = 'HR';
SELECT * FROM Employee WHERE Department = 'HR';

-- =============================================
-- PART 9: DELETE OPERATIONS
-- =============================================

-- 9.1 Delete single record (create temp data first)
INSERT INTO Employee VALUES (99, 'Test', 'User', 'test@email.com', 50000, 'IT', GETDATE(), NULL, 'Active');
SELECT * FROM Employee WHERE EmployeeId = 99;
DELETE FROM Employee WHERE EmployeeId = 99;
-- SELECT * FROM Employee WHERE EmployeeId = 99; -- Verify deletion

-- =============================================
-- PART 10: ORDER BY & DISTINCT
-- =============================================

-- 10.1 Order by single column
SELECT * FROM Employee ORDER BY Salary;

-- 10.2 Order by multiple columns
SELECT * FROM Employee ORDER BY Department ASC, Salary DESC;

-- 10.3 DISTINCT values
SELECT DISTINCT Department FROM Employee;

-- 10.4 DISTINCT with aggregation
SELECT COUNT(DISTINCT Department) AS TotalDepartments FROM Employee;

-- =============================================
-- PART 11: LIKE OPERATOR PATTERNS
-- =============================================

SELECT * FROM Employee WHERE FirstName LIKE 'R%';     -- Starts with R
SELECT * FROM Employee WHERE FirstName LIKE '%a';     -- Ends with a
SELECT * FROM Employee WHERE FirstName LIKE '_a%';    -- Second letter is a
SELECT * FROM Employee WHERE FirstName LIKE '%a%';   -- Contains 'a' anywhere

-- =============================================
-- PART 12: IS NULL / IS NOT NULL
-- =============================================

SELECT * FROM Employee WHERE ProbationEnd IS NULL;
SELECT * FROM Employee WHERE ProbationEnd IS NOT NULL;

-- =============================================
-- PART 13: ALIASES AND EXPRESSIONS
-- =============================================

SELECT
    EmployeeId,
    FirstName,
    LastName,
    Salary,
    Salary * 12 AS AnnualSalary,
    Salary / 30 AS DailySalary,
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employee;

-- =============================================
-- FINAL: Display all employee data
-- =============================================
SELECT * FROM Employee;
