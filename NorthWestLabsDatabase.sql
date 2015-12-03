---------SQL Script for North West Labs Fall 2015 Intex Database----------------
---------Create Default Sequence------------------------------------------------
CREATE SEQUENCE NWLID start with 1000 increment by 1;
---------Create Tables----------------------------------------------------------
CREATE TABLE LegalEntity (
  LegalEntityID int default next value for NWLID Sequence Primary Key,
  CreationDate date,
  Name varchar(50),
  Address1 varchar(100),
  Address2 varchar(100),
  City varchar(100),
  State char(2),
  Zip char(10),
  Email varchar(100),
  Phone varchar(15),
  Fax varchar(15)
);

CREATE TABLE WebUser (
  WebUserID int default next value for NWLID Sequence Primary Key,
  Username varchar(50),
  Password varchar(50),
  SecurityAccessLevel int, 
  LegalEntityID int references LegalEntity not null
);

CREATE TABLE Customer (
  CustomerID int references LegalEntity(LegalEntityID) Primary Key,
  ContactName varchar(100),
  ContactPhone varchar(15)
);

Create Table Employee(
EmployeeID int references LegalEntity(LegalEntityID) Primary Key);

CREATE TABLE WageEmployee (
  WageEmployeeID int references Employee(EmployeeID) Primary Key,
  Wage decimal(3,2)
);

CREATE TABLE SalaryEmployee (
  SalaryEmployeeID int references Employee(EmployeeID) Primary Key,
  Salary int
);

CREATE TABLE Quote (
  QuoteID int default next value for NWLID Sequence Primary Key,
  QuoteAmount decimal(6,2),
  Compound varchar(100),
  QtyInMilligrams int,
  CustomerID int references Customer not null,
  WorkOrderID int references WorkOrder
);

CREATE TABLE WorkOrder (
  WorkOrderID int default next value for NWLID Sequence Primary Key,
  Comments varchar(1000),
  DiscountPercent decimal(2,2),
  TotalCharges decimal(4,2),
  Status varchar(100),
  QuoteID int references Quote,
  InvoiceID int references Invoice not null
);

CREATE TABLE Invoice (
  InvoiceID int default next value for NWLID Sequence Primary Key,
  DueDate date,
  EarlyPaymentDate date,
  EarlyPaymentDiscount decimal (2,2),
  WorkOrderID int references WorkOrder not null
);

CREATE TABLE Compound (
  LTNumber char(6) Primary Key,
  Name varchar(50),
  MolecularMass decimal(4,6)
);

CREATE TABLE CompoundSample (
  CompoundSampleID int default next value for NWLID
  Sequence Primary Key,
  CompoundSequenceCode int,
  QtyInMilligrams int
  DateArrived Date,
  DateDue Date,
  Appearance varchar(1000),
  ClaimedWeight decimal(4,6),
  ActualWeight decimal(4,6),
  MaximumToleratedDose decimal(4,6)
  LTNumber char references Compound not null,
  WorkOrderID int references WorkOrder not null,
  EmployeeID int references Employee not null
);

CREATE TABLE Assay (
  AssayID int default next value for NWLID Sequence Primary Key,
  Name varchar(150),
  Protocol varchar(3000),
  DaysToCompletion int
);

CREATE TABLE Test (
  TestID int default next value for NWLID Sequence Primary Key,
  Name varchar(50),
  Concentration decimal(4,6)
);

CREATE TABLE ConditionalTest (
  ConditionalTestID int references Test(TestID) Primary Key
);

CREATE TABLE RequiredTest (
  RequiredTestID int references Test(TestID) Primary Key
);

CREATE TABLE OptionalTest (
  TriggerCondition varchar(3000),
  ConditionalTestID int references ConditionalTest not null,
  RequiredTestID int references RequiredTest not null,
  Constraint OptionalTest_PK Primary Key(ConditionalTestID, RequiredTestID)
);

CREATE TABLE AssayTest (
  AssayID int references Assay not null,
  TestID int references Test not null,
  Constraint AssayTest_PK Primary Key(AssayID, TestID)
);

CREATE TABLE LiteratureReference (
  ReferenceID int default next NWLID Sequence Primary Key,
  Name varchar(50),
  Notes varchar(50)
  AssayID int references Assay not null
);

CREATE TABLE Material (
  MaterialID int default next NWLID Sequence Primary Key,
  Name varchar(200),
  Cost decimal(4,2)
);

CREATE TABLE TestMaterial (
  Quantity decimal(4,2),
  TestID int references Test not null,
  MaterialID int references Material not null,
  Constraint TestMaterial_PK Primary Key(TestID, MaterialID)
);

CREATE TABLE SampleTest (
  Hours decimal(3,2),
  CompoundSampleID int references CompoundSample not null,
  TestID int references Test not null,
  EmployeeID int references Employee not null,
  Constraint SampleTest_PK Primary Key(CompoundSampleID, TestID)
);

CREATE TABLE AssayResult (
  AssayResultID int default next NWLID Sequence Primary Key,
  AssayID int references Assay not null
);

CREATE TABLE TestResult (
  TestResultID int default next MWLID Sequence Primary Key,
  TestID int references Test not null,
  AssayResultID int references AssayResult not null
);

CREATE TABLE File (
  FileID int default next NWLID Sequence Primary Key,
  FileURL varchar(150),
  TestResultID int references TestResult not null
);

CREATE TABLE QualitativeResultFile (
  QualitativeResultFileID int references File(FileID) Primary Key
);

CREATE TABLE QuantitativeResultFile (
  QuantitativeResultFileID int references File(FileID) Primary Key
);

CREATE TABLE Report (
  ReportID int references File(FileID) Primary Key,
  WorkOrderID int references WorkOrder not null
);
