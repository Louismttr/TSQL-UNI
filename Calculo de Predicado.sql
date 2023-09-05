create database SFCIFX

select @@VERSION as VersionSQL,
@@LANGUAGE as IdiomaSQL

restore database SFCIFX from disk='C:\Users\luisa\OneDrive\Escritorio\UNI\2 año\IV semestre\Base de datos I\Calculo de predicado\SFCIFX.bak'
with replace

use SFCIFX

select * from Proveedor

insert into Proveedor values('00001','DICEGSA',
'Carretera vieja Leon','22784514','www.dicegsa.com.ni'),
('00002','Laboratorios Ramos','Carretera Norte',
'87542154','www.lramos.com.ni')

select * from Productos

insert into Productos values('Covazar','Presion arterial',
25,30,'00001'),('Alka Seltzer','Problemas digestivos',
8,150,'00001'),('Acetaminofen','Temperatura',5,50,'00002')

Select * from Productos
-----------------------------
-- Diseño de la Consulta
-- I.- Algebra Relacional
-- I.1.- Operaciones Conjuntistas (Union, Interseccion, Diferencia y Producto Cartesiano)
-- I.2.- Operaciones Relacionales (Proyeccion, Seleccion, Reunion Theta, Reunion Natural, Equireunion, Division)

-- I.1.1.- UNION
-- A: Proveedor B: Productos AUB

-- Implementacion como consulta
select NombreProv, DirProv, TelProv, URLProv, CodProd,
NombreProd, DescProd, Preciop, ExistP from Proveedor
inner join Productos on Proveedor.IdProv=Productos.IdProv

-- Implementación como vista
Create view EjUnion as
select NombreProv, DirProv, TelProv, URLProv, CodProd,
NombreProd, DescProd, Preciop, ExistP from Proveedor
inner join Productos on Proveedor.IdProv=Productos.IdProv

-- I.2.1.- Proyeccion
-- A: Productos π<NombreProd, Preciop>(Productos)

-- Implementacion como consulta
select NombreProd, PrecioP from Productos

-- Implementacion como vista
create view EjProy as
select NombreProd, PrecioP from Productos

select * from EjProy

-- I2.2. Seleccion
-- A: Productos σ<Preciop>=8 and Preciop8=30>(Productos)

-- Implementacion como consulta
select * from Productos where Preciop between 8 and 30

-- Implementacion como vista
create view EjSel as
select * from Productos where Preciop between 8 and 30

select * from EjSel

-- Reunion Theta
-- A: Proveedor B: Productos
-- A θ B
-- Implementación de consulta
select NombreProv,
NombreProd, Preciop,
existp from Proveedor inner join
Productos on
Proveedor.IdProv=Productos.IdProv

-- Implementacion del objeto vista
create view EjRT as
select NombreProv,
NombreProd, Preciop,
existp from Proveedor inner join
Productos on
Proveedor.IdProv=Productos.IdProv

select * from EjRT
--Reunion Theta
--A: Proveedor B: Productos
--A o B
--Implementacion de la consulta
Create view EJTR as 
Select NombreProv,
NombreProd, Preciop,
ExistP from Proveedor inner join
Productos on 
Proveedor.IdProv=Productos.IdProv

--Reunion Natural
-- Implementacion de consulta
select NombreProv,
NombreProd, Preciop,
existp from Proveedor inner join
Productos on
Proveedor.IdProv=Productos.IdProv
where preciop>15

-- Implementacion del objeto vista
create view EjRN as
select NombreProv,
NombreProd, Preciop,
existp from Proveedor inner join
Productos on
Proveedor.IdProv=Productos.IdProv
where preciop>15

select * from EjRN

-- Equireunion
-- Implementacion de consulta
select * from Productos where
NombreProd='Covazar'

-- Implementacion del objeto vista
create view EjER as
select * from Productos where
NombreProd='Covazar'

select * from EjER
-------

-- II.- Calculo de Predicado
-- II.1.- Calculo de Predicado de tuplas
-- EJEMPLO: Los Productos cuyo precio 
-- es mayor a 15, lo podemos 
-- escribir de la manera siguiente:
-- {p | Productos(p)  and  p.preciop > 15}

-- Implementacion como consulta
select * from Productos
where Preciop>15

select NombreProd, DescProd, preciop from Productos
where preciop>15

-- Implementacion como vista
create view PM15 as select * from Productos
where preciop>15

select * from PM15

-- equivalente en algebra (Operacion Relacional)
-- Tipo de Operacion: Seleccion.
-- σ<preciop>15>(Productos)

-- II.2.- Calculo de Predicado de dominio
-- La obtención el Nombre del Producto y 
-- su correspondiente descripcion de aquel producto 
-- cuyo nombre es 
-- “Alka Seltzer” se indica por
--{nd | (Эn)( Эd)( Productos(nd...) and n = Alka Seltzer}

-- Implementacion como consulta
select NombreProd, DescProd from Productos where
NombreProd='Alka Seltzer'

-- Implementacion como vista
create view EjCPD as select NombreProd, DescProd 
from Productos where
NombreProd='Alka Seltzer'

-- Ejercicios
-- 1.- Diseñar e implementar la siguiente consulta
-- a.- Productos x Proveedor cuyo precio oscile 
-- entre 2 y 25
-- Algebra Relacional
-- Tipo de Operacion: Relacional
-- Nombre de Operacion : Reunion Theta
-- A: Proveedor  B: Productos
-- A Ø B
-- Implementando como consulta
select NombreProv, NombreProd, DescProd, Preciop
from Proveedor inner join Productos on Proveedor.IdProv=Productos.IdProv
where Preciop between 2 and 25

-- Implementando como vista
create view Ejerc1 as
select NombreProv, NombreProd, DescProd, Preciop
from Proveedor inner join Productos on Proveedor.IdProv=Productos.IdProv
where Preciop between 2 and 25

select * from Ejerc1

-- b.- Productos genericos cuya FVenc sea superior
-- a la fecha actual
select * from PGen

select * from Productos

select getdate() as FechaHActual

insert into PGen values('0001',getdate(),dateadd(year,1,getdate()),
'Tabletas',1),('0002',getdate(),dateadd(year,1,getdate()),
'Tabletas',2)

-- Algebra Relacional
-- Tipo de Operacion: Relacional
-- Nombre de Operacion : Reunion Theta
-- A: Productos  B: PGen
-- A Ø B
-- Implementando como consulta

select NombreProd, DescProd, Preciop, FElab, FVenc
from Productos inner join PGen on Productos.CodProd=PGen.CodProd
where FVenc>getdate()

-- Implementando como vista
create view Ejerc2 as
select NombreProd, DescProd, Preciop, FElab, FVenc
from Productos inner join PGen on Productos.CodProd=PGen.CodProd
where FVenc>getdate()

select * from Ejerc2

backup database SFCIFX to disk='C:\Users\luisa\OneDrive\Escritorio\UNI\2 año\IV semestre\Base de datos I\Calculo de predicado\SFCIFX.bak'