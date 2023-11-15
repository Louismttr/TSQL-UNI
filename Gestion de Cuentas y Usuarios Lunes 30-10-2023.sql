create database SFCIFX

restore database SFCIFX from disk='D:\ECEA\Regular\BD I\2M2-IS\SFCIFX.bak'
with replace

------------------------------------------------------
------    Gestion de Usuarios ------------------------
------------------------------------------------------

-- I.- Crear Cuentas y Usuarios
-- 1.1.- Administrador
sp_addlogin 'AZuniga','ZunigaE2023*','SFCIFX'
sp_addsrvrolemember 'AZuniga','sysadmin'
use SFCIFX
sp_adduser 'AZuniga','LicZ'
sp_addrolemember 'db_ddladmin','LicZ'

--1.2.- Solo lectura
sp_addlogin 'Vendedor','Sales2/','SFCIFX'
sp_addsrvrolemember 'Vendedor','processadmin'
use SFCIFX
sp_adduser 'Vendedor','Vendedor'
sp_addrolemember 'db_denydatawriter','Vendedor'
sp_addrolemember 'db_datareader','Vendedor'

revoke create table, create view, create procedure to
Vendedor

deny insert, delete, update on Clientes to Vendedor
deny insert, delete, update on Compras to Vendedor

-- 1.3.- Solo Escritura
sp_addlogin 'Cajero','Caja2023!','SFCIFX'
sp_addsrvrolemember 'Cajero','processadmin'
use SFCIFX
sp_adduser 'Cajero','Cashier'
sp_addrolemember 'db_denydatareader','Cashier'
sp_addrolemember 'db_datawriter','Cashier'

revoke create table, create view, create procedure to
Cashier

deny select on Clientes to Cashier
deny select on Compras to Cashier

select * from Clientes

-- 1.4.- L/E
sp_addlogin 'Supervisor','Caja2023!','SFCIFX'
sp_addsrvrolemember 'Supervisor','processadmin'
use SFCIFX
sp_adduser 'Supervisor','Supervisor'
sp_addrolemember 'db_datareader','Supervisor'
sp_addrolemember 'db_datawriter','Supervisor'

revoke create table, create view, create procedure to
Supervisor