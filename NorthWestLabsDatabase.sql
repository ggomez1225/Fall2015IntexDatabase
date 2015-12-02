---------SQL Script for North West Labs Fall 2015 Intex Database----------------
---------Create Default Sequence------------------------------------------------
Create Sequence NWLID start with 1000 increment by 1;
---------Create Tables----------------------------------------------------------
Create Table LegalEntity(LegalEntityID int default next value for NWLID Sequence
Primary Key, CreationDate date, Name varchar(50), Address1 varchar(100), Address2
varchar(100), City varchar(100), State char(2), Zip char(10), Email varchar(100)
, Phone varchar(15), Fax varchar(15));

Create Table WebUser(WebUserID int default next value for NWLID Sequence
Primary Key, Username varchar(50), Passwoord varchar(50), LegalEntityID int
references LegalEntity not null);

Create Table Customer(CustomerID int references LegalEntity(LegalEntityID)
Primary Key, ContactName varchar(100), ContactPhone varchar(15));

Create Table Employee(EmployeeID int references LegalEntity(LegalEntityID)
Primary Key);

Create Table WageEmployee(WageEmployeeID int references Employee(EmployeeID)
Primary Key, Wage decimal(3,2));

Create Table SalaryEmployee(SalaryEmployeeID int references Employee(EmployeeID)
Primary Key, Salary int);


-- Andy's Changes
