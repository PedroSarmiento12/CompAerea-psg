-- TABLA T_PASAJERO
CREATE TABLE IF NOT EXISTS T_PASAJERO(
  DNI CHAR(9) NOT NULL PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL,
  Apellidos VARCHAR(150) NOT NULL
);

-- TABLA T_TELEFONO_PASAJERO
CREATE TABLE IF NOT EXISTS T_TELEFONO_PASAJERO(
  DNI CHAR(9) NOT NULL,
  Telefono INT NOT NULL,
  PRIMARY KEY (DNI, Telefono),
  CONSTRAINT FK_TELPASAJERO_PASAJERO
    FOREIGN KEY (DNI) REFERENCES T_PASAJERO(DNI)
);

-- TABLA AVION
CREATE TABLE IF NOT EXISTS T_AVION(
  Matricula VARCHAR(10) NOT NULL PRIMARY KEY,
  Fabricante VARCHAR(250) NOT NULL,
  Modelo VARCHAR(250) NOT NULL,
  Capacidad INT NOT NULL,
  Autonomia INT NOT NULL
);

-- TABLA T_VUELO
CREATE TABLE IF NOT EXISTS T_VUELO(
  IdVuelo INT NOT NULL PRIMARY KEY,
  FechaInicio DATE,
  AeropuertoOrigen VARCHAR(50) NOT NULL,
  AeropuertoDestino VARCHAR(50) NOT NULL,
  Matricula VARCHAR(10) NOT NULL ,
  CONSTRAINT FK_VUELO_AVION
    FOREIGN KEY (Matricula) REFERENCES T_AVION(Matricula)
);

-- TABLA T_PASAJERO_VUELO
CREATE TABLE IF NOT EXISTS T_PASAJERO_VUELO(
  DNI CHAR(9) NOT NULL,
  IdVuelo INT NOT NULL,
  Clase ENUM ('Business', 'Primera', 'Turista'),
  Asiento SMALLINT NOT NULL,
  PRIMARY KEY (DNI, IdVuelo),
  CONSTRAINT FK_PASAJEROVUELO_PASAJERO
    FOREIGN KEY (DNI) REFERENCES T_PASAJERO (DNI),
  CONSTRAINT FKPASAJEROVUELO_VUELO
    FOREIGN KEY (IdVuelo) REFERENCES T_VUELO(IdVuelo)
);

-- TABLA T_CATEGORIA
CREATE TABLE IF NOT EXISTS T_CATEGORIA(
  IdCategoria INT NOT NULL PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL
);

-- TABLA T_TRABAJADOR
CREATE TABLE IF NOT EXISTS T_TRABAJADOR(
  IdTrabajador INT NOT NULL PRIMARY KEY,
  Nombre VARCHAR(50) NOT NULL,
  Apellido1 VARCHAR(100) NOT NULL,
  Apellido2 VARCHAR(100) NULL,
  IdCategoria INT NOT NULL,
  CONSTRAINT FK_TRABAJADOR_CATEGORIA
     FOREIGN KEY (IdCategoria) REFERENCES T_CATEGORIA(IdCategoria)
);

-- TABLA T_TELEFONO_TRABAJADOR
CREATE TABLE IF NOT EXISTS T_TELEFONO_TRABAJADOR(
  IdTrabajador INT NOT NULL,
  Telefono INT NOT NULL,
  PRIMARY KEY (IdTrabajador, Telefono),
  CONSTRAINT FK_TELTRABAJADOR_TRABAJADOR
    FOREIGN KEY (IdTrabajador) REFERENCES T_TRABAJADOR(IdTrabajador)
);



-- TABLA T_TRIPULANTE
CREATE TABLE IF NOT EXISTS T_TRIPULANTE (
  IdTripulante INT NOT NULL PRIMARY KEY,
  FechaInicio DATE NOT NULL,
  IdTrabajador INT NOT NULL UNIQUE,
  CONSTRAINT FK_TRIPULANTE_TRABAJADOR
    FOREIGN KEY(IdTrabajador) REFERENCES T_TRABAJADOR(IdTrabajador)
);

-- TABLA T_TRIPULANTE_VUELO
CREATE TABLE IF NOT EXISTS T_TRIPULANTE_VUELO(
  IdTripulante INT NOT NULL,
  IdVuelo INT NOT NULL,
  Puesto VARCHAR(50) NOT NULL,
  PRIMARY KEY(idTripulante, IdVuelo),
  CONSTRAINT FK_TRIPULANTEVUELO_TRIPULANTE
    FOREIGN KEY (IdTripulante) REFERENCES T_TRIPULANTE (IdTripulante),
  CONSTRAINT FK_TRIPULANTEVUELO_VUELO
    FOREIGN KEY (IdVuelo) REFERENCES T_VUELO(IdVuelo)
);