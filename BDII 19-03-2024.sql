CREATE DATABASE Universidad
GO
USE Universidad
GO

USE master

DROP DATABASE Universidad

BACKUP DATABASE Universidad
TO DISK = 'D:\Backup DB\Universidad.bak'
WITH 
NAME = 'Respaldo Full',
DESCRIPTION = '19 - 03 - 2024'

RESTORE DATABASE Universidad
FROM DISK = 'D:\Backup DB\Universidad.bak'
WITH
MOVE 'Universidad' TO 'D:\Restore DB\MDF\Universidad.mdf',
MOVE 'Universidad_log' TO 'D:\Restore DB\LDF\Universidad_log.ldf'

CREATE TABLE Estudents(
Id_Est INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
PNE NVARCHAR(15) NOT NULL,
)

----------------------------------------------------------------------

-- 20/03/2024

CREATE DATABASE MiEmpresa
GO
USE MiEmpresa
GO
CREATE TABLE Client(
Id_C INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
NomC NVARCHAR(25) NOT NULL
)

INSERT INTO Client VALUES('Ana'),('Pedro'),('Juan')

SELECT * FROM Client

---------------------------------------------
-- BACKUP FULL DE BD

BACKUP DATABASE MiEmpresa
TO DISK = 'D:\Backup DB\MiEmpresa.bak'
WITH 
NAME = 'Respaldo Full',
DESCRIPTION = '20 - 03 - 2024'

-- VISUALIZAR INFORMACIÓN DEL RESPALDO

RESTORE HEADERONLY FROM DISK = 'D:\Backup DB\MiEmpresa.bak'

-- BACKUP COMPRIMIDO

BACKUP DATABASE MiEmpresa
TO DISK = 'D:\Backup DB\MiEmpresaC.bak'
WITH
NAME = 'Respaldo Full',
DESCRIPTION = '20 - 03 - 2024',
COMPRESSION

-- BACKUP DIFERENCIAL

INSERT INTO Client VALUES('Nestor'),('Davis')

BACKUP DATABASE MiEmpresa
TO DISK = 'D:\Backup DB\MiEmpresa.bak'
WITH
NAME = 'Respaldo Diff',
DESCRIPTION = '20 - 03 - 2024',
DIFFERENTIAL

-- BACKUP FULL

BACKUP DATABASE MiEmpresa
TO DISK = 'D:\Backup DB\MiEmpresa.bak'

USE master

DROP DATABASE MiEmpresa

-- RESOTORE DATABASE

RESTORE DATABASE MiEmpresa
FROM DISK = 'D:\Backup DB\MiEmpresa.bak'
WITH
MOVE 'MiEmpresa' TO 'D:\Restore DB\MDF\MiEmpresa.mdf',
MOVE 'MiEmpresa_log' TO 'D:\Restore DB\LDF\MiEmpresa_log.ldf',
FILE = 1,
RECOVERY

---------------------------------------------

-- 02 - 04 - 2024

-- Agregar respaldos a dispositivos virtuales

sp_addumpdevice 'disk','Respaldo_Universidad','D:\Backup DB\Universidad.bak'

BACKUP DATABASE Universidad
TO Respaldo_Universidad
WITH 
NAME = 'Respaldo Full',
DESCRIPTION = '19 - 03 - 2024'

------------------------------------------------

-- 03 - 04 - 2024

RESTORE HEADERONLY FROM DISK = 'C:\Users\ismaa\OneDrive\Escritorio\BDII\Northwind.bak'

RESTORE FILELISTONLY FROM DISK = 'C:\Users\ismaa\OneDrive\Escritorio\BDII\Northwind.bak'

