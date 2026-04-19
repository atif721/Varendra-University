-- -- ============================================================================
-- -- SECTION 1: DDL (DATA DEFINITION LANGUAGE) COMMANDS
-- -- ============================================================================

-- 1.1 CREATE TABLE
CREATE TABLE Worker (
    WORKER_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(10),
    LAST_NAME VARCHAR(10),
    SALARY NUMERIC(8),
    DEPARTMENT VARCHAR(10)
);

-- -- 1.2 ALTER TABLE - ADD COLUMN
-- ALTER TABLE Worker ADD JOINING_DATE DATE;

-- -- 1.3 ALTER TABLE - ALTER COLUMN (SQL Server syntax)
-- ALTER TABLE Worker ALTER COLUMN SALARY NUMERIC(10);

-- -- 1.4 ALTER TABLE - DROP COLUMN
-- ALTER TABLE Worker DROP COLUMN LAST_NAME;

-- -- 1.5 ALTER TABLE - RENAME COLUMN (SQL Server uses sp_rename)
-- EXEC sp_rename 'Worker.DEPARTMENT', 'DEPT_NAME', 'COLUMN';

-- -- 1.6 DROP TABLE
-- DROP TABLE Worker;

-- -- 1.7 TRUNCATE TABLE (removes data but keeps structure)
-- TRUNCATE TABLE Worker;

-- -- ============================================================================
-- -- SECTION 2: CONSTRAINTS
-- -- ============================================================================

-- -- 2.1 NOT NULL Constraint
-- CREATE TABLE Student (
--     SNO INT NOT NULL,
--     SNAME CHAR(10)
-- );

-- -- 2.2 UNIQUE Constraint
-- CREATE TABLE Faculty (
--     FCODE INT UNIQUE,
--     FNAME CHAR(10)
-- );

-- -- 2.3 CHECK Constraint
-- CREATE TABLE Subject (
--     SCODE INT,
--     CLASS CHAR(5),
--     CHECK (CLASS IN ('CSE', 'CAD', 'VLSI'))
-- );

-- -- 2.4 PRIMARY KEY Constraint
-- CREATE TABLE Employee (
--     EMP_ID INT PRIMARY KEY,
--     EMP_NAME CHAR(20)
-- );

-- -- 2.5 FOREIGN KEY Constraint
-- CREATE TABLE Works_On (
--     EMP_ID INT,
--     PROJECT_ID INT,
--     FOREIGN KEY (EMP_ID) REFERENCES Employee(EMP_ID)
-- );

-- -- 2.6 DEFAULT Constraint
-- CREATE TABLE Worker_Default (
--     WORKER_ID INT UNIQUE,
--     WORKER_NAME CHAR(10),
--     ADDRESS VARCHAR(20) DEFAULT 'Aurangabad'
-- );

-- -- 2.7 Adding Constraint via ALTER TABLE
-- ALTER TABLE Employee ADD CONSTRAINT PK_EMP PRIMARY KEY (EMP_ID);

-- -- 2.8 Dropping Constraint via ALTER TABLE
-- ALTER TABLE Employee DROP CONSTRAINT PK_EMP;

-- -- ============================================================================
-- -- SECTION 3: DML (DATA MANIPULATION LANGUAGE) COMMANDS
-- -- ============================================================================

-- -- 3.1 INSERT - Single Record
-- INSERT INTO Worker (WORKER_ID, FIRST_NAME, SALARY, DEPT_NAME, JOINING_DATE)
-- VALUES (1, 'Rana', 100000, 'HR', '2014-02-20');

-- 3.2 INSERT - Multiple Records
-- INSERT INTO Worker (WORKER_ID, FIRST_NAME, SALARY, DEPT_NAME, JOINING_DATE)
-- VALUES
--     (2, 'Sanjoy', 80000, 'Admin', '2014-06-11'),
--     (3, 'Mahmudul', 300000, 'HR', '2014-02-20'),
--     (4, 'Asad', 500000, 'Admin', '2014-02-20'),
--     (5, 'Sajib', 500000, 'Admin', '2014-06-11'),
--     (6, 'Alamgir', 200000, 'Account', '2014-06-11'),
--     (7, 'Foridul', 75000, 'Account', '2014-01-20'),
--     (8, 'Keshob', 90000, 'Admin', '2014-04-11');

