--Database population query
--USE master;
USE TECAirlines;

INSERT INTO Rol (Numero, Rol) VALUES
(1, 'Embarcador'),
(2, 'Scan'),
(3, 'Recepcionista'),
(4, 'Administrador');

INSERT INTO EMPLEADO (Cedula, RolN, Pnombre, Apellidos, Usuario, Pass) VALUES
('102220333', 4, 'Juan', 'Hernandez Salazar', '102220333', 'password'),
('201110444', 4, 'Deiber', 'Granados Vega', '201110444', 'password'),
('302220111', 4, 'Luke', 'Highground Skywalker', '302220111', 'password'),
('401110222', 4, 'Oscuro', 'Lorcito', '401110222', 'password'),
('401110221', 4, 'Felix', 'Fernandez Fontana', '401110221', 'password'),
('804440222', 2, 'Kisung', 'Lim', '804440222', 'password'),
('202220333', 2, 'Michiaki', 'Ogawa', '202220333', 'password'),
('301110444', 2, 'Juana', 'de Arco', '301110444', 'password'),
('801110444', 2, 'Sun Shin', 'Yi', '801110444', 'password'),
('801110441', 2, 'Sun Shin', 'Lee', '801110441', 'password'),
('502220111', 3, 'Camila', 'Panama Ruiz', '502220111', 'password'),
('602220111', 3, 'Rebeca', 'Panama Ruiz', '602220111', 'password'),
('702220111', 3, 'Laura', 'Panama Ruiz', '702220111', 'password'),
('802220111', 3, 'Yessi', 'Panama Ruiz', '802220111', 'password'),
('802220112', 3, 'Yessy', 'Ordonez Martinez', '802220112', 'password'),
('101110111', 1, 'Marco', 'Hernandez', '101110111', 'password'),
('202220222', 1, 'Issac', 'Hernandez', '202220222', 'password'),
('303330333', 1, 'Jose', 'Villalobos Mena', '303330333', 'password'),
('303330334', 1, 'Chocky', 'Choque Checo', '303330334', 'password'),
('404440444', 1, 'Manuel', 'Mora Murilo', '404440444', 'password');

INSERT INTO Universidad (Numero, Nombre) VALUES 
(1, 'TEC'),
(2, 'UNA'),
(3, 'UCR');

INSERT INTO Estudiante (Carne, NumeroU, Millas) VALUES
('2017020202', 1, 10),
('2016010101', 1, 20),
('2018011111', 1, 0),
('2019099999', 1, 0);

INSERT INTO Pasajero (Pasaporte, Carne, Nombre, Telefono, Correo, Pass) VALUES
('M00000000', '2017020202', 'Michiaki Ogawa', '85250570', 'kionlim@gmail.com', 'password'),
('G00000000', '2016010101', 'Joe Bastianich', '89895656', 'kisonlim@gmail.com', 'password'),
('Y00000000', '2018011111', 'Gordon Ramsey', '65656565', 'kisonlim@gmail.com', 'password'),
('S11111111', '2019099999', 'Hamley Martinez', '87485124', 'kisonlim@gmail.com', 'password');