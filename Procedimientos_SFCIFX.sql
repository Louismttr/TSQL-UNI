use SFCIFX

-- Procedimientos almacenados
alter table Proveedor add EstadoProv bit default 1

select * from Proveedor

update Proveedor set EstadoProv=1

-- 1.- Inserción
create procedure NuevoProv
@IDP char(5),
@NP nvarchar(45),
@DP nvarchar(70),
@TP char(8),
@URLP nvarchar(45)
as
declare @idprov as char(5)
set @idprov=(select IdProv from Proveedor 
where IdProv=@IDP)
declare @pdt as char(1)
set @pdt=(select substring(@TP,1,1))
if(@IDP='' or @NP='' or @DP='')
begin
	print 'No pueden ser nulos'
end
else
begin
	if(@IDP=@idprov)
	begin
		print 'Proveedor ya registrado'
	end
	else
	begin
		if(@pdt='2' or @pdt='5' or @pdt='7' or @pdt='8')
		begin
			insert into Proveedor values(@IDP,@NP,@DP,
			@TP,@URLP,1)
		end
		else
		begin
			print 'Debe iniciar con 2, 5, 7 u 8'
		end
	end
end

select * from Proveedor

NuevoProv '0003','Rarpe','Managua','22548741','www.rarpe.com.ni'

NuevoProv '00009', 'Nel10','Chinandega','22484523','www.nel10.com.ni'
NuevoProv '00006', 'Boac and Luisa','Boaco','51273429','www.boacandluisa.com.ni'

-- Procedimiento de Dar baja
create procedure DarBProv
@IDP char(5)
as
declare @idprov as char(5)
set @idprov=(select IdProv from Proveedor 
where IdProv=@IDP)
if(@IDP=@idprov)
begin
	update Proveedor set EstadoProv=0 where IdProv=@IDP
end
else
begin
	print 'Proveedor no encontrado'
end

DarBProv '0003'

select * from Proveedor where EstadoProv=0

-- Procedimiento de Modificación
create procedure ModProv
@IDP char(5),
@NP nvarchar(45),
@DP nvarchar(70),
@TP char(8),
@URLP nvarchar(45)
as declare @ip as char(5)
set @ip=(select IdProv from Proveedor where IdProv=@IDP)
declare @t as char(1)
set @t=(select substring(@TP,1,1))
if(@IDP='' or @NP='' or @DP='')
begin
	print 'No pueden ser nulos'
end
else
begin
	if(@IDP=@ip)
	begin
		if(@t='2' or @t='5' or @t='7' or @t='8')
		begin
			update Proveedor set NombreProv=@NP,
			DirProv=@DP, TelProv=@TP, URLProv=@URLP
			where IdProv=@IDP and EstadoProv=1
		end
		else
		begin
			print 'Debe iniciar con 2, 5, 7 u 8'
		end
	end
	else
	begin
		print 'Proveedor no encontrado'
	end
end

-- Procedimiento de Busqueda
create procedure BuscaProv
@IDP char(5)
as 
declare @idpr as char(5)
set @idpr=(select IdProv from Proveedor where IdProv=@IDP)
if(@IDP='')
begin
	print 'No puede ser nulo'
end
	else
	begin
		if(@IDP=@idpr)
		begin
			select * from Proveedor where IdProv=@IDP
		end
		else
		begin
			print 'Proveedor no encontrado'
		end
	end

BuscaProv '00006'

-- Lista de Proveedores activos
create procedure LPA
as
select * from Proveedor where EstadoProv=1

LPA

-- Lista de Proveedores inactivos
create procedure LPI
as
select * from Proveedor where EstadoProv=0

LPI

--------------------------------------------------------------------------------------
-- Procedimentados de Cliente
select * from Clientes

-- 1.- Procedimiento Inserción
create procedure NuevoCliente
@CDC char(5),
@DC nvarchar(45),
@TC char(8)
as
declare @codclie as char(5)
set @codclie=(select CodCliente from Clientes 
where CodCliente=@CDC)
declare @clidt as char(1)
set @clidt=(select substring(@TC,1,1))
if(@CDC='' or @DC='')
begin
	print 'No pueden ser nulos'
end
else
begin
	if(@CDC=@codclie)
	begin
		print 'Cliente ya registrado'
	end
	else
	begin
		if(@clidt='2' or @clidt='5' or @clidt='7' or @clidt='8')
		begin
			insert into Clientes values(@CDC,@DC,@TC,1)
		end
		else
		begin
			print 'Debe iniciar con 2, 5, 7 u 8'
		end
	end
end

NuevoCliente '0067','Blufields','86571204'
NuevoCliente '0123','Chontales','77731256'

select * from Clientes

-- Procedimiento de Dar baja
create procedure DarBCliente
@CDC char(5)
as
declare @codclie as char(5)
set @codclie=(select CodCliente from Clientes 
where CodCliente=@CDC)
if(@CDC=@codclie)
begin
	update Clientes set EstadoCl=0 where CodCliente=@CDC
end
else
begin
	print 'Cliente no encontrado'
end

-- Procedimiento de Modificación
create procedure ModCliente
@CDC char(5),
@DC nvarchar(45),
@TC char(8)
as declare @codcli as char(5)
set @codcli=(select CodCliente from Clientes where CodCliente=@CDC)
declare @ci as char(1)
set @ci=(select substring(@TC,1,1))
if(@CDC='' or @DC='')
begin
	print 'No pueden ser nulos'
end
else
begin
	if(@CDC=@codcli)
	begin
		if(@ci='2' or @ci='5' or @ci='7' or @ci='8')
		begin
			update Clientes set DirC=@DC, TelC=@TC
			where CodCliente=@CDC and EstadoCl=1
		end
		else
		begin
			print 'Debe iniciar con 2, 5, 7 u 8'
		end
	end
	else
	begin
		print 'Cliente no encontrado'
	end
end

--Procedimiento Busqueda
Create procedure BuscaCliente
@IDC char(4)
as
declare @idcl as char(5)
set @idcl=(select CodCliente from Clientes where CodCliente=@IDC)
if(@IDC='')
begin
	print 'No pueden ser nulos'
end
else
begin
	if(@IDC=@idcl)
	begin
	select * from Clientes where CodCliente=@IDC
	end
	else
	begin
		print 'Cliente no encontrado'
	end
end

select * from Clientes

BuscaCliente '0001'

--Lista de Clientes Activos
Create procedure LCA
as
Select * from Clientes where EstadoCl=1
LCA

----Lista de Clientes Inactivos
Create procedure LCI
as
Select * from Clientes where EstadoCl=0
LCI