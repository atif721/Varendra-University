-- ==========================================
-- FILE: 241311051_B.sql
-- ==========================================
-- TABLE CREATION & DATA INSERTION
CREATE TABLE Salesman (
  Salesman_ID INT PRIMARY KEY,
  Name VARCHAR(50),
  City VARCHAR(50),
  Commission DECIMAL(4, 2)
);

CREATE TABLE Orders (
  Order_No INT PRIMARY KEY,
  Purchase_amount DECIMAL(10, 2),
  Order_Date DATE,
  Customer_ID INT,
  Salesman_ID INT,
  FOREIGN KEY (Salesman_ID) REFERENCES Salesman(Salesman_ID)
);

INSERT INTO
  Salesman (Salesman_ID, Name, City, Commission)
VALUES
  (5001, 'James Hoog', 'New York', 0.15),
  (5002, 'Nail Knite', 'Paris', 0.13),
  (5005, 'Pit Alex', 'London', 0.11),
  (5006, 'Mc Lyon', 'Paris', 0.14);

INSERT INTO
  Orders (
    Order_No,
    Purchase_amount,
    Order_Date,
    Customer_ID,
    Salesman_ID
  )
VALUES
  (70001, 150.5, '2025-10-04', 3005, 5002),
  (70009, 270.65, '2026-03-11', 3001, 5005),
  (70002, 65.26, '2026-05-05', 3002, 5001),
  (70005, 2400.6, '2026-02-27', 3007, 5001);

GO
  -- 1
  CREATE VIEW Sales_Report AS
SELECT
  O.Order_No AS ord_no,
  S.Name AS salesman_name,
  O.Purchase_amount AS purch_amt
FROM
  Orders O
  JOIN Salesman S ON O.Salesman_ID = S.Salesman_ID;

GO
SELECT * FROM Sales_Report;

GO
  -- 2
  CREATE UNIQUE NONCLUSTERED INDEX IX_Salesman_SalesmanID ON Salesman(Salesman_ID);

GO
  -- 3
  CREATE PROCEDURE spGetOrdersByCity @CityName VARCHAR(50) AS BEGIN
SELECT
  S.Name,
  O.Purchase_amount
FROM
  Salesman S
  JOIN Orders O ON S.Salesman_ID = O.Salesman_ID
WHERE
  S.City = @CityName;

END;

GO
  -- 4
  CREATE PROCEDURE spCountHighCommission @Threshold DECIMAL(4, 2),
  @TotalSalesmen INT OUTPUT AS BEGIN
SELECT
  @TotalSalesmen = COUNT(*)
FROM
  Salesman
WHERE
  Commission > @Threshold;

END;

GO
  -- 5
DELETE FROM
  Orders
WHERE
  Purchase_amount < 100;

GO