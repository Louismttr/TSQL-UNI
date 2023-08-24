CREATE DATABASE Netflix

Use Netflix

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

CREATE TABLE Peliculas(
Identi_Pe INT PRIMARY KEY NOT NULL,
Resumen_Pe text NOT NULL,
FE_Pe DateTime NOT NULL,
PaisO_Pe nvarchar(5) FOREIGN  KEY REFERENCES PaisOrigen(Codigo_Pa) NOT NULL,
TGe_Pe varchar(15) FOREIGN  KEY REFERENCES Genero(ID_Ge) NOT NULL,
URL_Pe varchar,
Duracion nvarchar(8)
)