-- -- -- 3.3 INSERT - From Another Table
-- INSERT INTO Worker_Backup SELECT * FROM Worker WHERE SALARY > 100000;

-- -- 3.4 UPDATE
-- UPDATE Worker SET SALARY = 150000 WHERE WORKER_ID = 1;

-- -- 3.5 UPDATE WITH JOIN
-- UPDATE commissions
-- SET commission = c.base_amount * t.percentage
-- FROM commissions c
-- INNER JOIN targets t ON c.target_id = t.target_id;

-- -- 3.6 DELETE - All Records
-- DELETE FROM Worker;

-- -- 3.7 DELETE - With Condition
-- DELETE FROM Worker WHERE WORKER_ID = 2;

-- -- 3.8 DELETE WITH JOIN
-- DELETE Table1
-- FROM Table1 t1
-- INNER JOIN Table2 t2 ON t1.Col1 = t2.Col1
-- WHERE t2.Col3 IN ('Two-Three', 'Two-Four');

-- -- ============================================================================
-- -- SECTION 4: DATA COPYING OPERATIONS
-- -- ============================================================================

-- -- 4.1 INSERT INTO SELECT
-- -- INSERT INTO Customers (CustomerName, City, Country)
-- -- SELECT SupplierName, City, Country FROM Suppliers;

-- -- 4.2 SELECT INTO (creates new table)
-- -- SELECT * INTO CustomersBackup2017 FROM Customers;

-- -- 4.3 SELECT with OFFSET FETCH
-- -- SELECT product_name, list_price
-- -- FROM production.products
-- -- ORDER BY list_price DESC, product_name
-- -- OFFSET 10 ROWS FETCH FIRST 10 ROWS ONLY;

-- -- ============================================================================
-- -- SECTION 5: AGGREGATE FUNCTIONS
-- -- ============================================================================

-- -- 5.1 COUNT
-- -- SELECT COUNT(Sal) FROM emp;
-- -- SELECT COUNT(DISTINCT Sal) FROM emp;
-- -- SELECT COUNT(*) FROM emp;

-- -- 5.2 SUM
-- -- SELECT SUM(Sal) FROM emp;

-- -- 5.3 AVG
-- -- SELECT AVG(Sal) FROM emp;

-- -- 5.4 MAX
-- -- SELECT MAX(Sal) FROM emp;

-- -- 5.5 MIN
-- -- SELECT MIN(Sal) FROM emp;

-- -- 5.6 GROUP BY
-- -- SELECT EMPNO, SUM(SALARY) FROM EMP GROUP BY EMPNO;

-- -- 5.7 GROUP BY - HAVING
-- -- SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
-- -- FROM Orders
-- -- INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
-- -- GROUP BY LastName
-- -- HAVING COUNT(Orders.OrderID) > 10;

-- -- 5.8 ORDER BY
-- -- SELECT empno, ename, job FROM emp ORDER BY job;

-- -- ============================================================================
-- -- SECTION 6: NUMBER FUNCTIONS
-- -- ============================================================================

-- -- SELECT ABS(-15);                     -- Absolute value
-- -- SELECT POWER(4.0, 2.0);              -- Power
-- -- SELECT 10 % 3;                       -- Modulus
-- -- SELECT ROUND(100.256, 2);            -- Round
-- -- SELECT FLOOR(100.256);               -- Truncate (SQL Server uses FLOOR)
-- -- SELECT SQRT(16.0);                   -- Square root

-- -- ============================================================================
-- -- SECTION 7: CHARACTER/STRING FUNCTIONS
-- -- ============================================================================

-- SELECT INITCAP('hello');                    -- Initcap (SQL Server: UPPER(LEFT(col,1))+LOWER(SUBSTRING(col,2,LEN(col))))
-- SELECT LOWER('HELLO');                      -- Lowercase
-- SELECT UPPER('hello');                      -- Uppercase
-- SELECT LTRIM('  cseit');                     -- Left trim (SQL Server only trims spaces by default)
-- SELECT RTRIM('cseit  ');                     -- Right trim
-- SELECT REPLACE('jack and jue', 'j', 'bl');  -- Replace

