USE FinalLab;
GO

-- CREATE TABLE salesman
-- (
--   salesman_id INT PRIMARY KEY,
--   name VARCHAR(100),
--   city VARCHAR(100),
--   commission DECIMAL(4,2)
-- );
-- GO

-- CREATE TABLE customer
-- (
--   customer_id INT PRIMARY KEY,
--   cust_name VARCHAR(100),
--   city VARCHAR(100),
--   grade INT,
--   salesman_id INT,
--   FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
-- );
-- GO

-- CREATE TABLE orders
-- (
--   ord_no INT PRIMARY KEY,
--   purch_amt DECIMAL(10,2),
--   ord_date DATE,
--   customer_id INT,
--   salesman_id INT,
--   FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
--   FOREIGN KEY (salesman_id) REFERENCES salesman(salesman_id)
-- );
-- GO

-- CREATE PROCEDURE sp_InsertSalesman
--   @salesman_id INT,
--   @name VARCHAR(100),
--   @city VARCHAR(100),
--   @commission DECIMAL(4,2)
-- AS
-- BEGIN
--   IF NOT EXISTS (
--         SELECT 1
--   FROM salesman
--   WHERE salesman_id = @salesman_id
--     )
--     BEGIN
--     INSERT INTO salesman
--       (salesman_id, name, city, commission)
--     VALUES
--       (@salesman_id, @name, @city, @commission);
-- END;
-- GO

-- EXEC sp_InsertSalesman 5001, 'James Hoog', 'New York', 0.15;
-- EXEC sp_InsertSalesman 5002, 'Nail Knite', 'Paris', 0.13;
-- EXEC sp_InsertSalesman 5005, 'Pit Alex', 'London', 0.11;
-- EXEC sp_InsertSalesman 5006, 'Mc Lyon', 'Paris', 0.14;
-- EXEC sp_InsertSalesman 5003, 'Lauson Hen', 'Berlin', 0.12;
-- EXEC sp_InsertSalesman 5007, 'Paul Adam', 'Rome', 0.13;
-- GO

-- =============================================
-- STORED PROCEDURE: Insert customer data
-- =============================================

-- CREATE PROCEDURE sp_InsertCustomer
-- AS
-- BEGIN
--     INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
--     (3002, 'Nick Rimando',  'New York',   100, 5001),
--     (3005, 'Graham Zusi',   'California', 200, 5002),
--     (3001, 'Brad Guzan',    'London',     300, 5005),
--     (3004, 'Fabian Johns',  'Paris',      300, 5006),
--     (3007, 'Brad Davis',    'New York',   200, 5001),
--     (3009, 'Geoff Camero',  'Berlin',     100, 5003),
--     (3008, 'Julian Green',  'London',     300, 5002),
--     (3003, 'Jozy Altidor',  'Moscow',     200, 5007);

--     PRINT 'Customer data inserted.';
-- END;
-- GO

-- EXEC sp_InsertCustomer;
-- GO

-- =============================================
-- STORED PROCEDURE: Insert orders data
-- =============================================

CREATE PROCEDURE sp_InsertOrders
AS
BEGIN
  INSERT INTO orders
    (ord_no, purch_amt, ord_date, customer_id, salesman_id)
  VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3001, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3009, 5003),
    (70007, 948.5, '2012-09-10', 3005, 5002),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760.0, '2012-09-10', 3002, 5001),
    (70010, 1983.43, '2012-10-10', 3004, 5006),
    (70003, 2480.4, '2012-10-10', 3009, 5003),
    (70012, 250.45, '2012-06-27', 3008, 5002),
    (70011, 75.29, '2012-08-17', 3003, 5007),
    (70013, 3045.6, '2012-04-25', 3002, 5001);

  PRINT 'Orders data inserted.';
END;
GO

EXEC sp_InsertOrders;
GO

-- Question-1
CREATE OR ALTER VIEW vw_NY_Salesmen
AS
  SELECT *
  FROM salesman
  WHERE city = 'New York';
GO

SELECT *
FROM vw_NY_Salesmen;
GO

-- Question-2
CREATE OR ALTER VIEW all_salesman
AS
  SELECT salesman_id, name, city
  FROM salesman;
GO

SELECT *
FROM all_salesman;
GO

-- Question-3
CREATE OR ALTER VIEW nwYork_salesman
AS
  SELECT *
  FROM salesman
  WHERE city = 'New York'
    AND commission > 0.13;
GO

SELECT *
FROM nwYork_salesman;
GO

-- Question-4
CREATE VIEW customer_at_grades
AS
  SELECT grade, COUNT(*) AS Total_Customer
  FROM dbo.customer cst
  GROUP BY cst.grade;
GO

SELECT *
FROM customer_at_grades;
GO

-- Question-5
CREATE VIEW dailyOrder
AS
  SELECT ord_date,
    COUNT(DISTINCT customer_id) AS Customer_ID,
    COUNT(DISTINCT salesman_id) AS Salesman_ID,
    AVG(purch_amt) AS Average_Order_Amnt,
    SUM(purch_amt) AS Sum_Order_Amnt
  FROM orders
  GROUP BY ord_date;
GO

SELECT *
FROM dailyOrder;
GO

-- Question-6;
CREATE VIEW ordersByName
AS
  SELECT o.ord_no,
    c.cust_name AS Customer_Name,
    s.name AS Salesman_Name
  FROM orders o
    JOIN customer c ON o.customer_id = c.customer_id
    JOIN salesman s ON o.salesman_id = s.salesman_id;
GO
SELECT *
FROM ordersByName;
GO

-- Question-7;
CREATE VIEW vw_highest_Salesman
AS
  SELECT o.ord_date,
    s.name AS Salmesman_Name,
    c.cust_name AS Customer_Name,
    o.purch_amt
  FROM orders o
    JOIN customer c ON o.customer_id = c.customer_id
    JOIN salesman s ON o.salesman_id = s.salesman_id
  WHERE o.purch_amt = (
    SELECT MAX(purch_amt)
  FROM orders o2
  WHERE o2.ord_date = o.ord_date
  )
GO
SELECT *
FROM vw_highest_Salesman
GO

-- Question-8
CREATE VIEW vw_highest_Salesman_3d
AS
  SELECT o.ord_date,
    s.name AS Salesman_Name,
    COUNT(*) AS Top_Order_Count
  FROM orders o
    JOIN salesman s ON o.salesman_id = s.salesman_id
  WHERE o.purch_amt = (
  SELECT MAX(purch_amt)
  FROM orders o2
  WHERE o2.ord_date = o.ord_date
  )
  GROUP BY o.ord_date, s.name
  HAVING COUNT(*) >= 3;
GO

SELECT *
FROM vw_highest_Salesman_3d

-- QUestion-9