RESTORE DATABASE Northwind
FROM DISK = 'C:\Users\ismaa\OneDrive\Escritorio\BDII\Northwind.bak'
WITH
MOVE 'Northwind' TO 'D:\Restore DB\MDF\Northwind.mdf',
MOVE 'ExtensiónNorthwind2021' TO 'D:\Restore DB\MDF\ExtensiónNorthwind2021.mdf',
MOVE 'Northwind_log' TO 'D:\Restore DB\LDF\Northwind_log.ldf'

-- HACIENDO SELECCION ENTRE DOS BASE DE DATOS 

SELECT
p.ProductID,
p.ProductName,
p.UnitsInStock AS Invetory,
p.UnitPrice
FROM
Northwind.dbo.Products p

UNION ALL

SELECT ap.ProductID, NULL, ap.ListPrice, NULL
FROM AdventureWorks2019.Production.Product ap

RESTORE FILELISTONLY FROM DISK = 'C:\Users\ismaa\OneDrive\Escritorio\BDII\AdventureWorks2019.bak'

DROP DATABASE AdventureWorks2019

RESTORE DATABASE AdventureWorks2019
FROM DISK = 'C:\Users\ismaa\OneDrive\Escritorio\BDII\AdventureWorks2019.bak'
WITH
MOVE 'AdventureWorks2017' TO 'D:\Restore DB\MDF\AdventureWorks2017.mdf',
MOVE 'AdventureWorks2017_log' TO 'D:\Restore DB\MDF\AdventureWorks2017_log.ldf'

CREATE DATABASE Reportes
GO
USE Reportes
GO
-- REPORTE GENERAL DE VETAS PARA UN MES

CREATE TABLE Resumen_Ventas(
Id_RV INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
FechV DATE,
AÑO INT,
MES VARCHAR(25),
Empres VARCHAR(80),
SubT FLOAT,
Impuestos FLOAT,
Total FLOAT
)
GO

USE AdventureWorks2019
GO
SELECT * FROM Sales.SalesOrderHeader

UPDATE Sales.SalesOrderHeader SET OrderDate = '2024/03/10'
WHERE YEAR(OrderDate) = 2011 AND MONTH(OrderDate) = 5

CREATE PROCEDURE Resumen_Ventas_Adventure
AS
DECLARE @Año INT, @Mes INT
DECLARE @Fecha DATETIME
DECLARE @SubTotal FLOAT, @Impuestos FLOAT, @Total FLOAT

SET @Año = YEAR(DATEADD(MONTH, -1,GETDATE()))
SET @Mes = MONTH(DATEADD(MONTH, -1,GETDATE()))

SET @SubTotal = (SELECT SUM(subTotal) FROM sales.SalesOrderHeader WHERE 
				 YEAR(OrderDate) = YEAR(DATEADD(MONTH, -1,GETDATE())) AND
				 MONTH(OrderDate) = MONTH(DATEADD(MONTH, -1,GETDATE()))
				)

SET @Impuestos = (SELECT SUM(TaxAmt + Freight) FROM sales.SalesOrderHeader WHERE 
				 YEAR(OrderDate) = YEAR(DATEADD(MONTH, -1,GETDATE())) AND
				 MONTH(OrderDate) = MONTH(DATEADD(MONTH, -1,GETDATE()))
				)

		INSERT INTO Reportes.dbo.Resumen_Ventas VALUES (GETDATE(),@Año,@Mes,'AdventureWorks',@SubTotal,@Impuestos,(@SubTotal + @Impuestos))

Resumen_Ventas_Adventure

SELECT * FROM Resumen_Ventas

-- CREAR REPORTE DE VENTAS DE NORTHWIND LAS DEL 10 TRANSFORMAR A 3 DEL 2024

USE Northwind
GO
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT SUM(o.Freight +(([Order Details].UnitPrice* [Order Details].Quantity)*(1-[Order Details].Discount))) FROM Orders o INNER JOIN  [Northwind].[dbo].[Order Details] ON o.OrderID = [Order Details].OrderID WHERE YEAR(o.OrderDate) = 1996 AND MONTH(o.OrderDate) = 10


