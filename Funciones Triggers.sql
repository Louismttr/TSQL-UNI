--Fuciones y trigges
Use SFCIFX

select * From ClienteNat

insert into ClienteNat values( 'Reynaldo','', 'Castaño', 'Umañana', 'rey@gmail.com', '0002'),
( 'Yasser', 'Ronaldo', 'Membreño', 'Guidel', 'yass@yahoo.es', '0001')

Select * from Clientes
insert into Clientes values('0003','Ducali', '22389565'), ('0004', 'Altamira', '87451245')

insert into ClienteJur values('J01', 'SITISA', '2011-06-14', 'Louisa Jones', 'www.sitsa.com.ni', '0003' )

---Funciones generada por el usuario
---Crear un procedimiento de insercion para la venta
alter ProCEdure NuevaV
@CC char(4)
as
declare @codc char(4)
set @codc = (select CodCliente from Clientes where CodCliente=@CC)
IF(@CC='')
BEGIN
	PRINT('No puede ser nulo')
	end
else
BEGIN
IF(@CC=@codc) 
begin
	INSERT INTO Ventas VALUES(GETDATE(), @CC, 0)
END
ELSE
BEGIN
	PRINT'Cliente no registrado'
	end
end

Select * from Ventas

NuevaV '0001'

Create function CalcularSTP(@CP char(4), @cv int)
returns float
as
begin
	declare @st as float
	select @st=Preciop * @cv from Productos
	where CodProd=@CP
	return @st
	end
--Trigger
--posibles acciones: Insert, delete, update, select
--Tiempos de acciones: before, for, after
--posibles reacciones: Insert, delete, update, select
--Al ejecutar una accion indistintamenter del tiempo se pueden
-- generar multiples reacciones

create TRIGGER ActInvV
on
DetVentas
after insert --insertandooooo..
as
	update Productos set Existp=Existp-(select cantv from inserted)
	from Productos p, DetVentas dv where p.CodProd=dv.CodProd

	--Procedimiento de inserccion para el detalle de venta
Create procedure NuevoDV
@IDV int,
@CP char(4),
@cv int 
as
declare @idventa as int
set @idventa=(select @idventa FROM Ventas where IdVenta=@IDV)
declare @codp as char(4)
set @codp=(select CodProd from Productos where CodProd=@CP)
DECLARE @e as int
set @e=(Select Existp from Productos where CodProd=@CP)
if(@IDV=@idventa)
BEGIN
	IF(@CP='')
	BEGIN
	PRINT 'No pueden ser nulos'
	end
	else
	Begin
	if(@CP=@codp)
	begin
	if(@cv<=@e)
	begin
	 insert into DetVentas VALUES(@IDV, @CP, @cv,
	 dbo.CalcularSTP(@CP, @cv))
	end
	else
	begin
	print 'No hay suficiene inventario'
	end
end
	else
	begin 
	print 'Producto no encontrado'
	end
	end
end
else
begin 
print 'Venta no registrada'
end

-- Actualizar venta
create procedure ActV
@IDV INT
AS
DECLARE @idventa int
SET @idventa=(Select IdVenta from Ventas where IdVenta=@IDV)
declare @stv float
set @stv=(select sum(subtp) from DetVentas where IdVenta = @IDV)
if(@IDV=@idventa)
begin
	update Ventas set TotalV=@stv where IdVenta=@IDV
	END
	ELSE
	begin
	print 'venta no registrada'
	end

select * from Productos

NuevoDV 1,1,2

select * from DetVentas

NuevoDV 1,2,2

select * from Productos where CodProd=2

select* from ventas

ActV 1