-- -- ASCII Functions
-- SELECT ASCII(CustomerName) AS NumCodeOfFirstChar FROM Customers;
-- SELECT CHAR(97);  -- Returns 'a'

-- -- String Manipulation
-- SELECT CHARINDEX('@', 'nurse09@gmail.com');           -- Returns position (9)
-- SELECT CONCAT('W3Schools', '.com');                   -- Concatenation
-- SELECT 'W3Schools' + '.com';                          -- Using + operator
-- SELECT LEFT('SQL Tutorial', 3);                       -- Returns 'SQL'
-- SELECT RIGHT('SQL Tutorial', 3);                      -- Returns 'ial'
-- SELECT LEN(' nur');                                   -- Returns 4
-- SELECT SUBSTRING('nurse09@gmail.com', 1, 8);          -- Returns 'nurse09'
-- SELECT REPLICATE('Nur ', 2);                          -- Returns 'Nur Nur '
-- SELECT SPACE(5);                                      -- Returns 5 spaces
-- SELECT REVERSE('nur');                                -- Returns 'run'

-- -- ============================================================================
-- -- SECTION 8: DATE FUNCTIONS
-- -- ============================================================================

-- -- ISDATE is not available in SQL Server; use TRY_CAST or TRY_CONVERT instead
-- SELECT TRY_CAST('2012-08-31 21:02:04.167' AS DATETIME);
-- SELECT DAY('01/31/2012');                     -- Returns 31
-- SELECT MONTH('01/31/2012');                   -- Returns 1
-- SELECT YEAR('01/31/2012');                    -- Returns 2012
-- SELECT GETDATE();                             -- Current date/time
-- SELECT CURRENT_TIMESTAMP;                     -- Current timestamp
-- SELECT SYSDATETIME();                         -- SQL Server date/time
-- SELECT GETUTCDATE();                          -- UTC date/time

-- -- Date Arithmetic
-- SELECT DATEADD(DAY, 20, '2012-08-30 19:45:31.793');  -- Add 20 days
-- SELECT DATEADD(DAY, -20, '2012-08-30');              -- Subtract 20 days
-- SELECT DATEADD(MONTH, 2, '2017/08/25');              -- Add 2 months

-- -- Date Difference
-- SELECT DATEDIFF(MONTH, '11/30/2005', '01/31/2006');  -- Returns 2
-- SELECT DATEDIFF(DAY, '11/30/2005', '01/31/2006');    -- Returns 62
-- SELECT DATEDIFF(YEAR, '2017/08/25', '2011/08/25');   -- Returns -6

-- -- Date Parts
-- SELECT DATEPART(YEAR, '2017/08/25');          -- Returns 2017
-- SELECT DATEPART(MONTH, '2017/08/25');         -- Returns 8
-- SELECT DATEPART(WEEK, '2017/08/25');          -- Returns 34

-- -- ============================================================================
-- -- SECTION 9: CONVERSION FUNCTIONS
-- -- ============================================================================

-- -- CAST
-- SELECT CAST(25.65 AS INT);                    -- Returns 25
-- SELECT CAST('2017-08-25' AS DATETIME);        -- Returns 2017-08-25 00:00:00.000

-- -- CONVERT
-- SELECT CONVERT(INT, 25.65);                   -- Returns 25
-- SELECT CONVERT(VARCHAR, '2017-08-25', 101);   -- Returns 2017-08-25

-- -- ============================================================================
-- -- SECTION 10: ARITHMETIC OPERATORS
-- -- ============================================================================

-- SELECT 10 + 5;    -- Addition
-- SELECT 10 - 5;    -- Subtraction
-- SELECT 10 * 5;    -- Multiplication
-- SELECT 10 / 5;    -- Division
-- SELECT POWER(10, 2);  -- Power
-- SELECT 10 % 3;    -- Modulus

-- -- ============================================================================
-- -- SECTION 11: LOGICAL OPERATORS
-- -- ============================================================================

-- -- AND
-- SELECT * FROM Customers WHERE Country = 'Germany' AND City = 'Berlin';

-- -- OR
-- SELECT * FROM Customers WHERE City = 'Berlin' OR City = 'Munchen';

