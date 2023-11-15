Create login Sistematico
with password = 'Sistematico11'
GO
CREATE DATABASE PruebaSiste
GO

USE PruebaSiste
GO

sp_adduser Sistematico, Sistematico
GO

GRANT CONTROL ON DATABASE::PruebaSiste TO Sistematico;

Create Table Clientes(
idCliente INT PRIMARY KEY IDENTITY(1,1),
categoria VARCHAR(50),
nombreCliente VARCHAR(50),
apellidoCliente VARCHAR(50)
)

INSERT INTO Clientes VALUES('ESTUDIANTE', 'JAYSSSON','FLEY')
select * from Clientes

CREATE TABLE Users (
    Id INT IDENTITY PRIMARY KEY,
    UserName NVARCHAR(50) NOT NULL,
    PassEncrip NVARCHAR(128) NOT NULL,
	Rol VARCHAR (50) NOT NULL, 
	Estado VARCHAR (50) NOT NULL
);

-- Crear un SP para registrar un nuevo usuario con contraseña encriptada
CREATE PROCEDURE RegistrarUser
    @UserName NVARCHAR(50),
    @InputPassword NVARCHAR(50),
	@Rol NVARCHAR(50),
	@Estado NVARCHAR(50)
AS
BEGIN
    
    DECLARE @PasswordHash NVARCHAR(128);
    SET @PasswordHash = HASHBYTES('SHA2_256', @InputPassword);

    
    INSERT INTO Users (UserName, PassEncrip, Rol, Estado)
    VALUES (@UserName, @PasswordHash, @Rol, @Estado);
END



-- Crear un SP para autenticar usuarios
CREATE PROCEDURE AuthenticateUser
    @UserName NVARCHAR(50),
    @Password NVARCHAR(50)
AS
BEGIN
    -- Obtener la contraseña almacenada para el usuario
    DECLARE @ContraGuardCifrada NVARCHAR(128);
    SELECT @ContraGuardCifrada = PassEncrip
    FROM Users
    WHERE UserName = @UserName;

    -- Verificar la contraseña ingresada por el usuario
    IF @ContraGuardCifrada IS NOT NULL
    BEGIN
        -- Calcular el resumen de la contraseña ingresada
        DECLARE @ContraseñaIngresada NVARCHAR(128);
        SET @ContraseñaIngresada = HASHBYTES('SHA2_256', @Password);

        -- Comparar los resúmenes de contraseñas
        IF @ContraGuardCifrada = @ContraseñaIngresada
        BEGIN
            -- Contraseña válida
			
            SELECT 'Acceso concedido' AS Message, Rol as [Role] from Users WHERE UserName = @UserName;
			
        END
        ELSE
        BEGIN
            -- Contraseña incorrecta
            SELECT 'Acceso denegado' AS Message;
        END
    END
    ELSE
    BEGIN
        -- Usuario no encontrado
        SELECT 'Acceso denegado' AS Message ;
    END
END

exec RegistrarUser 'Jaysson2','Hola22', 'Empleado','Habilitado'
select * from Users

exec AuthenticateUser 'Jaysson2','Hola22'
