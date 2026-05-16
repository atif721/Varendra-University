Create database SP
use SP
Create Table Student
(
  Student_id int primary key not null,
  name varchar (50),
  department varchar(30),
  cgpa decimal(3,2)
);
insert into Student
Values
  (1, 'Rahim', 'CSE', 3.78),
  (2, 'Asha', 'EEE', 3.85),
  (3, 'Karim', 'CSE', 3.40),
  (4, 'Nusrat', 'BBA', 3.65),
  (5, 'Sadia', 'BBA', 3.90);

--Store Procedure 

Create Procedure Student_SP
AS
BEGIN
  Select *
  From Student
END;

EXEC Student_SP

Create Procedure GetStudentbyID
  @id int
as
Begin
  select *
  from Student
  where Student_id = @id
END;

Drop Procedure GetStudentbyID

EXEC GetStudentbyID 2;

Create Procedure Stu_Name_cgpa
  @name varchar (50),
  @cgpa decimal(3,2)
AS
Begin
  Select *
  from Student
  where Name = @name AND cgpa = @cgpa
End

EXEC Stu_Name_cgpa 'Asha', 3.85;
EXEC Stu_Name_cgpa @name = 'Karim' , @cgpa = 3.40;

--insert
Create Procedure InsertStudent
  @id int,
  @name Varchar(50),
  @dept Varchar(30),
  @cgpa decimal (3,2)
AS
Begin
  Insert Into Student
  Values
    (@id, @name, @dept, @cgpa)
End

EXEC InsertStudent 6, 'Shimanto', 'CSE', 3.88;

--update 
Create Procedure UpdateCGPA
  @id int,
  @newcgpa Decimal(3,2)
AS
Begin
  Update Student 
     SET cgpa = @newcgpa  
     where Student_id = @id
END

EXEC UpdateCGPA 1, 3.95
EXEC UpdateCGPA @newcgpa = 3.75, @id = 5

Create Procedure DeleteStudent
  @id int
AS
Begin
  Delete from Student
   Where Student_id = @id
END
EXEC DeleteStudent 1


Create Procedure StudentCount
  @total int OUTPUT
AS
Begin
  Select @total = COUNT (Student_id)
  from Student
END

Declare @result INT;
EXEC StudentCount @result OUTPUT;
Print @result

--Alter Procedure 
Alter Procedure Stu_Name_cgpa
  @name varchar(50)
AS 
   Begin
  Select *
  from Student
  where Name = @name
END 

   EXEC Stu_Name_cgpa Asha
  
  
  Alter  Procedure Stu_Name_cgpa
  @name varchar (50),
  @cgpa decimal(3,2)
AS 
Begin
  Select *
  from Student
  where Name = @name AND cgpa = @cgpa
  order by name
End 

EXEC Stu_Name_cgpa 'Asha', 3.85 

-- System stored Procedure 
EXEC sp_help 
--- To know about a particular procedure 
EXEC sp_help Student 