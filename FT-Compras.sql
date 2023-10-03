--Homework DB I
-- By: Luisa Téllez

use SFCIFX

Select * From Compras

-- Procedimiento de insercion, para compras
CREATE procedure NuevaCMP
@FC char(5)
as
declare @codc char(4)
set @codc=(select IdProv from Proveedor where IdProv=@FC)
if(@FC='')
begin
  print 'No puede ser nulo'
end
else
begin
if(@FC=@codc)
begin
  insert into Compras values(@@IDENTITY,getdate(),@FC,0)
end
else
begin
  print 'Proveedor no registrado'
end
end

Select * from Compras
Select * from Proveedor

NuevaCMP '00001'

create function ClclrSTP(@CP char(4),@Ccp char(5))
returns float
as
begin
  declare @st as float
  select @st=Preciop * @Ccp from Productos 
  where CodProd=@CP
  return @st
end

create trigger ActInvC
on
DetCompras
after insert
as
  update Productos set Existp=Existp- (select cantc from inserted)
  from Productos p, DetCompras dv where p.CodProd=dv.CodProd

  -- Procedimiento de Insercion para el detalle de compras

 select * from DetCompras

 create procedure NuevoDC
 @IDC int,
 @CP char(4),
 @cc int
 as
 declare @idCompra as int
 set @idCompra=(select FCompra from Compras where FCompra=@IDC)
 declare @codp as char(4)
 set @codp=(select CodProd from Productos where CodProd=@CP)
 declare @e as int
 set @e=(select Existp from Productos where CodProd=@CP)
 if(@IDC=@idCompra)
 begin
   if(@CP='')
   begin
     print 'No se permiten nulos'
   end
   else
   begin
     if(@CP=@codp)
	 begin
	   if(@cc<=@e)
	   begin
	      insert into DetVentas values(@IDC,@CP, @cc,
		  dbo.CalcularSTP(@CP,@cc))
	   end
	   else
	   begin
	     print 'No hay suficiente inventario'
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
   print 'Compra no registrada'
 end

 -- Actualizar la compra
 create procedure ActC
 @IDC int
 as
 declare @idCompra int
 set @idCompra=(select FCompra from Compras where FCompra=@IDC )
 declare @stc float
 set @stc=(select sum(subtp) from DetVentas where IdVenta=@IDC )
 if(@IDC =@idCompra)
 begin
   update Compras set TotalC=@stc where FCompra=@IDC 
 end
 else
 begin
    print 'Compra no registrada'
 end

select * from Productos
