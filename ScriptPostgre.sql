--Tables from Tabas database.
CREATE TABLE MarcaBagcart (
Marca VARCHAR(15) NOT NULL,
Modelo INT NOT NULL,
Capacidad INT,
PRIMARY KEY(Marca,Modelo));

CREATE TABLE Bagcart (
ID CHAR(5) NOT NULL,
Marca VARCHAR(15),
Modelo INT,
PRIMARY KEY(ID),
FOREIGN KEY(Marca,Modelo) REFERENCES MarcaBagcart(Marca,Modelo));

CREATE TABLE Vuelo (
ID CHAR(5) NOT NULL,
Precio INT,
PRIMARY KEY(ID));

CREATE TABLE Aeropuerto (
Codigo CHAR(3) NOT NULL,
Locacion TEXT,
PRIMARY KEY(Codigo));

CREATE TABLE Maleta (
Numero INT NOT NULL,
BagcartID CHAR(5),
PasajeroID VARCHAR(10) NOT NULL,
Costo MONEY,
Revisado BOOLEAN,
Peso INT,
PRIMARY KEY(Numero),
FOREIGN KEY(BagcartID) REFERENCES Bagcart(ID));

CREATE TABLE Factura (
MaletaN INT NOT NULL,
ID VARCHAR(15) NOT NULL,
Archivo XML,
PRIMARY KEY(ID),
FOREIGN KEY(MaletaN) REFERENCES Maleta(Numero));

CREATE TABLE Avion (
ID CHAR(4) NOT NULL,
Modelo TEXT,
Capacidad INT,
PRIMARY KEY(ID));

CREATE TABLE Asignacion (
AvionID CHAR(4) NOT NULL,
BagcartID CHAR(5) NOT NULL,
Sello CHAR(10) UNIQUE,
Posicion TEXT,
PRIMARY KEY(AvionID,BagcartID),
FOREIGN KEY(AvionID) REFERENCES Avion(ID),
FOREIGN KEY(BagcartID) REFERENCES Bagcart(ID));

CREATE TABLE Escala (
Numero INT NOT NULL,
VueloID CHAR(5) NOT NULL,
AvionID CHAR(4),
ASalida CHAR(3),
ALlegada CHAR(3),
Millas INT,
FSalida TIMESTAMP,
FLlegada TIMESTAMP,
PRIMARY KEY(Numero,VueloID),
FOREIGN KEY(VueloID) REFERENCES Vuelo(ID),
FOREIGN KEY(AvionID) REFERENCES Avion(ID),
FOREIGN KEY(ASalida) REFERENCES Aeropuerto(Codigo),
FOREIGN KEY(ALlegada) REFERENCES Aeropuerto(Codigo));

CREATE TABLE Viaja (
PasajeroID VARCHAR(10) NOT NULL UNIQUE,
VueloID CHAR(5) NOT NULL,
PRIMARY KEY(VueloID, PasajeroID));

--Stored procedures
--Getters
CREATE OR REPLACE FUNCTION GetMarcas ()
RETURNS TABLE (Marca VARCHAR, Modelo INT)
AS $$
BEGIN
	RETURN QUERY
	SELECT m.Marca, m.Modelo
	FROM MarcaBagcart m;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION GetBagcarts ()
RETURNS TABLE (ID CHAR, Marca VARCHAR, Modelo INT, Capacidad INT)
AS $$
BEGIN
	RETURN QUERY
	SELECT b.ID, b.Marca, b.Modelo, m.Capacidad
	FROM Bagcart b, marcabagcart m
	WHERE b.marca = m.marca AND b.modelo = m.modelo;
END; $$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION GetVuelos ()
RETURNS TABLE (ID CHAR, Precio INT)
AS $$
BEGIN
	RETURN QUERY
	SELECT v.ID, v.Precio
	FROM Vuelo v;
END; $$ 
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION GetMaletas ()
RETURNS TABLE
	(Numero INT, BagcartID CHAR, PasajeroID VARCHAR, Costo MONEY, Revisado BOOLEAN, Peso INT)
AS $$
BEGIN 
	SELECT m.Numero, m.BagcartID, m.PasajeroID, m.Costo, m.Revisado, m.Peso
	FROM Maleta m;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION GetMaleta (Num INT)
RETURNS TABLE
	(BagcartID CHAR, PasajeroID VARCHAR, Costo MONEY, Revisado BOOLEAN, Peso INT)
AS $$
BEGIN
	RETURN QUERY
	SELECT m.BagcartID, m.PasajeroID, m.Costo, m.Revisado, m.Peso
	FROM Maleta m
	WHERE m.Numero = Num;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION GetFactura (ThisID VARCHAR(15))
RETURNS TABLE (MaletaN INT, Archivo XML)
AS $$
BEGIN
	RETURN QUERY
	SELECT f.MaletaN, f.Archivo
	FROM Factura f
	WHERE ThisIS = f.ID;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION GetFactura (TMaletaN INT)
RETURNS TABLE (ID VARCHAR, Archivo XML)
AS $$
BEGIN
	SELECT f.ID, f.Archivo
	FROM Factura f
	WHERE f.MaletaN = TMaletaN;
END; $$
LANGUAGE plpgsql;

--DROP FUNCTION getaviones()
CREATE OR REPLACE FUNCTION GetAviones ()
RETURNS TABLE (ID CHAR, Modelo TEXT, Capacidad INT)
AS $$
BEGIN
	RETURN QUERY
	SELECT a.ID, a.Modelo, a.Capacidad
	FROM Avion a;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION CreateMarca (TMarca VARCHAR(15), TModelo INT, TCapacidad INT)
RETURNS BOOLEAN
AS $$
BEGIN
	BEGIN
		INSERT INTO marcabagcart (Marca, Modelo, Capacidad) VALUES
		(TMarca, TModelo, TCapacidad);
		RETURN TRUE;
	EXCEPTION 
		WHEN check_violation OR unique_violation THEN
		RETURN FALSE;
	END;
END; $$
LANGUAGE plpgsql;
		
CREATE OR REPLACE FUNCTION CreateBagcart (TID CHAR(5), TMarca VARCHAR(15), TModelo INT)
RETURNS BOOLEAN
AS $$
BEGIN
	BEGIN
		INSERT INTO bagcart (ID, Marca, Modelo) VALUES
		(TID, TMarca, TModelo);
		RETURN TRUE;
	EXCEPTION 
		WHEN check_violation OR unique_violation THEN
		RETURN FALSE;
	END;
END; $$
LANGUAGE plpgsql;



