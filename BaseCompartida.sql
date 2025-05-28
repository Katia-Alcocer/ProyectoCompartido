Create DATABASE HerreriaUG;

-- Tablas de la base de datos
<<<<<<< HEAD
-- ========================
--Tan inge que si puede hacer cambios
--Hola pute
=======

>>>>>>> 833c837ece5dda5bcacfb10a8e3b43782c8a213a
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

CREATE TABLE Clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Credito DECIMAL(10,2) NOT NULL,
    Limite DECIMAL(10,2) NOT NULL,
    idPersona INT NOT NULL,
    idHerrero INT NOT NULL,
    idDomicilio INT NOT NULL,
    
    CONSTRAINT chk_Limite_Credito CHECK (Limite <= Credito),
    
    CONSTRAINT fk_Clientes_Personas FOREIGN KEY (idPersona)
        REFERENCES Personas(idPersona)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_Clientes_Herreros FOREIGN KEY (idHerrero)
        REFERENCES Herreros(idHerrero)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT fk_Clientes_Domicilios FOREIGN KEY (idDomicilio)
        REFERENCES Domicilios(idDomicilio)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Empleados (
    idEmpleado INT AUTO_INCREMENT PRIMARY KEY,
    Puesto ENUM('Administrador', 'Cajero', 'Agente de Venta') NOT NULL,
    RFC VARCHAR(13) NOT NULL UNIQUE,
    NumeroSeguroSocial VARCHAR(11) NOT NULL UNIQUE,
    Usuario VARCHAR(255) NOT NULL UNIQUE,
    Contraseña VARCHAR(255) NOT NULL,
    idPersona INT NOT NULL,

    CONSTRAINT fk_Empleados_Personas FOREIGN KEY (idPersona)
        REFERENCES Personas(idPersona)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT chk_Correo_Valido CHECK (Usuario LIKE '%_@__%.__%')--Revisa que si tenga el formato de un correo electronico
);

CREATE TABLE Productos (
    idProducto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    PrecioCompra DECIMAL(10,2) NOT NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    FechaCaducidad DATE,
    Estado ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo',
    idCategoria INT NOT NULL,
    idProveedor INT NOT NULL,

    CONSTRAINT fk_Productos_Categorias FOREIGN KEY (idCategoria)
        REFERENCES Categorias(idCategoria)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_Productos_Proveedores FOREIGN KEY (idProveedor)
        REFERENCES Proveedores(idProveedor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_Precios CHECK (PrecioVenta >= PrecioCompra),
    CONSTRAINT chk_Stock CHECK (Stock >= 0)
);
CREATE TABLE Proveedores (
    idProveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);
CREATE TABLE Categorias (
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Descuentos (
    idHerrero INT AUTO_INCREMENT PRIMARY KEY,
    Categoria VARCHAR(100) NOT NULL,
    Porcentaje DECIMAL(5,2) NOT NULL CHECK (Porcentaje BETWEEN 0 AND 100)
);