-- -- NOT
-- SELECT * FROM Customers WHERE NOT Country = 'Germany';

-- -- Combined
-- SELECT * FROM Customers
-- WHERE Country = 'Germany' AND (City = 'Berlin' OR City = 'Munchen');

-- -- ============================================================================
-- -- SECTION 12: COMPARISON OPERATORS
-- -- ============================================================================

-- SELECT * FROM Products WHERE Price = 100;     -- Equal
-- SELECT * FROM Products WHERE Price != 100;    -- Not equal
-- SELECT * FROM Products WHERE Price <> 100;    -- Not equal (alternative)
-- SELECT * FROM Products WHERE Price > 100;     -- Greater than
-- SELECT * FROM Products WHERE Price < 100;     -- Less than
-- SELECT * FROM Products WHERE Price >= 100;    -- Greater or equal
-- SELECT * FROM Products WHERE Price <= 100;    -- Less or equal

-- -- ============================================================================
-- -- SECTION 13: SPECIAL OPERATORS
-- -- ============================================================================

-- -- BETWEEN
-- SELECT name FROM instructor WHERE salary BETWEEN 90000 AND 100000;

-- -- NOT BETWEEN
-- SELECT * FROM Products WHERE Price NOT BETWEEN 10 AND 20;

-- -- BETWEEN with IN
-- SELECT * FROM Products
-- WHERE (Price BETWEEN 10 AND 20) AND CategoryID NOT IN (1, 2, 3);

-- -- LIKE (Pattern Matching)
-- SELECT * FROM Customers WHERE CustomerName LIKE 'a%';     -- Starts with 'a'
-- SELECT * FROM Customers WHERE CustomerName LIKE '%a';     -- Ends with 'a'
-- SELECT * FROM Customers WHERE CustomerName LIKE '%or%';   -- Contains 'or'
-- SELECT * FROM Customers WHERE CustomerName LIKE '_r%';    -- 'r' in second position
-- SELECT * FROM Customers WHERE CustomerName LIKE 'a_%';    -- Starts with 'a', min 2 chars
-- SELECT * FROM Customers WHERE CustomerName LIKE 'a__%';   -- Starts with 'a', min 3 chars

-- -- IN
-- SELECT * FROM Customers WHERE Country IN ('Germany', 'France', 'UK');
-- SELECT * FROM Customers WHERE Country IN (SELECT Country FROM Suppliers);

-- -- EXISTS
-- SELECT * FROM sales.orders o
-- WHERE EXISTS (
--     SELECT customer_id FROM sales.customers c
--     WHERE o.customer_id = c.customer_id AND city = 'San Jose'
-- );

-- -- ANY
-- SELECT ProductName FROM Products
-- WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);

-- -- ALL
-- SELECT ProductName FROM Products
-- WHERE ProductID = ALL (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);

-- -- ============================================================================
-- -- SECTION 14: NULL HANDLING
-- -- ============================================================================

-- -- COALESCE (returns first non-null value)
-- SELECT COALESCE(NULL, 1, 2, 'W3Schools.com');  -- Returns 1

-- -- ISNULL
-- SELECT ISNULL('Hello', 'W3Schools.com');  -- Returns 'Hello'
-- SELECT ISNULL(NULL, 500);                 -- Returns 500

-- -- CASE...END
-- SELECT Employee_Name,
--        CASE WHEN Employee_Name IS NULL THEN 'Owner' ELSE Employee_Name END AS Manager_Name
-- FROM Employee_Detail;

-- -- ============================================================================
-- -- SECTION 15: SET OPERATORS
-- -- ============================================================================

-- -- UNION (distinct rows from both queries)
-- SELECT columnname FROM tablename1
-- UNION
-- SELECT columnname FROM tablename2;

-- -- UNION ALL (all rows including duplicates)
-- SELECT columnname FROM tablename1
-- UNION ALL
-- SELECT columnname FROM tablename2;

-- -- INTERSECT (common rows)
-- SELECT columnname FROM tablename1
-- INTERSECT
-- SELECT columnname FROM tablename2;

-- -- EXCEPT (rows in first but not in second)
-- SELECT columnname FROM tablename1
-- EXCEPT
-- SELECT columnname FROM tablename2;

