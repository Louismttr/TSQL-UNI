-- Crear BD Blanco
create database SFCIFX

--Abrir la BD
use SFCIFX

-- Creacion de tablas
create table Clientes(
CodCliente char(4) primary key not null,
DirC nvarchar(50) not null,
TelC char(8) check(TelC like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
)

create table ClienteNat(
IdCN int identity(1,1) primary key not null,
PNCN nvarchar(15) not null,
SNCN nvarchar(15),
PACN nvarchar(15) not null,
SACN nvarchar(15),
MailCN nvarchar(35),
CodCliente char(4) foreign key references Clientes(CodCliente) not null
)

create table ClienteJur(
IdCJ char(11) primary key not null,
NombreCJ nvarchar(50) not null,
FechaConst date not null,
RepLegal nvarchar(50) not null,
URLCJ nvarchar(50),
CodCliente char(4) foreign key references Clientes(CodCliente) not null
)

backup database SFCIFX to disk='D:\SFCIFX.bak'

-- Miercoles 09-08-2023
-- Para restaurar la BD
-- create database SFCIFX
-- solamente si no existe

-- Restauración de Base de Datos
--restore database SFCIFX from disk='D:\SFCIFX.bak'
--with replace

use SFCIFX

create table Proveedor(
IdProv char(5) primary key not null,
NombreProv nvarchar(45) not null,
DirProv nvarchar(70) not null,
TelProv char(8) check(TelProv like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
URLProv nvarchar(45)
)

create table VisitadorM(
IdVM int identity(1,1) primary key not null,
PNVM nvarchar(15) not null,
SNVM nvarchar(15),
PAVM nvarchar(15) not null,
SAVM nvarchar(15),
DirVM nvarchar(70) not null,
TelVM char(8) check (TelVM like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
MailVM nvarchar(35),
IdProv char(5) foreign key references Proveedor(IdProv) not null
)
-- Eliminar columna error
--alter table VisitadorM drop column MailCN
-- Añadir columna correcta
--alter table VisitadorM add MailVM nvarchar(35)

create table Productos(
CodProd int identity(1,1) primary key not null,
NombreProd nvarchar(45) not null,
DescProd nvarchar(70) not null,
Preciop float not null,
Existp int not null,
IdProv char(5) foreign key references Proveedor(IdProv) not null
)

-- Reglas del Precio y Existencias de Productos
create rule EntP
as
@P>0

sp_bindrule 'EntP', 'Productos.Preciop'

create rule Ent
as
@E>=0

sp_bindrule 'Ent', 'Productos.Existp'

-- alter table Productos alter column Existp float

create table PGen(
CPG char(4) primary key not null,
FElab datetime not null,
FVenc datetime,
Present nvarchar(45) not null,
CodProd int foreign key references Productos(CodProd) not null
)

create table PNGen(
CPNG char(4) primary key not null,
CatPNG nvarchar(50),
PPNG char(1) check(PPNG like '[S|M|L]'),
CodProd int foreign key references Productos(CodProd) not null
)

create table Ventas(
IdVenta int identity(1,1) primary key not null,
FechaV datetime default getdate() not null,
CodCliente char(4) foreign key references Clientes(CodCliente) not null,
TotalV float
)

sp_bindrule 'Ent', 'Ventas.TotalV'

create table DetVentas(
IdVenta int foreign key references Ventas(IdVenta) not null,
CodProd int foreign key references Productos(CodProd) not null,
cantv int not null,
subtp float,
primary key(IdVenta, CodProd)
)

sp_bindrule 'EntP', 'DetVentas.cantv'

sp_bindrule 'Ent', 'DetVentas.subtp'

create table VentasCont(
IdVentaC int identity(1,1) primary key not null,
DesuC float,
PProm nvarchar(45),
IdVenta int foreign key references Ventas(IdVenta) not null
)

create table VentasCred(
IdVentaCred int identity(1,1) primary key not null,
FVenc date,
Fpago date,
Inter float,
IdVenta int foreign key references Ventas(IdVenta) not null
)

create table Compras(
FCompra char(5) primary key not null,
FechaCompra date not null,
IdProv char(5) foreign key references Proveedor(IdProv) not null,
TotalC float
)

create table DetCompras(
FCompra char(5) foreign key references Compras(FCompra) not null,
CodProd int foreign key references Productos(CodProd) not null,
cantc int not null,
precioc float not null,
subtpc float,
primary key(FCompra, CodProd)
)

-- \\10.9.17.95