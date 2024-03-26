create database Hospital

Use Hospital

create table Poblacion(
IdPoblacion char(8) primary key not null,
NombrePoblacion nvarchar(25) not null,
CantPobla int not null	
)

create table Provincia(
IdProvincia char(8) primary key not null,
Cantpobla int not null,
IdPoblacion char(8) Foreign key references Poblacion(IdPoblacion) not null
)

create table Especialidades(
IdEspecialidades char(8) primary key not null,
NombreEsp nvarchar(30) not null,
DescEsp nvarchar(50) not null
)

create table Medicos(
CodMedico char(8) primary key not null,
DirM nvarchar(50) not null,
Cedula char(16) not null,
TelMedico char(8) check(TelMedico like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
PNMedico nvarchar(15) not null,
PAMedico nvarchar(15),
SNMedico nvarchar(15) not null,
SAMedico nvarchar(15),
IdEspecialidades char(8) Foreign key references Especialidades(IdEspecialidades) not null
)

create table Camas(
IdCamas char(5) primary key not null,
NCamas int not null,
DescCama nvarchar(25) not null
)

create table Habitaciones(
IdHabit char(5) primary key not null,
NHabit int not null,
TipoHab nvarchar(25) not null,
IdCamas char(5) Foreign key references Camas(IdCamas) not null
)

create table AreasClinicas(
IdAC char(5) primary key not null,
DescArea nvarchar(50) not null,
NombreArea nvarchar(20) not null,
IdCamas char(5) Foreign key references Camas(IdCamas) not null,
IdHabit char(5) Foreign key references Habitaciones(IdHabit) not null
)

create table Ingresos()

create table Pacientes(

)

create table PacienteIngreso()

create table Egresos()