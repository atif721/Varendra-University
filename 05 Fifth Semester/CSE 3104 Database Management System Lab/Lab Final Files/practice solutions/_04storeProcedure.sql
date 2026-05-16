USE FinalLab;
GO


CREATE TABLE Branch
(
  Br_Id VARCHAR(15) PRIMARY KEY NOT NULL,
  Branch_Name VARCHAR(50)
);

CREATE TABLE Zone
(
  Zone_Id VARCHAR(15) PRIMARY KEY NOT NULL,
  Zone_Name VARCHAR(50)
);

CREATE TABLE Account_Detail
(
  Account_no INT NOT NULL PRIMARY KEY,
  Acc_holder_name VARCHAR(50),
  Amount INT,
  Branch_Id VARCHAR(15),
  Zone_Id VARCHAR(15),
  FOREIGN KEY (Branch_Id) REFERENCES Branch(Br_Id),
  FOREIGN KEY (Zone_Id) REFERENCES Zone(Zone_Id),
);
GO

-- Insert into Zone
CREATE PROCEDURE sp_InsertZone
  @Zone_Id VARCHAR(15),
  @Zone_Name VARCHAR(50)
AS
BEGIN
  INSERT INTO [Zone]
  VALUES
    (@Zone_Id, @Zone_Name)
END;
GO

EXEC sp_InsertZone 'Z-801', 'Sirajgonj';
EXEC sp_InsertZone 'Z-802', 'Rajshahi';
EXEC sp_InsertZone 'Z-803', 'Dhaka';
EXEC sp_InsertZone 'Z-804', 'Chittagong';
GO

SELECT *
FROM [Zone]
GO

-- Insert into branch
CREATE PROCEDURE sp_InsertBranch
  @Br_Id VARCHAR(15),
  @Branch_Name VARCHAR(50)
AS
BEGIN
  INSERT INTO [Branch]
  VALUES
    (@Br_Id, @Branch_Name)
END;
GO

EXEC sp_InsertBranch 'B-101', 'Bonani';
EXEC sp_InsertBranch 'B-102', 'Romna';
EXEC sp_InsertBranch 'B-103', 'Shaheb bazar';
EXEC sp_InsertBranch 'B-104', 'Ullapara';
GO

SELECT *
FROM [Branch]
GO

-- Insert Account Details
CREATE PROCEDURE sp_InsertAccount
  @Account_no INT,
  @Acc_holder_name VARCHAR(50),
  @Amount INT,
  @Branch_Id VARCHAR(15),
  @Zone_Id VARCHAR(15)
AS
BEGIN
  INSERT INTO [Account_Detail]
  VALUES
    (@Account_no, @Acc_holder_name, @Amount, @Branch_Id, @Zone_Id)
END;
GO

EXEC sp_InsertAccount 1992212, 'Mr. Nazmuzzaman', 200000, 'B-101', 'Z-803';
EXEC sp_InsertAccount 1992213, 'Mr. Jibon',       170000, 'B-102', 'Z-803';
EXEC sp_InsertAccount 1882212, 'Bushra',           180000, 'B-103', 'Z-802';
EXEC sp_InsertAccount 1882213, '%Sajib',           170000, 'B-104', 'Z-801';
GO

SELECT *
FROM [Account_Detail]
GO

-- Question-1
CREATE PROCEDURE SPdetails
AS
BEGIN
  SELECT acc.Acc_holder_name,
    acc.Amount,
    br.Branch_Name,
    z.Zone_Name
  FROM Account_Detail acc
    JOIN Branch br ON acc.Branch_Id = br.Br_Id
    JOIN Zone z ON acc.Zone_Id = z.Zone_Id
END;
GO

EXEC SPdetails;
GO

-- Question-2
CREATE PROCEDURE SPaverage
  @Branch_Name VARCHAR(50),
  @MinAmount INT
AS
BEGIN
  SELECT
    br.Branch_Name,
    acc.Amount
  FROM Account_Detail acc
    JOIN Branch br ON acc.Branch_Id = br.Br_Id
  WHERE br.Branch_Name = @Branch_Name
    AND acc.Amount > @MinAmount
