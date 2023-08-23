Create database Hospital
use Hospital

Create TABLE Poblacion(
Cod_Po int primary key not null,
Nombre_Po nvarchar(50) not null,
Cantidad_Po int not null,
Zona_Po nvarchar(10) not null,
Condiciones_Trabajo nvarchar(50) not null,
Cod_Pro int foreign key references Provincia(Cod_Pro) not null
)

CREATE TABLE Provincia(
Cod_Pro int primary key not null,
Nombre_Pro nvarchar(50) not null,
Cantidad_Pro int not null,
)

CREATE TABLE Medicos(
Cod_Me int primary key not null,
P_Nombre_Me nvarchar(50) not null,
S_Nombre_Me nvarchar(50),
P_Apellido_Me nvarchar(50) not null,
S_Apellido_Me nvarchar(50),
Cod_Es int foreign  key references Especialidad(Cod_Es),
Dirrecion nvarchar(80) not null,
TelVM char(8) check(TelVM like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Cod_Po int foreign  key references Poblacion(Cod_Po),
Cod_Pro int foreign  key references Provincia(Cod_Pro)
)

CREATE TABLE Especialidad(
Cod_Es int primary key not null,
Nombre_Es nvarchar(70),
Descripcion_Es nvarchar(150)
)

CREATE TABLE Paciente(
Cod_Pa int primary key not null,
P_Nombre_Pa nvarchar(50) not null,
S_Nombre_Pa nvarchar(50),
P_Apellido_Pa nvarchar(50) not null,
S_Apellido_Pa nvarchar(50),
TelP char(8) check(TelP like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
Codigo_Postal_Pa int,
Dirrecion nvarchar(80),
Cod_Po int foreign  key references Poblacion(Cod_Po),
Cod_Pro int foreign  key references Provincia(Cod_Pro)
)

