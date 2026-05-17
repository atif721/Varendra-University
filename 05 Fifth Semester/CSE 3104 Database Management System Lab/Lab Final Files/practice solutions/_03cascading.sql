-- =========================
-- PART 2: CASCADING TASKS
-- =========================

-- 1. Departments and Staff with ON DELETE CASCADE
CREATE TABLE Departments
(
  DeptID INT PRIMARY KEY,
  DeptName VARCHAR(100)
);
GO

CREATE TABLE Staff
(
  StaffID INT PRIMARY KEY,
  StaffName VARCHAR(100),
  DeptID INT,
  CONSTRAINT fk_staff_dept
    FOREIGN KEY (DeptID)
    REFERENCES Departments(DeptID)
    ON DELETE CASCADE
);
GO

-- 2. Add FK to existing Orders table with ON UPDATE CASCADE
ALTER TABLE Orders
ADD CONSTRAINT fk_cust_update
FOREIGN KEY (CustomerID)
REFERENCES Clients(CustomerID)
ON UPDATE CASCADE;
GO

-- 3. Composite Primary Key and ON DELETE CASCADE
CREATE TABLE Projects
(
  ProjectID INT,
  DeptCode VARCHAR(20),
  ProjectName VARCHAR(100),
  PRIMARY KEY (ProjectID, DeptCode)
);
GO

CREATE TABLE Project_Tasks
(
  TaskID INT PRIMARY KEY,
  TaskName VARCHAR(100),
  ProjectID INT,
  DeptCode VARCHAR(20),
  CONSTRAINT fk_project_tasks
    FOREIGN KEY (ProjectID, DeptCode)
    REFERENCES Projects(ProjectID, DeptCode)
    ON DELETE CASCADE
);
GO

-- 4. Shipments referencing Warehouse
-- ON UPDATE CASCADE + prevent delete using NO ACTION
CREATE TABLE Warehouse
(
  WarehouseID INT PRIMARY KEY,
  WarehouseName VARCHAR(100)
);
GO

CREATE TABLE Shipments
(
  ShipmentID INT PRIMARY KEY,
  ShipmentName VARCHAR(100),
  WarehouseID INT,
  CONSTRAINT fk_shipments_warehouse
    FOREIGN KEY (WarehouseID)
    REFERENCES Warehouse(WarehouseID)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);
GO