END;
GO

EXEC SPaverage 'Romna', 17000000;
GO

-- Question-3
CREATE PROCEDURE SPbalance
  @Zone_Name VARCHAR(100)
AS
BEGIN
  DECLARE @TotalAmount INT;
  SELECT @TotalAmount = SUM(A.Amount)
  FROM Account_Detail A
    JOIN Zone Z ON A.Zone_Id = Z.Zone_Id
  WHERE Z.Zone_Name = @Zone_Name;
  RETURN @TotalAmount;
END;
GO

DECLARE @Result INT;
EXEC @Result = SPbalance 'Dhaka';
PRINT 'Total Amount = ' + CAST(@Result AS VARCHAR);
GO

-- Question-4
CREATE PROCEDURE SPamount
AS
BEGIN
  DECLARE @MaxAmount INT;

  SELECT @MaxAmount = MAX(Amount)
  FROM Account_Detail;

  SELECT
    A.Acc_holder_name,
    B.Branch_Name,
    Z.Zone_Name AS Zone_Name,
    A.Amount
  FROM Account_Detail A
    JOIN Branch B
    ON A.Branch_Id = B.Br_Id
    JOIN Zone Z
    ON A.Zone_Id = Z.Zone_Id
  WHERE 
        A.Acc_holder_name LIKE '%Mr.%'
    AND A.Amount < @MaxAmount;
END;
GO

EXEC SPamount;
GO

-- Question-5
CREATE PROCEDURE SPdetailsInfo
  @Zone_Name VARCHAR(100),
  @TotalCustomer INT OUTPUT
AS
BEGIN
  SELECT @TotalCustomer = COUNT(*)
  FROM Account_Detail A
    JOIN Zone Z
    ON A.Zone_Id = Z.Zone_Id
  WHERE Z.Zone_Name = @Zone_Name;
END;
GO

DECLARE @Count INT;
EXEC SPdetailsInfo 'Dhaka', @Count OUTPUT;
PRINT 'Total Customer = ' + CAST(@Count AS VARCHAR);
GO

-- Question-6
CREATE PROCEDURE spEmployeeSalaryDetails1
  @StartAmount INT,
  @EndAmount INT,
  @Branch_Name VARCHAR(100),
  @TotalBranch INT OUTPUT
AS
BEGIN
  SELECT @TotalBranch = COUNT(*)
  FROM Account_Detail A
    JOIN Branch B
    ON A.Branch_Id = B.Br_Id
  WHERE 
        A.Amount BETWEEN @StartAmount AND @EndAmount
    AND B.Branch_Name LIKE '%' + @Branch_Name + '%';
END;
GO

DECLARE @BranchCount INT;
EXEC spEmployeeSalaryDetails1
    7000,
    30000,
    'Ba',
    @BranchCount OUTPUT;
PRINT 'Total Branch = ' + CAST(@BranchCount AS VARCHAR);
GO

-- Question-7
CREATE PROCEDURE SPdetailsInfo_Zone
  @Zone_Name VARCHAR(100)
AS
BEGIN
  SELECT
    Z.Zone_Name AS Zone_Name,
    COUNT(A.Account_no) AS TotalCustomer
  FROM Account_Detail A
    JOIN Zone Z
    ON A.Zone_Id = Z.Zone_Id
  WHERE Z.Zone_Name = @Zone_Name
  GROUP BY Z.Zone_Name;
END;
GO

EXEC SPdetailsInfo_Zone 'Dhaka';
GO

-- Question-8
CREATE PROCEDURE SPdetailsInfo1
  @Branch_Name VARCHAR(100)
AS
BEGIN
  SELECT
    Z.Zone_Name AS Zone_Name,
    COUNT(B.Br_Id) AS TotalBranch
  FROM Account_Detail A
    JOIN Branch B
    ON A.Branch_Id = B.Br_Id
    JOIN Zone Z
    ON A.Zone_Id = Z.Zone_Id
  WHERE B.Branch_Name = @Branch_Name
  GROUP BY Z.Zone_Name;
END;
GO

EXEC SPdetailsInfo1 'Bonani';
GO