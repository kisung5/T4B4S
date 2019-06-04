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
Locacion TEXT
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
ID VARCHAR(4) NOT NULL,
Moledo TEXT,
Capacidad INT,
PRIMARY KEY(ID));

CREATE TABLE Asignacion (
AvionID VARCHAR(4) NOT NULL,
BagcartID VARCHAR(5) NOT NULL,
Sello CHAR(10) UNIQUE,
Posicion TEXT,
PRIMARY KEY(AvionID,BagcartID),
FOREIGN KEY(AvionID) REFERENCES Avion(ID),
FOREIGN KEY(BagcartID) REFERENCES Bagcart(ID));

CREATE TABLE Escala (
Numero INT NOT NULL,
VueloID VARCHAR(5) NOT NULL,
AvionID VARCHAR(4),
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
VueloID VARCHAR(5) NOT NULL,
PRIMARY KEY(VueloID, PasajeroID));

--Stored procedures
--Getters
CREATE PROCEDURE GetMarcas ()
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT (Marca, Modelo)
	FROM MarcaBagcart;
END; $$;

CREATE PROCEDURE GetBagcarts ()
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT (ID, Marca, Modelo, Capacidad)
	FROM Bagcart;
END; $$;

CREATE PROCEDURE GetVuelos ()
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT (ID, Precio)
	FROM Vuelo;
END; $$;

CREATE PROCEDURE GetMaletas ()
LANGUAGE plpgsql
AS $$
BEGIN 
	SELECT (Numero, BagcartID, PasajeroID, Costo, Revisado, Peso)
	FROM Maleta;
END; $$;

CREATE PROCEDURE GetMaleta (Num INT)
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT (BagcartID, PasajeroID, Costo, Revisado, Peso)
	FROM Maleta
	WHERE Numero = Num;
END; $$;

CREATE PROCEDURE GetFactura (ThisID VARCHAR(15))
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT (MaletaN, Archivo)
	FROM Factura
	WHERE ThisIS = ID;
END; $$;

CREATE PROCEDURE GetFactura (TMaletaN INT)
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT (ID, Archivo)
	FROM Factura
	WHERE MaletaN = TMaletaN;
END; $$;

CREATE PROCEDURE GetAviones ()
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT (ID, Modelo, Capacidad)
	FROM Avion;
END; $$;







