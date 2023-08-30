CREATE DATABASE Cine_3LE

Use Cine_3LE

CREATE TABLE PaisOrigen(
Codigo_Pa nvarchar(5) Primary Key,
Nombre_Pa nvarchar(30),
Conti_Pa nvarchar(10)
)

CREATE TABLE Genero(
ID_Ge varchar(15) PRIMARY KEY,
Nom_Ge nvarchar(20),
Tipo_Ge nvarchar(20),
)

CREATE TABLE Idioma(
ID_Ido varchar(10) PRIMARY KEY,
Nombre_Ido nvarchar(15),
PaisO_Ido nvarchar(5) FOREIGN  KEY REFERENCES PaisOrigen(Codigo_Pa) NOT NULL,
)

CREATE TABLE Calificacion(
Id_Ca varchar PRIMARY KEY NOT NULL,
Tipo_Ca nvarchar CHECK(Tipo_Ca like '[Obra Maestra|Muy buena|Buena| Regular|Mala]'),
OpinioPe_Ca text,
PuntuAcep_Ca int,
puntuaGe_Ca int
)
---Intentando crear una RULER :c
CREATE RULE RG_Calificacion
AS   
@PuntuAcep_Ca>= 9 AND @PuntuAcep_Ca >18;

EXEC SP_BINDRULE RG_Calificacion, 'Calificacion.PuntuAcep_Ca'

CREATE TABLE Sala(
Numero_S nvarchar(10) PRIMARY KEY NOT NULL,
NombreS varchar(6),
DirrecionS varchar,
TelS CHAR(8) CHECK (TelS LIKE '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
CapacidadS int
)

Create Table Promocion(
Id_Promocion nvarchar(10) PRIMARY KEY NOT NULL,
Descuento float,
Descripcion text
)

CREATE TABLE Funcion(
Id_Promocion nvarchar(10) PRIMARY KEY NOT NULL,
Duracion nvarchar(8),
HoraI Time,
Salas nvarchar(10) FOREIGN  KEY REFERENCES Sala(Numero_S) NOT NULL,
Promocion nvarchar(10) FOREIGN  KEY REFERENCES Promocion(Id_Promocion) NOT NULL,
)

CREATE TABLE Pers_At(
DNI_Pr nvarchar(10) PRIMARY KEY NOT NULL,
PNP nvarchar(10),
SNP nvarchar(10),
PAP nvarchar(10),
SAP nvarchar(10),
EdadP int,
SexoC CHAR(1) CHECK(SexoC LIKE '[F|M|f|m]') NOT NULL,
NacionP nvarchar(15),
CantP INT,
CargoP nvarchar(10)
)

CREATE TABLE Participantes(
ED_Par nvarchar(10) PRIMARY KEY NOT NULL,
Participantes nvarchar(10) FOREIGN  KEY REFERENCES Pers_At(DNI_Pr) NOT NULL,
)

CREATE TABLE Opinion(
Num_Op int Primary key NOT NULL,
Redactor nvarchar(10),
EdadOP int,
SexoOP CHAR(1) CHECK(SexoOP LIKE '[F|M|f|m]') NOT NULL,
FechaOP Time,
CalifiacionOP nvarchar CHECK(CalifiacionOP LIKE '[Obra Maestra|Muy buena|Buena| Regular|Mala]') NOT NULL
)

CREATE TABLE Peliculas(
Identi_Pe INT PRIMARY KEY NOT NULL,
Resumen_Pe text NOT NULL,
FE_Pe DateTime NOT NULL,
PaisO_Pe nvarchar(5) FOREIGN  KEY REFERENCES PaisOrigen(Codigo_Pa) NOT NULL,
TGe_Pe varchar(15) FOREIGN  KEY REFERENCES Genero(ID_Ge) NOT NULL,
URL_Pe varchar,
Duracion nvarchar(8),
AñoP_Pe Date,
IdiomaO_Pe varchar(10) FOREIGN  KEY REFERENCES Idioma(ID_Ido) NOT NULL,
TituloD_Pe nvarchar(10),
TituloO_Pe nvarchar(10),
Calificacion_Pe varchar FOREIGN  KEY REFERENCES Calificacion(Id_Ca) NOT NULL,
Subtitu_Pe varchar(2) check(Subtitu_Pe like '[Si|No]'),
Participantes nvarchar(10) FOREIGN  KEY REFERENCES Participantes(ED_Par) NOT NULL,
)
