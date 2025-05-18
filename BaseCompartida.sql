Create DATABASE HerreriaUG;

-- Tablas de la base de datos
-- ========================
CREATE TABLE Pais (
    id_Pais INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Estado (
    c_estado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    d_Estado VARCHAR(100) NOT NULL UNIQUE,
    id_Pais INT NOT NULL,
    FOREIGN KEY (id_Pais) REFERENCES Pais(id_Pais)
);

CREATE TABLE Ciudad (
    c_cve_ciudad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    d_ciudad VARCHAR(100) NOT NULL,
    c_oficina INT,
    c_estado INT NOT NULL,
    FOREIGN KEY (c_estado) REFERENCES Estado(c_estado)
);


CREATE TABLE Municipio (
    c_mnpio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    D_mnpio VARCHAR(100) NOT NULL,
    c_cve_ciudad INT,
    FOREIGN KEY (c_cve_ciudad) REFERENCES Ciudad(c_cve_ciudad)
);


CREATE TABLE Asentamiento ( 
    c_tipo_asenta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    d_asenta VARCHAR(100), 
    d_tipo_asenta VARCHAR(100),
    id_asenta_cpcons INT,
    d_zona VARCHAR(100),
    c_mnpio INT NOT NULL,
    FOREIGN KEY (c_mnpio) REFERENCES Municipio(c_mnpio)
);


CREATE TABLE CodigosPostales (
    c_CP INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    d_codigo VARCHAR(10) NOT NULL,
    d_CP VARCHAR(10),
    c_tipo_asenta INT NOT NULL,
    FOREIGN KEY (c_tipo_asenta) REFERENCES Asentamiento(c_tipo_asenta)
);
CREATE TABLE Domicilios(
idDomicilio int not null auto_increment primary key,
Calle varchar(50) not null,
Numero int not null,
c_CP int not null,
Foreign Key (c_CP) REFERENCES CodigosPostales(c_CP)
);
CREATE TABLE Personas (
idPersona int not null auto_increment primary key,
Nombre varchar(50) not null,
Paterno varchar(50) not null,
Materno varchar(50) not null,
Telefono varchar(10) not null UNIQUE,
Email varchar(50) not null UNIQUE,
Edad smallint not null check (Edad >0 and Edad<100),
Sexo Enum('H','M') not null,
idDomicilio int foreign key references Domicilios(idDomicilio)
);

