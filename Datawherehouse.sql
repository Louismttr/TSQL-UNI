create database AdventureWorks2012
on (filename='F:\AdventureWorks2012_Data.mdf'),
(filename='F:\AdventureWorks2012_log.ldf')
for attach

use AdventureWorks

create database DW_AW2012

Use DW_AW2012

create table Productos(
Id_Producto char(4) primary key not null
,Nproducto nvarchar(60) not null
,MarcaP nvarchar(30) not null
,PrecioP money not null
)
alter table Productos add Existp int not null
alter table Productos drop column Existp

Create table Clientes(
Id_Cliente int identity(1,1) primary key not null
,NCiente nvarchar(60) not null
,Dir nvarchar(30)
,TelC char(8) check(TelC like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

Create table Region(
Id_Region char(4) primary key not null
,NombreRegion nvarchar(60) not null
)

Create table Empleados(
Id_Empleado char(4) primary key not null
,NEmpleado nvarchar(60) not null
,Cedula char(16) not null
,sexo char(1) check(sexo like '[F|M|f|m]')
,DirEmpleado nvarchar(60) not null
,TelE char(8) check(TelE like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

Create table H_Info(
Id_Info int identity(1,1) primary key not null
,Id_Producto char(4) foreign key references Productos(Id_Producto) not null
,Id_Cliente int foreign key references Clientes(Id_Cliente) not null
,Id_Region char(4) foreign key references Region(Id_Region) not null
,Id_Empleado char(4) foreign key references Empleados(Id_Empleado) not null
,CantOrdenes int not null
,Total money not null
,mes char(12) not null
,año int not null
)

sp_addlogin 'Luisa','IL18','DW_AW2012'
sp_addsrvrolemember 'Luisa','sysadmin'

use DW_AW2012

sp_adduser 'Luisa','IL'
sp_addrolemember 'db_ddladmin','IL'