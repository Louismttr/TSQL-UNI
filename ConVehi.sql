create database ConsecionarioVehiculo

use ConsecionarioVehiculo

create table OpcionAdicional(
IdOpcionAd char(5) primary key not null,
NombreOpcionAd nvarchar(25) not null,
DescripOpcionAd nvarchar(50) not null,
PrecioOpcionAd float not null
)

create table MarcaVehiculo(
IdMarcaVehi char(5) primary key not null,
NombreMarcaVehi nvarchar (20) not null,
SedeMarcaVehi nvarchar (56) not null,
DescripMarcaVehi nvarchar(35) not null,
)

create table ModeloVehiculo(
IdModeloVehi char(7) primary key not null,
NombreModeloVehi char(20) not null,
PrecioModeloVehi float not null,
IdOpcionAd char(5) foreign key references OpcionAdicional(IdOpcionAd) not null,
IdMarcaVehi char(5) foreign key references MarcaVehiculo(IdMarcaVehi) not null
) 

create table Vehiculo(
IdVehic char(7) primary key not null,
MatriVehic char(9) not null,
PrecioVehiculo float not null,
IdModeloVehi char(7) foreign key references ModeloVehiculo(IdModeloVehi) not null
)

create table Cliente(
IdCliente char(7) primary key not null,
DNICliente char(8) not null,
PNCliente nvarchar(13) not null,
SNCliente nvarchar(13),
PACliente nvarchar(13) not null,
SACliente nvarchar(13), 
DirCliente nvarchar(65) not null,
TelCliente char(8) check(TelCliente like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null
)

create table Vendedor(
IdVendedor char(7) primary key not null,
DNIVendedor char(8) not null,
PNVendedor nvarchar(13) not null,
SNVendedor nvarchar(13),
PAVendedor nvarchar(13) not null,
SAVendedor nvarchar(13), 
DirVendedor nvarchar(65) not null,
TelVendedor char(8) check(TelVendedor like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null
)

create table VentaVehiculo(
IdVenta char(5) primary key not null,
FechaVenta date not null,
IdVehic char(7) foreign key references Vehiculo(IdVehic) not null,
IdVendedor char(7) foreign key references Vendedor(IdVendedor) not null,
IdCliente char(7) foreign key references Cliente(IdCliente) not null
)

create table CompraVehiculo(
IdCompra char(5) primary key not null,
FechaCompra date not null,
IdVehic char(7) foreign key references Vehiculo(IdVehic) not null,
IdCliente char(7) foreign key references Cliente(IdCliente) not null
)

-- Reglas de precios (Precio de la Opcion Adicional, Precio del Modelo del Vehiculo y Precio del Vehiculo)
create rule EntPOpcionAd
as
@P>0

sp_bindrule 'EntPOpcionAd', 'OpcionAdicional.PrecioOpcionAd'

create rule EntPModeloVehi
as
@Pmv>0

sp_bindrule 'EntPModeloVehi', 'ModeloVehiculo.PrecioModeloVehi'

create rule EntPVehiculo
as
@Prumrum>0

sp_bindrule 'EntPVehiculo', 'Vehiculo.PrecioVehiculo'