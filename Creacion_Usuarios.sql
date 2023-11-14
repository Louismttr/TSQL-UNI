--Clase 30-10-23
-- BD usuarios:
-- 1.- Propietarios
-- 2.- Administrador
-- 3.- Comunes (3): Ninguno de estos 3 puede ver la estructura de la BD
-- Solo manipulan REGISTROS
--  3.1.- Solo lectura (Select)
--  3.2.- Solo escritura (Insert, update)
--  3.3.- L/E (Select, insert, update)

--- Crear cuentas
--- .-sp_addlogin-- argumentos:
--- 1. Nombre cuenta, 2. Contraseña, 3. Bd default, 4. Idioma server, 5. Nivel de cifrado server, 6. Id server

--- Roles de servidor
--- sp_addsvrdemember:
--- sysadmin, serveradmin, bulkadmin, procesoadmin
--- diskadmin, setupadmin, securityadmin, dbcreator

--- Privilegios
--- sp_adduser
--- Nombre y nombre Usuario
--- sp_adddemember
--- db_addadmin, db_ denydater
---- chuta :D


Create database SFCIFX

---- Gestion de usuarios ----
----------------------------------

-- I.- Crear Cuentas
-- 1.1.- Administrador

sp_addlogin 'AZuniga', 'ZunigaE2023*', 'SFCIFX'
sp_addsrvrolemember 'AZuniga', 'sysadmin'

use SFCIFX

sp_adduser 'AZuniga', 'Licz'
sp_addrolemember 'db_ddladmin', 'Licz'

-- 1.2.- Solo lectura
sp_addlogin 'Vendedor', 'Sales2/','SFCIFX'
sp_addsrvrolemember 'Vendedor', 'Processadmin'

use SFCIFX

sp_adduser 'Vendedor', 'Vendedor'
sp_addrolemember 'db_denydatawriter', 'Vendedor'
sp_addrolemember 'db_denydatareader', 'Vendedor'

revoke create table, create view, create procedure to
Vendedor

deny insert, delete, update on Clientes to Vendedor
deny insert, delete, update on Compras to Vendedor

--- 1.3.- Solo escritura
sp_addlogin 'Cajero', 'Caja2023!', 'SFCIFX'
sp_addsrvrolemember 'Cajero', 'processadmin'

use SFCIFX

sp_adduser 'Cajero', 'Cashier'
sp_addrolemember 'db_denydatawriter', 'Cashier'
sp_addrolemember 'db_denydatareader', 'Cashier'

revoke create table, create view, create procedure to
Cashier

deny select on Clientes to Cashier
deny select on Compras to Cashier

--- 1.4.- L/E
sp_addlogin 'Supervisor', 'Caja2023!', 'SFCIFX'
sp_addsrvrolemember 'Supervisor', 'processadmin'

use SFCIFX

sp_adduser 'Supervisor', 'Supervisor'
sp_addrolemember 'db_denydatareader', 'Supervisor'
sp_addrolemember 'db_denydatawriter', 'Supervisor'

revoke create table, create view, create procedure to
Supervisor
