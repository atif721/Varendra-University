USE Final;
GO

-- ALTER USER sa
-- WITH DEFAULT_SCHEMA = secA

-- -- Drivers
-- CREATE TABLE Drivers
-- (
--   DriverID INT PRIMARY KEY,
--   DriverName VARCHAR(50),
--   VehicleType VARCHAR(30),
--   ContactNumber VARCHAR(15) UNIQUE,
--   JoinDate DATE,
--   BaseSalary INT
-- );

-- INSERT INTO Drivers
-- VALUES
--   (1, 'Ahmed Ali', 'Truck', '01711223344', '2019-05-12', 28000),
--   (2, 'Bablu Mia', 'Van', '01822334455', '2021-08-20', 18000),
--   (3, 'Charles Rozario', 'Heavy Truck', '01733445566', '2018-11-05', 35000),
--   (4, 'David Hasan', 'Van', '01944556677', '2022-02-15', 16500),
--   (5, 'Emon Tariq', 'Mini-Truck', '01555667788', '2023-01-10', 15000),
--   (6, 'Farhan Khan', 'Truck', '01766778899', '2020-07-22', 26000),
--   (7, 'Golam Rabbi', 'Heavy Truck', '01877889900', '2019-09-30', 33000),
--   (8, 'Hasan Mahmud', 'Mini-Truck', '01788990011', '2021-12-12', 17000),
--   (9, 'Imran Hossain', 'Van', '01999001122', '2022-05-18', 16000),
--   (10, 'Jamal Uddin', 'Truck', '01700112233', '2020-03-25', 27500);

-- -- Vehicles
-- CREATE TABLE Vehicles
-- (
--   VehicleID VARCHAR(5) PRIMARY KEY,
--   DriverID INT,
--   LicensePlate VARCHAR(20),
--   VehicleModel VARCHAR(50),
--   PurchaseYear INT,
--   FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
-- );

-- INSERT INTO Vehicles
-- VALUES
--   ('V01', 1, 'DHK-1122', 'Tata Ultra', 2018),
--   ('V02', 2, 'SYL-3344', 'Mahindra', 2020),
--   ('V03', 3, 'CTG-5566', 'Ashok Leyland', 2017),
--   ('V04', 4, 'RAJ-7788', 'Suzuki Super', 2021),
--   ('V05', 5, 'KHL-9900', 'Tata Ace', 2022),
--   ('V06', 6, 'DHK-2233', 'Eicher Pro', 2019),
--   ('V07', 7, 'CTG-4455', 'BharatBenz', 2018),
--   ('V08', 8, 'BAR-6677', 'Mahindra Maxx', 2020),
--   ('V09', 9, 'SYL-8899', 'Suzuki Super', 2021),
--   ('V10', 10, 'RAJ-0011', 'Tata Ultra', 2019);

-- -- Triplogs
-- CREATE TABLE Triplogs
-- (
--   TripID INT PRIMARY KEY,
--   DriverID INT,
--   DestinationCity VARCHAR(50),
--   DistanceKM INT,
--   TripFare INT,
--   TripDate DATE,
--   FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
-- );

-- INSERT INTO Triplogs
-- VALUES
--   (101, 1, 'Dhaka', 250, 5000, '2023-10-01'),
--   (102, 2, 'Sylhet', 320, 6000, '2023-10-02'),
--   (103, 1, 'Chattogram', 450, 8500, '2023-10-05'),
--   (104, 6, 'Rajshahi', 280, 5500, '2023-10-06'),
--   (105, 3, 'Dhaka', 250, 5200, '2023-10-08'),
--   (106, 7, 'Khulna', 380, 7000, '2023-10-09'),
--   (107, 2, 'Sylhet', 320, 6000, '2023-10-12'),
--   (108, 8, 'Barishal', 210, 4500, '2023-10-14'),
--   (109, 10, 'Rajshahi', 280, 5400, '2023-10-15'),
--   (110, 6, 'Chattogram', 450, 8300, '2023-10-18');;

-- Question-1
-- SELECT BaseSalary
-- FROM Drivers

-- UPDATE Drivers
-- SET BaseSalary = BaseSalary * 1.12
-- WHERE VehicleType = 'Van'
--   AND JoinDate < '2022';

-- SELECT BaseSalary
-- FROM Drivers

-- Question-2
-- SELECT
--   UPPER(d.DriverName) AS DriverNameUpper,
--   DATEDIFF(MONTH, d.JoinDate, GETDATE()) AS Experience_total_months
-- FROM Drivers d;

-- Question-3
-- SELECT
--   tr.TripID,
--   tr.DestinationCity,
--   ROUND(tr.TripFare * 0.15,0) AS Bonus
-- FROM Triplogs tr
-- WHERE tr.DistanceKM >300

-- Question-4
-- SELECT
--   tr.DestinationCity,
--   COUNT(*) AS TotalTrips,
--   MAX(tr.TripFare) AS MaxFare
-- FROM Triplogs tr
-- GROUP BY tr.DestinationCity
-- HAVING MAX(tr.TripFare) > 5500;

-- Question-5
-- ALTER TABLE Drivers
-- ADD CONSTRAINT UQContactNumber UNIQUE(ContactNumber);
-- ALTER TABLE Drivers
-- ADD CONSTRAINT ChkSalary_Drv CHECK(BaseSalary>=10000)
