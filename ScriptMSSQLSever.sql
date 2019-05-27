--Creates and uses new database
--USE master; DROP DATABASE TECAirlines;
CREATE DATABASE TECAirlines;
GO 
USE TECAirlines;

--Tables relations for login and register. 

CREATE TABLE Rol (
Numero INT NOT NULL,
Rol VARCHAR(15) UNIQUE NOT NULL,
PRIMARY KEY(Numero));

CREATE TABLE Empleado (
Cedula CHAR(9) NOT NULL,
RolN INT,
Pnombre VARCHAR(15),
Apellidos VARCHAR(20),
Usuario VARCHAR(15),
Pass VARCHAR(15),
PRIMARY KEY(Cedula),
FOREIGN KEY(RolN) REFERENCES Rol(Numero));

CREATE TABLE Universidad (
Numero INT NOT NULL,
Nombre VARCHAR(50) UNIQUE NOT NULL,
PRIMARY KEY(Numero));

CREATE TABLE Estudiante (
Carne VARCHAR(12) NOT NULL,
NumeroU INT NOT NULL,
Millas DECIMAL(10, 0),
PRIMARY KEY(Carne),
FOREIGN KEY(NumeroU) REFERENCES Universidad(Numero));

CREATE TABLE Pasajero (
Pasaporte VARCHAR(10) NOT NULL,
Carne VARCHAR(12) UNIQUE,
Nombre VARCHAR(50),
Telefono VARCHAR(12),
Correo VARCHAR(15),
NTarjeta CHAR(16),
Pass VARCHAR(15),
PRIMARY KEY(Pasaporte),
FOREIGN KEY(Carne) REFERENCES Estudiante(Carne))

--Stored procedures for register and login

GO 
CREATE PROCEDURE RegistrarE
--Parameters
	@Cedula CHAR(9),
	@Rol VARCHAR(15),
	@Nombre VARCHAR(15),
	@Apellidos VARCHAR(20),
	@Usuario VARCHAR(15),
	@Pass VARCHAR(15)
AS BEGIN 
BEGIN TRY
/*Cedula CHAR(9) NOT NULL,
RolN INT,
Pnombre VARCHAR(15),
Apellidos VARCHAR(20),
Usuario VARCHAR(15),
Pass VARCHAR(15)*/
	INSERT INTO Empleado VALUES
	(@Cedula,
	(SELECT Numero FROM Rol WHERE @Rol=Rol),
	@Nombre,
	@Apellidos,
	@Usuario,
	@Pass);
END TRY
BEGIN CATCH
	SELECT ERROR_PROCEDURE() AS ErrorProcedimiento, ERROR_MESSAGE() AS TipoError
END CATCH
END;

GO 
CREATE PROCEDURE RegistrarP
--Parameters
	@Pasaporte VARCHAR(10),
	@Nombre VARCHAR(50),
	@Telefono VARCHAR(12),
	@Correo VARCHAR(15),
	@Pass VARCHAR(50),
	@NTarjeta VARCHAR(16),
	@Estudiante BIT,
	@NombreU VARCHAR(50),
	@Carne VARCHAR(12)
AS BEGIN 
BEGIN TRY
/*Pasaporte VARCHAR(10) NOT NULL,
Carne VARCHAR(12) UNIQUE,
Nombre VARCHAR(50),
Telefono VARCHAR(12),
Correo VARCHAR(15),
NTarjeta CHAR(16),
Pass VARCHAR(15)*/
	INSERT INTO Pasajero(Pasaporte,Nombre,Telefono,Correo,NTarjeta,Pass) VALUES
	(@Pasaporte,
	@Nombre,
	@Telefono,
	@Correo,
	@NTarjeta,
	@Pass
	);
	IF (@Estudiante = 1)
		INSERT INTO Estudiante Values
		(@Carne,
		(SELECT Numero FROM Universidad WHERE @NombreU = Nombre),
		0);
END TRY
BEGIN CATCH
	SELECT ERROR_PROCEDURE() AS ErrorProcedimiento, ERROR_MESSAGE() AS TipoError
END CATCH
END;

GO
CREATE PROCEDURE GetRoles
AS BEGIN
	SELECT Rol
	FROM Rol;
END;

GO 
CREATE PROCEDURE GetUniversidades
AS BEGIN
	SELECT Nombre
	FROM Universidad;
END;

GO
CREATE PROCEDURE LogEmpleado
	@Usuario VARCHAR(15),
    @Pass VARCHAR(15)
AS BEGIN
	IF ((SELECT E.Pass
		FROM Empleado E
		WHERE @Usuario=Usuario) IS NOT NULL
		AND
		@Pass=(
		SELECT E.Pass
		FROM Empleado AS E
		WHERE @Usuario=Usuario))
		SELECT E.Cedula,E.Pnombre,E.Apellidos,R.Rol
		FROM Empleado E, Rol R
		WHERE @Usuario=Usuario AND E.RolN = R.Numero;
	ELSE RETURN 0;
END;

GO
CREATE PROCEDURE GetPasajeros
AS BEGIN
	SELECT P.Pasaporte,P.Nombre,P.Carne
	FROM Pasajero AS P;
END;

GO
CREATE TRIGGER EmpleadoNullPassword 
ON Empleado AFTER INSERT AS
	DECLARE @Cedula CHAR(9);
	IF ((SELECT E.Pass 
		FROM Empleado E, inserted i 
		WHERE @Cedula = i.Cedula AND i.Cedula = E.Cedula ) IS NULL)
		UPDATE Empleado 
		SET Pass = 'password'
		WHERE Cedula = @Cedula;;

GO
CREATE TRIGGER PasajeroNullPassword 
ON Pasajero AFTER INSERT AS
	DECLARE @Pasaporte VARCHAR(10);
	IF ((SELECT P.Pass
		FROM Pasajero P, inserted i 
		WHERE @Pasaporte = i.Pasaporte AND i.Pasaporte = P.Pasaporte) IS NULL)
		UPDATE Pasajero
		SET Pass = 'password'
		WHERE Pasaporte = @Pasaporte;;
