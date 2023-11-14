create database Cifrado 
use Cifrado

create table Usuarios(
IdUsuario int identity(1,1) primary key not null,
NombreUsuario nvarchar(50) not null,
Contraseña nvarchar(50)
)
insert into Usuarios Values('LuisaTellez', 'Luisa876590')
select * from Usuarios


create procedure NuevoUsuario(
@NU nvarchar(50),
@C nvarchar(50)
as 
insert into Usuarios values (@NU,encryptbypassphrase('C1traseña', @C)
)

select * from Usuarios
--cesar, cesar con clave, playfair, playfair con clave

create table UsuarioCur(
id 
)