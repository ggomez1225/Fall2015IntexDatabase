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

Create Table Quote(QuoteID int default next value for NWLID Sequence Primary Key,
QuoteAmount decimal(6,2), Compound varchar(100), QtyInMilligrams int, CustomerID
int references Customer not null, WorkOrderID int references WorkOrder);

Create Table WorkOrder(WorkOrderID int default next value for NWLID Sequence
Primary Key, Comments varchar(1000), DiscountPercent decimal(2,2), TotalCharges
decimal(4,2), Status varchar(100), QuoteID int references Quote, InvoiceID int
references Invoice not null);

Create Table Invoice(InvoiceID int default next value for NWLID Sequence
Primary Key, DueDate date, EarlyPaymentDate date, EarlyPaymentDiscount decimal
(2,2), WorkOrderID int references WorkOrder not null);

Create Table Compound (LTNumber char(6) Primary Key, Name varchar(50),
MolecularMass decimal(4,6));
