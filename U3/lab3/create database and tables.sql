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

 SELECT 
    e.[BusinessEntityID] as [EmployeeID]
    ,p.[FirstName]
    ,p.[LastName]
    ,e.[JobTitle]  
    ,ea.[EmailAddress]
    ,a.[City]
    ,sp.[Name] AS [StateProvinceName] 
    ,cr.[Name] AS [CountryRegionName] 
FROM [HumanResources].[Employee] e
  INNER JOIN [Person].[Person] p
  ON p.[BusinessEntityID] = e.[BusinessEntityID]
    INNER JOIN [Person].[BusinessEntityAddress] bea 
    ON bea.[BusinessEntityID] = e.[BusinessEntityID] 
    INNER JOIN [Person].[Address] a 
    ON a.[AddressID] = bea.[AddressID]
    INNER JOIN [Person].[StateProvince] sp 
    ON sp.[StateProvinceID] = a.[StateProvinceID]
    INNER JOIN [Person].[CountryRegion] cr 
    ON cr.[CountryRegionCode] = sp.[CountryRegionCode]
    LEFT OUTER JOIN [Person].[PersonPhone] pp
    ON pp.BusinessEntityID = p.[BusinessEntityID]
    LEFT OUTER JOIN [Person].[PhoneNumberType] pnt
    ON pp.[PhoneNumberTypeID] = pnt.[PhoneNumberTypeID]
    LEFT OUTER JOIN [Person].[EmailAddress] ea
    ON p.[BusinessEntityID] = ea.[BusinessEntityID]
		order by p.[BusinessEntityID] asc;

--DROP TABLE dbo.EmployeesAW;

CREATE TABLE dbo.EmployeesAW
(BusinessEntityID INT PRIMARY KEY,
 FirstName NVARCHAR(50) NOT NULL,
 LastName NVARCHAR(50) NOT NULL,
 JobTitle NVARCHAR(50) NULL);

 select p.[BusinessEntityID],[FirstName],[LastName],[JobTitle]
	from [Person].[Person] p
		inner join [HumanResources].[Employee] e
			on p.BusinessEntityID = e.BusinessEntityID;
		select * from dbo.EmployeesAW

--DROP TABLE dbo.EmailAddressesAW;

CREATE TABLE dbo.EmailAddressesAW
(EmailAddressId INT PRIMARY KEY, 
 BusinessEntityID INT NOT NULL,
 EmailAddress NVARCHAR(50) NOT NULL);

 select [EmailAddressID],p.[BusinessEntityID],[EmailAddress]
	from [Person].[EmailAddress] e
		inner join [Person].[Person] p
			on e.[BusinessEntityID] = p.BusinessEntityID
			where p.[BusinessEntityID] < 291



			truncate table dbo.EmployeesAW;
			truncate table dbo.EmailAddressesAW; 
			truncate table dbo.EmployeesExternal;

			select * from dbo.EmployeesAW;
			select * from dbo.EmailAddressesAW; 
			select * from dbo.EmployeesExternal;