-- -- ============================================================================
-- -- SECTION 16: JOINS
-- -- ============================================================================

-- -- 16.1 INNER JOIN
-- SELECT columns FROM table1
-- INNER JOIN table2 ON table1.column = table2.column;

-- -- 16.2 NATURAL JOIN
-- SELECT columns/* FROM table1 NATURAL JOIN table2;

-- -- 16.3 LEFT OUTER JOIN
-- SELECT suppliers.supplier_id, suppliers.supplier_name, order1.order_number
-- FROM suppliers
-- LEFT OUTER JOIN order1 ON suppliers.supplier_id = order1.supplier_id;

-- -- 16.4 RIGHT OUTER JOIN
-- SELECT order1.order_number, order1.city, suppliers.supplier_name
-- FROM suppliers
-- RIGHT OUTER JOIN order1 ON suppliers.supplier_id = order1.supplier_id;

-- -- 16.5 FULL OUTER JOIN
-- SELECT suppliers.supplier_id, suppliers.supplier_name, order1.order_number
-- FROM suppliers
-- FULL OUTER JOIN order1 ON suppliers.supplier_id = order1.supplier_id;

-- -- 16.6 EQUI JOIN
-- SELECT column_list FROM table1, table2
-- WHERE table1.column_name = table2.column_name;

-- -- Alternative EQUI JOIN syntax
-- SELECT * FROM table1
-- JOIN table2 ON (join_condition);

-- -- 16.7 NON-EQUI JOIN
-- SELECT table1.column, table2.column FROM table1
-- JOIN table2 ON (table1.column_name < table2.column_name);

-- -- Alternative NON-EQUI JOIN
-- SELECT * FROM table_name1, table_name2
-- WHERE table_name1.column > table_name2.column;

-- -- 16.8 SELF JOIN
-- SELECT a.column_name, b.column_name
-- FROM table1 a, table1 b
-- WHERE a.common_field = b.common_field;

-- -- Example: Find employees with higher salary than others
-- SELECT a.name, b.age, a.SALARY
-- FROM CUSTOMERS a, CUSTOMERS b
-- WHERE a.SALARY < b.SALARY;

-- -- 16.9 CROSS JOIN (Cartesian Product)
-- SELECT * FROM table1 CROSS JOIN table2;

-- -- Alternative syntax
-- SELECT * FROM table1, table2;

-- -- Example
-- SELECT emp_no, emp_name, job_name, dep_name, location
-- FROM emp_mast CROSS JOIN dep_mast;

-- -- 16.10 ANTI JOIN
-- SELECT departments.department_id, departments.department_name
-- FROM departments
-- WHERE NOT EXISTS (
--     SELECT 1 FROM customer
--     WHERE customer.department_id = departments.department_id
-- )
-- ORDER BY departments.department_id;

-- -- ============================================================================
-- -- SECTION 17: SUBQUERIES
-- -- ============================================================================

-- -- Subquery in WHERE clause
-- SELECT * FROM Worker
-- WHERE SALARY > (SELECT AVG(SALARY) FROM Worker);

-- -- Subquery in HAVING clause
-- SELECT DEPT_NAME, COUNT(*)
-- FROM Worker
-- GROUP BY DEPT_NAME
-- HAVING COUNT(*) > (SELECT COUNT(*) FROM Worker WHERE DEPT_NAME = 'HR');

-- -- Subquery in FROM clause
-- SELECT dept_avg.DEPT_NAME, dept_avg.avg_salary
-- FROM (SELECT DEPT_NAME, AVG(SALARY) as avg_salary FROM Worker GROUP BY DEPT_NAME) dept_avg
-- WHERE dept_avg.avg_salary > 50000;

-- -- Subquery with IN
-- SELECT * FROM Worker
-- WHERE WORKER_ID IN (SELECT WORKER_ID FROM Worker WHERE SALARY > 100000);

-- -- Correlated Subquery
-- SELECT e1.name, e1.salary
-- FROM Employee e1
-- WHERE e1.salary > (SELECT AVG(e2.salary) FROM Employee e2 WHERE e2.dept = e1.dept);

-- -- ============================================================================
-- -- SECTION 18: PRACTICAL EXAMPLES WITH WORKER TABLE
-- -- ============================================================================

-- -- Create and populate Worker table
-- CREATE TABLE Worker (
--     WORKER_ID INT PRIMARY KEY,
--     FIRST_NAME VARCHAR(10),
--     LAST_NAME VARCHAR(10),
--     SALARY NUMERIC(8),
--     DEPT_NAME VARCHAR(10),
--     JOINING_DATE DATE
-- );

-- INSERT INTO Worker VALUES (1, 'Rana', 'Hamid', 100000, 'HR', '2014-02-20');
-- INSERT INTO Worker VALUES (2, 'Sanjoy', 'Saha', 80000, 'Admin', '2014-06-11');
-- INSERT INTO Worker VALUES (3, 'Mahmudul', 'Hasan', 300000, 'HR', '2014-02-20');
-- INSERT INTO Worker VALUES (4, 'Asad', 'Zaman', 500000, 'Admin', '2014-02-20');
-- INSERT INTO Worker VALUES (5, 'Sajib', 'Mia', 500000, 'Admin', '2014-06-11');
-- INSERT INTO Worker VALUES (6, 'Alamgir', 'Kabir', 200000, 'Account', '2014-06-11');
-- INSERT INTO Worker VALUES (7, 'Foridul', 'Islam', 75000, 'Account', '2014-01-20');
-- INSERT INTO Worker VALUES (8, 'Keshob', 'Ray', 90000, 'Admin', '2014-04-11');

-- -- Query: First three characters of FIRST_NAME
-- SELECT LEFT(FIRST_NAME, 3) FROM Worker;

-- -- Query: Workers joined between Feb 2014 and March 2014
-- SELECT * FROM Worker
-- WHERE JOINING_DATE BETWEEN '2014-02-01' AND '2014-03-31';

-- -- Query: Workers who served at least 6 months
-- SELECT * FROM Worker
-- WHERE DATEDIFF(MONTH, JOINING_DATE, GETDATE()) >= 6;

-- -- Query: Update salary for managers
-- UPDATE Worker SET SALARY = SALARY * 1.10 WHERE DEPT_NAME = 'Admin';

-- -- Query: Delete workers without bonus
-- DELETE FROM Worker WHERE WORKER_ID NOT IN (SELECT WORKER_REF_ID FROM Bonus);

-- -- Query: Average salary per department
-- SELECT DEPT_NAME, AVG(SALARY) FROM Worker GROUP BY DEPT_NAME;

-- -- Query: Employees with max/min salary per department
-- SELECT DEPT_NAME, MAX(SALARY), MIN(SALARY) FROM Worker GROUP BY DEPT_NAME;

-- -- Query: Fetch employees with same salary
-- SELECT W1.FIRST_NAME, W1.SALARY
-- FROM Worker W1, Worker W2
-- WHERE W1.SALARY = W2.SALARY AND W1.WORKER_ID != W2.WORKER_ID;

-- -- Query: Second highest salary
-- SELECT MAX(SALARY) FROM Worker
-- WHERE SALARY < (SELECT MAX(SALARY) FROM Worker);

-- -- Query: Fetch first 50% of records
-- SELECT * FROM Worker
-- WHERE WORKER_ID <= (SELECT COUNT(*)/2 FROM Worker);

-- -- Query: Departments with less than 5 people
-- SELECT DEPT_NAME, COUNT(*) FROM Worker
-- GROUP BY DEPT_NAME
-- HAVING COUNT(*) < 5;

-- -- Query: Show last record
-- SELECT * FROM Worker
-- WHERE WORKER_ID = (SELECT MAX(WORKER_ID) FROM Worker);

-- -- Query: Fetch last 5 records
-- SELECT * FROM Worker
-- ORDER BY WORKER_ID DESC
-- OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

-- -- Query: Highest salary in each department
-- SELECT DEPT_NAME, MAX(SALARY) FROM Worker GROUP BY DEPT_NAME;

-- -- Query: Fetch three max salaries
-- SELECT * FROM Worker
-- ORDER BY SALARY DESC
-- OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

-- -- ============================================================================
-- -- END OF COMPREHENSIVE SQL OPERATIONS FILE
-- -- ============================================================================
