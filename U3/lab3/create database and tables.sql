CREATE DATABASE HumanResources;

--DROP TABLE dbo.EmployeesExternal;

CREATE TABLE dbo.EmployeesExternal
(EmployeeID INT PRIMARY KEY,
 FirstName NVARCHAR(50) NOT NULL,
 LastName NVARCHAR(50) NOT NULL, 
 JobTitle NVARCHAR(50) NOT NULL, 
 EmailAddress NVARCHAR(50) NULL, 
 City NVARCHAR(50) NOT NULL, 
 StateProvinceName NVARCHAR(50) NOT NULL, 
 CountryRegionName NVARCHAR(50) NOT NULL);

--DROP TABLE dbo.EmployeesAW;

CREATE TABLE dbo.EmployeesAW
(BusinessEntityID INT PRIMARY KEY,
 FirstName NVARCHAR(50) NOT NULL,
 LastName NVARCHAR(50) NOT NULL,
 JobTitle NVARCHAR(50) NULL);

--DROP TABLE dbo.EmailAddressesAW;

CREATE TABLE dbo.EmailAddressesAW
(EmailAddressId INT PRIMARY KEY, 
 BusinessEntityID INT NOT NULL,
 EmailAddress NVARCHAR(50) NOT NULL);

