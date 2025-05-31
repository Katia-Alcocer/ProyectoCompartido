Create DATABASE HerreriaUG;

USE HerreriaUG;

-- Tablas de la base de datos
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
    Estatus ENUM('Activo','Inactivo') NOT NULL DEFAULT 'Activo',
    idDomicilio int,
    CONSTRAINT fk_Clientes_Domicilios FOREIGN KEY (idDomicilio)
            REFERENCES Domicilios(idDomicilio)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE Descuentos (
    idDescuento INT AUTO_INCREMENT PRIMARY KEY,
    Categoria VARCHAR(100) NOT NULL,
    Porcentaje DECIMAL(5,2) NOT NULL CHECK (Porcentaje BETWEEN 0 AND 100)
);

CREATE TABLE Clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Credito DECIMAL(10,2) NOT NULL,
    Limite DECIMAL(10,2) NOT NULL,
    idPersona INT NOT NULL,
    idDescuento INT,
    
    
    CONSTRAINT chk_Limite_Credito CHECK (Credito <= Limite),
    
    CONSTRAINT fk_Clientes_Personas FOREIGN KEY (idPersona)
        REFERENCES Personas(idPersona)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_Clientes_Herreros FOREIGN KEY (idDescuento)
        REFERENCES Descuentos(idDescuento)
        ON DELETE SET NULL
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
        ON UPDATE CASCADE
);



CREATE TABLE Proveedores (
    idProveedor INT AUTO_INCREMENT PRIMARY KEY,
    Estado ENUM('Activo', 'Inactivo') NOT NULL DEFAULT 'Activo',
    Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Categorias (
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Productos (
    idProducto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    PrecioCompra DECIMAL(10,2) NOT NULL,
    PrecioVenta DECIMAL(10,2) NOT NULL,
    CodigoBarras BIGINT,
    Stock INT NOT NULL DEFAULT 0,
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

CREATE TABLE Ventas (
    idVenta INT AUTO_INCREMENT PRIMARY KEY,
    Monto DECIMAL(10,2) NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Subtotal DECIMAL(10,2) NOT NULL,
    IVA DECIMAL(10,2) NOT NULL,
    IEPS DECIMAL(10,2) NOT NULL,
    CantidadProductos INT NOT NULL CHECK (CantidadProductos > 0),
    TipoPago ENUM('Contado', 'Cheque', 'Transferencia', 'Credito') NOT NULL,
    Estatus ENUM('Cancelada', 'Pagada', 'En Espera de Pago') NOT NULL DEFAULT 'En Espera de Pago',
    idCliente INT NOT NULL,
    idEmpleado INT NOT NULL,

    CONSTRAINT fk_Ventas_Clientes FOREIGN KEY (idCliente)
        REFERENCES Clientes(idCliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_Ventas_Empleados FOREIGN KEY (idEmpleado)
        REFERENCES Empleados(idEmpleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE DetalleVenta (
    idDetalleVenta INT AUTO_INCREMENT PRIMARY KEY,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    Total DECIMAL(10,2) NOT NULL,
    IVA DECIMAL(10,2) NOT NULL,
    IEPS DECIMAL(10,2) NOT NULL,
    idVenta INT NOT NULL,
    idProducto INT NOT NULL,
    idDescuento INT,

    CONSTRAINT fk_DetalleVenta_Ventas FOREIGN KEY (idVenta)
        REFERENCES Ventas(idVenta)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_DetalleVenta_Productos FOREIGN KEY (idProducto)
        REFERENCES Productos(idProducto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_DetalleVenta_Descuentos FOREIGN KEY (idDescuento)
        REFERENCES Descuentos(idDescuento)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE Temp_Ventas (
    idEmpleado INT NOT NULL,
    idProducto INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PRIMARY KEY (idEmpleado, idProducto),
    FOREIGN KEY (idEmpleado) REFERENCES Empleados(idEmpleado)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (idProducto) REFERENCES Productos(idProducto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE HistorialModificaciones (
    idHistorial INT AUTO_INCREMENT PRIMARY KEY,
    Movimiento VARCHAR(50),
    TablaAfectada VARCHAR(100) NOT NULL,
    ColumnaAfectada VARCHAR(100) NOT NULL,
    DatoAnterior TEXT,
    DatoNuevo TEXT,
    Fecha DATE NOT NULL DEFAULT (CURRENT_DATE),
    Hora TIME NOT NULL DEFAULT (CURRENT_TIME),
    idEmpleado INT NOT NULL,

    CONSTRAINT fk_Historial_Empleados FOREIGN KEY (idEmpleado)
        REFERENCES Empleados(idEmpleado)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE Finanzas (
    idFinanza INT AUTO_INCREMENT PRIMARY KEY,
    idVenta INT NOT NULL,
    TotalVenta DECIMAL(10,2) NOT NULL,
    Invertido DECIMAL(10,2) NOT NULL,
    Ganancia DECIMAL(10,2) GENERATED ALWAYS AS (TotalVenta - Invertido) STORED,

    CONSTRAINT fk_Finanzas_Ventas FOREIGN KEY (idVenta)
        REFERENCES Ventas(idVenta)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

ALTER TABLE finanzas DROP FOREIGN KEY fk_Finanzas_Ventas;

ALTER TABLE finanzas 
ADD CONSTRAINT fk_Finanzas_Ventas 
FOREIGN KEY (idVenta) REFERENCES ventas(idVenta) 
ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE Pedidos (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    Fecha DATE NOT NULL DEFAULT (CURRENT_DATE),
    Hora TIME NOT NULL DEFAULT (CURRENT_TIME),
    Estatus ENUM('Pendiente', 'Aceptado', 'Enviado', 'Cancelado') NOT NULL DEFAULT 'Pendiente',
    idCliente INT NOT NULL,
    idEmpleado INT,

    CONSTRAINT fk_Pedidos_Clientes FOREIGN KEY (idCliente)
        REFERENCES Clientes(idCliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_Pedidos_Empleados FOREIGN KEY (idEmpleado)
        REFERENCES Empleados(idEmpleado)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE DetallePedidos (
    idDetallePedido INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    idProducto INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) GENERATED ALWAYS AS (Cantidad * PrecioUnitario) STORED,

    CONSTRAINT fk_DetallePedidos_Pedidos FOREIGN KEY (idPedido)
        REFERENCES Pedidos(idPedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT fk_DetallePedidos_Productos FOREIGN KEY (idProducto)
        REFERENCES Productos(idProducto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Todos los Triggers, Vistas, Impresiones PDF y Procedimintos almacenados que hice con ayuda de chatt

session_start();
$idEmpleado = $_SESSION['id'];
$conexion->query("SET @id_empleado_sesion := $idEmpleado");
