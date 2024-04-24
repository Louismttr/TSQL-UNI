--INOVICE SUMMARRY MONTH AT MONTH

CREATE TABLE SummaryInovice(
 OrderID int primary key,
 CustomerName nvarchar(130) NOT NULL,
 Vendor NVARCHAR(150) NOT NULL,
 OrderDate DATETIME NOT NULL,
 Total DECIMAL
)
go
--- Order Invoice
--- SI no se envia es el asistene en "alerta"
create PROCEDURE sp_SummaryMensual
as
	INSERT INTO SummaryInovice
	SELECT 
		o.OrderID, c.CompanyName as CustomerName, e.FirstName+' '+e.LastName as Vendedor, o.OrderDate,
		ROUND(SUM(od.UnitPrice*od.Quantity*(1-od.Discount)), 2) as Total
	FROM
		Employees as e INNER JOIN Customers as c INNER JOIN Orders as o INNER JOIN [Order Details] as od
		ON o.OrderID=od.OrderID
		ON c.CustomerID=o.CustomerID
		ON e.EmployeeID = o.EmployeeID
	GROUP BY o.OrderID, c.CompanyName, e.FirstName, e.LastName, o.OrderDate
	Having
		YEAR(o.OrderDate)=YEAR(getDate())
		and
		MONTH(o.OrderDate)=MONTH(getDate())
	Order by o.OrderID asc
GO

Update Orders set OrderDate = DATEADD(YEAR, 27, ORDERDATE)
