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

-- Triggers
DELIMITER $$
-- 1. PromocionExistenciaBaja
CREATE TRIGGER PromocionExistenciaBaja
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF NEW.Stock < 10 AND OLD.Stock >= 10 THEN
        INSERT INTO Descuentos (Categoria, Porcentaje)
        VALUES (CONCAT('Promo ', NEW.Nombre), 15.00);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 2. VerificarCreditoClienteBefore
CREATE TRIGGER VerificarCreditoClienteBefore
BEFORE INSERT ON Ventas
FOR EACH ROW
BEGIN
    DECLARE creditoDisponible DECIMAL(10,2);

    IF NEW.TipoPago = 'Credito' THEN
        SELECT Credito INTO creditoDisponible
        FROM Clientes
        WHERE idCliente = NEW.idCliente;

        IF creditoDisponible < NEW.Monto THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El crédito disponible del cliente no es suficiente.';
        END IF;
    END IF;
END$$
DELIMITER ;


DELIMITER $$
-- 3. VerificarVentaProducto
CREATE TRIGGER VerificarVentaProducto
BEFORE INSERT ON DetalleVenta
FOR EACH ROW
BEGIN
    DECLARE existencia INT;
    SELECT Stock INTO existencia FROM Productos WHERE idProducto = NEW.idProducto;
    IF existencia < NEW.Cantidad THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente stock del producto para completar la venta.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 4. ProductoUpdateAuditoriaAfter
CREATE TRIGGER ProductoUpdateAuditoriaAfter
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    -- Stock
    IF NEW.Stock <> OLD.Stock THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Productos', 'Stock', OLD.Stock, NEW.Stock, @id_empleado_sesion);
    END IF;

    -- Nombre
    IF NEW.Nombre <> OLD.Nombre THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Productos', 'Nombre', OLD.Nombre, NEW.Nombre, @id_empleado_sesion);
    END IF;

    -- PrecioCompra
    IF NEW.PrecioCompra <> OLD.PrecioCompra THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Productos', 'PrecioCompra', OLD.PrecioCompra, NEW.PrecioCompra, @id_empleado_sesion);
    END IF;

    -- PrecioVenta
    IF NEW.PrecioVenta <> OLD.PrecioVenta THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Productos', 'PrecioVenta', OLD.PrecioVenta, NEW.PrecioVenta, @id_empleado_sesion);
    END IF;

    -- Estado
    IF NEW.Estado <> OLD.Estado THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Productos', 'Estado', OLD.Estado, NEW.Estado, @id_empleado_sesion);
    END IF;

    -- idCategoria
    IF NEW.idCategoria <> OLD.idCategoria THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Productos', 'idCategoria', OLD.idCategoria, NEW.idCategoria, @id_empleado_sesion);
    END IF;

    -- idProveedor
    IF NEW.idProveedor <> OLD.idProveedor THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Productos', 'idProveedor', OLD.idProveedor, NEW.idProveedor, @id_empleado_sesion);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 5. ProductoDeleteAuditoriaAfter
CREATE TRIGGER ProductoDeleteAuditoriaAfter
AFTER DELETE ON Productos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
    VALUES ('Eliminacion', 'Productos', 'Nombre', OLD.Nombre, NULL, @id_empleado_sesion);
END$$
DELIMITER ;

DELIMITER $$
-- 6. ProductoInsertAuditoriaAfter
CREATE TRIGGER ProductoInsertAuditoriaAfter
AFTER INSERT ON Productos
FOR EACH ROW
BEGIN
    INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
    VALUES ('Creacion', 'Productos', 'Nombre', NULL, NEW.Nombre, @id_empleado_sesion);
END$$
DELIMITER ;

DELIMITER $$
-- 7. EmpleadosUpdateAuditoriaAfter
CREATE TRIGGER EmpleadosUpdateAuditoriaAfter
AFTER UPDATE ON Empleados
FOR EACH ROW
BEGIN
    -- Usuario
    IF NEW.Usuario <> OLD.Usuario THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Empleados', 'Usuario', OLD.Usuario, NEW.Usuario, @id_empleado_sesion);
    END IF;

    -- Contraseña (hash)
    IF NEW.Contraseña <> OLD.Contraseña THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Empleados', 'Contraseña', OLD.Contraseña, NEW.Contraseña, @id_empleado_sesion);
    END IF;

    -- Puesto
    IF NEW.Puesto <> OLD.Puesto THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Empleados', 'Puesto', OLD.Puesto, NEW.Puesto, @id_empleado_sesion);
    END IF;

    -- RFC
    IF NEW.RFC <> OLD.RFC THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Empleados', 'RFC', OLD.RFC, NEW.RFC, @id_empleado_sesion);
    END IF;

    -- NumeroSeguroSocial
    IF NEW.NumeroSeguroSocial <> OLD.NumeroSeguroSocial THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Empleados', 'NumeroSeguroSocial', OLD.NumeroSeguroSocial, NEW.NumeroSeguroSocial, @id_empleado_sesion);
    END IF;

END$$
DELIMITER ;

DELIMITER $$
-- 8. EmpleadosDeleteAuditoriaAfter
CREATE TRIGGER EmpleadosDeleteAuditoriaAfter
AFTER DELETE ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
    VALUES ('Eliminacion', 'Empleados', 'Usuario', OLD.Usuario, NULL, @id_empleado_sesion);
END$$
DELIMITER ;

DELIMITER $$
-- 9. EmpleadosInsertAuditoriaAfter
CREATE TRIGGER EmpleadosInsertAuditoriaAfter
AFTER INSERT ON Empleados
FOR EACH ROW
BEGIN
    INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
    VALUES ('Incorporacion', 'Empleados', 'Usuario', NULL, NEW.Usuario, NEW.idEmpleado);
END$$
DELIMITER ;


DELIMITER $$
-- 10. ClienteUpdateAuditoriaAfter
CREATE TRIGGER ClienteUpdateAuditoriaAfter
AFTER UPDATE ON Clientes
FOR EACH ROW
BEGIN
    -- Crédito
    IF NEW.Credito <> OLD.Credito THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Clientes', 'Credito', OLD.Credito, NEW.Credito, @id_empleado_sesion);
    END IF;

    -- Límite
    IF NEW.Limite <> OLD.Limite THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Clientes', 'Limite', OLD.Limite, NEW.Limite, @id_empleado_sesion);
    END IF;

    -- idDescuento
    IF NEW.idDescuento <> OLD.idDescuento THEN
        INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
        VALUES ('Modificacion', 'Clientes', 'idDescuento', OLD.idDescuento, NEW.idDescuento, @id_empleado_sesion);
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 11. ClienteDeleteAuditoriaAfter
CREATE TRIGGER ClienteDeleteAuditoriaAfter
AFTER DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
    VALUES ('Eliminacion', 'Clientes', 'Credito', OLD.Credito, NULL, @id_empleado_sesion);
END$$
DELIMITER ;

DELIMITER $$
-- 12. ClienteInsertAuditoriaAfter
CREATE TRIGGER ClienteInsertAuditoriaAfter
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO HistorialModificaciones (Movimiento, TablaAfectada, ColumnaAfectada, DatoAnterior, DatoNuevo, idEmpleado)
    VALUES ('Agregacion', 'Clientes', 'Credito', NULL, NEW.Credito, @id_empleado_sesion);
END$$
DELIMITER ;

DELIMITER $$
-- 13. EmpleadoUpdateBefore
CREATE TRIGGER EmpleadoUpdateBefore
BEFORE UPDATE ON Empleados
FOR EACH ROW
BEGIN
    IF NEW.Usuario IS NULL OR NEW.Contraseña IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Usuario y contraseña no pueden ser nulos.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 14. EmpleadoInsertBefore
CREATE TRIGGER EmpleadoInsertBefore
BEFORE INSERT ON Empleados
FOR EACH ROW
BEGIN
    IF NEW.Usuario IS NULL OR NEW.Contraseña IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Usuario y contraseña no pueden ser nulos.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 15. ProductoUpdateBefore
CREATE TRIGGER ProductoUpdateBefore
BEFORE UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF NEW.Stock = 0 OR NEW.PrecioVenta < NEW.PrecioCompra THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock no puede ser 0 ni el precio de venta menor al de compra.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 16. ProductoInsertBefore
CREATE TRIGGER ProductoInsertBefore
BEFORE INSERT ON Productos
FOR EACH ROW
BEGIN
    IF NEW.Stock = 0 OR NEW.PrecioVenta < NEW.PrecioCompra THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock no puede ser 0 ni el precio de venta menor al de compra.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 17. ClienteUpdateBefore
CREATE TRIGGER ClienteUpdateBefore
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.Credito > NEW.Limite THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El crédito no puede superar el límite.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 18. ClienteInsertBefore
CREATE TRIGGER ClienteInsertBefore
BEFORE INSERT ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.Credito > NEW.Limite THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El crédito no puede superar el límite.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 19. AfterInsertVentaClearCarrito
CREATE TRIGGER AfterInsertVentaClearCarrito
AFTER INSERT ON Ventas
FOR EACH ROW
BEGIN
    DELETE FROM Temp_Ventas
    WHERE idEmpleado = NEW.idEmpleado;
END$$
DELIMITER ;

DELIMITER $$
-- 20. VentaCantidadBefore
CREATE TRIGGER VentaCantidadBefore
BEFORE INSERT ON DetalleVenta
FOR EACH ROW
BEGIN
    DECLARE stockDisponible INT;
    SELECT Stock INTO stockDisponible FROM Productos WHERE idProducto = NEW.idProducto;
    IF NEW.Cantidad > stockDisponible THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede vender más de lo disponible en stock.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$

-- 21. DevolucionCantidadBefore
CREATE TRIGGER DevolucionCantidadBefore
BEFORE INSERT ON DetallePedidos
FOR EACH ROW
BEGIN
    DECLARE cantidadVendida INT;
    SELECT Cantidad INTO cantidadVendida
    FROM DetalleVenta
    WHERE idProducto = NEW.idProducto
    LIMIT 1;

    IF NEW.Cantidad > cantidadVendida THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede devolver más de lo vendido.';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
-- 22. DescontarCantidadDespuesDeVenta
CREATE TRIGGER DescontarCantidadDespuesDeVenta
AFTER INSERT ON DetalleVenta
FOR EACH ROW
BEGIN
    -- Descontar stock del producto vendido
    UPDATE Productos
    SET Stock = Stock - NEW.Cantidad
    WHERE idProducto = NEW.idProducto;
END$$
DELIMITER ;


-- Vistas
-- 1. VistaVentasDiarias
CREATE OR REPLACE VIEW VistaVentasDiarias AS
SELECT 
    v.idVenta AS NumeroVenta,
    DATE(v.Fecha) AS Fecha,
    TIME(v.Fecha) AS Hora,
    
    CONCAT(emp.Nombre, ' ', emp.Paterno, ' ', emp.Materno) AS Empleado,
    CONCAT(cli.Nombre, ' ', cli.Paterno, ' ', cli.Materno) AS Cliente,
    
    p.Nombre AS Producto,
    dv.Cantidad,
    (dv.Total / dv.Cantidad) AS PrecioUnitario,
    dv.Total AS Subtotal,
    dv.IVA,
    dv.IEPS,
    IFNULL(dv.idDescuento, 0) AS Descuento,
    
    v.Monto AS TotalVenta,
    v.TipoPago,
    v.Estatus
FROM Ventas v
JOIN DetalleVenta dv ON v.idVenta = dv.idVenta
JOIN Productos p ON dv.idProducto = p.idProducto

JOIN Empleados e ON v.idEmpleado = e.idEmpleado
JOIN Personas emp ON e.idPersona = emp.idPersona

JOIN Clientes c ON v.idCliente = c.idCliente
JOIN Personas cli ON c.idPersona = cli.idPersona;


-- 2. VistaArticuloSimplificado
CREATE OR REPLACE VIEW VistaArticuloSimplificado AS
SELECT 
    Nombre, 
    Stock AS Cantidad, 
    PrecioVenta AS Precio
FROM Productos;

-- 3. VistaEmpleadosActivos
CREATE OR REPLACE VIEW VistaEmpleadosActivos AS
SELECT 
    e.idEmpleado,
    p.Nombre, p.Paterno, p.Materno,
    e.Puesto, e.Usuario
FROM Empleados e
JOIN Personas p ON e.idPersona = p.idPersona
WHERE p.Estatus = 'Activo';

-- 4. VistaEmpleadosInactivos
CREATE OR REPLACE VIEW VistaEmpleadosInactivos AS
SELECT 
    e.idEmpleado,
    p.Nombre, p.Paterno, p.Materno,
    e.Puesto, e.Usuario
FROM Empleados e
JOIN Personas p ON e.idPersona = p.idPersona
WHERE p.Estatus = 'Inactivo';

-- 5. VistaEstadoInventario
CREATE OR REPLACE VIEW VistaEstadoInventario AS
SELECT 
    p.Nombre AS Producto,
    c.Nombre AS Categoria,
    pr.Nombre AS Proveedor,
    p.Stock,
    p.PrecioCompra,
    p.PrecioVenta,
    p.Estado
FROM Productos p
JOIN Categorias c ON p.idCategoria = c.idCategoria
JOIN Proveedores pr ON p.idProveedor = pr.idProveedor;

-- 6. VistaClientesActivos
CREATE OR REPLACE VIEW VistaClientesActivos AS
SELECT 
    c.idCliente,
    p.Nombre, p.Paterno, p.Materno,
    c.Credito, c.Limite
FROM Clientes c
JOIN Personas p ON c.idPersona = p.idPersona
WHERE p.Estatus = 'Activo';

-- 7. VistaClientesInactivo
CREATE OR REPLACE VIEW VistaClientesInactivos AS
SELECT 
    c.idCliente,
    p.Nombre, p.Paterno, p.Materno,
    c.Credito, c.Limite
FROM Clientes c
JOIN Personas p ON c.idPersona = p.idPersona
WHERE p.Estatus = 'Inactivo';

-- 8. VistaPedidosPendientes
CREATE OR REPLACE VIEW VistaPedidosPendientes AS
SELECT 
    p.idPedido,
    p.Fecha,
    p.Hora,
    p.Estatus,
    cl.idCliente,
    pe.Nombre AS NombreCliente
FROM Pedidos p
JOIN Clientes cl ON p.idCliente = cl.idCliente
JOIN Personas pe ON cl.idPersona = pe.idPersona
WHERE p.Estatus = 'Pendiente';

-- 9. VistaPedidosAceptados
CREATE OR REPLACE VIEW VistaPedidosAceptados AS
SELECT 
    p.idPedido,
    p.Fecha,
    p.Hora,
    p.Estatus,
    cl.idCliente,
    pe.Nombre AS NombreCliente
FROM Pedidos p
JOIN Clientes cl ON p.idCliente = cl.idCliente
JOIN Personas pe ON cl.idPersona = pe.idPersona
WHERE p.Estatus = 'Aceptado';

-- 10. VistaPedidosEnviados
CREATE OR REPLACE VIEW VistaPedidosEnviados AS
SELECT 
    p.idPedido,
    p.Fecha,
    p.Hora,
    p.Estatus,
    cl.idCliente,
    pe.Nombre AS NombreCliente
FROM Pedidos p
JOIN Clientes cl ON p.idCliente = cl.idCliente
JOIN Personas pe ON cl.idPersona = pe.idPersona
WHERE p.Estatus = 'Enviado';

-- 11. VistaObtenerCarritoPorEmpleado
CREATE OR REPLACE VIEW VistaObtenerCarritoPorEmpleado AS
SELECT 
    t.idEmpleado,
    p.Nombre AS Producto,
    t.Cantidad,
    (p.PrecioVenta * t.Cantidad) AS Total
FROM Temp_Ventas t
JOIN Productos p ON t.idProducto = p.idProducto;



-- Impresiones PDF 
--Para usar las impresiones debemos de instalar la librería DomPDF

-- 1. Ticket de Venta 

<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// ID de la venta
$idVenta = $_GET['id'];

$query = "SELECT V.*, C.idCliente, CONCAT(P.Nombre,' ',P.Paterno,' ',P.Materno) AS ClienteNombre
          FROM Ventas V
          JOIN Clientes C ON V.idCliente = C.idCliente
          JOIN Personas P ON C.idPersona = P.idPersona
          WHERE V.idVenta = $idVenta";
$result = $conexion->query($query);
$venta = $result->fetch_assoc();

$query_detalle = "SELECT DV.*, P.Nombre 
                  FROM DetalleVenta DV
                  JOIN Productos P ON DV.idProducto = P.idProducto
                  WHERE idVenta = $idVenta";
$detalles = $conexion->query($query_detalle);

$html = '<h2>Ticket de Venta</h2>';
$html .= 'Cliente: ' . $venta['ClienteNombre'] . '<br>';
$html .= 'Fecha: ' . $venta['Fecha'] . '<br><hr>';
$html .= '<table width="100%" border="1" cellspacing="0" cellpadding="4">
<tr><th>Producto</th><th>Cantidad</th><th>Total</th></tr>';
while ($fila = $detalles->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['Nombre'].'</td><td>'.$fila['Cantidad'].'</td><td>$'.$fila['Total'].'</td></tr>';
}
$html .= '</table><hr>';
$html .= 'Subtotal: $' . $venta['Subtotal'] . '<br>';
$html .= 'IVA: $' . $venta['IVA'] . '<br>';
$html .= 'IEPS: $' . $venta['IEPS'] . '<br>';
$html .= '<strong>Total: $' . $venta['Monto'] . '</strong>';

// Generar PDF
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->render();
$dompdf->stream("ticket_venta_$idVenta.pdf", ["Attachment" => false]);
?>


2. Reporte de Ventas Diarias

$query = "SELECT * FROM VistaVentasDiarias";
$result = $conexion->query($query);

$html = '<h2>Reporte de Ventas Diarias</h2>';
$html .= '<table border="1" width="100%" cellpadding="4" cellspacing="0">
<tr><th>ID</th><th>Cliente</th><th>Monto</th><th>Pago</th><th>Estatus</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr>
    <td>'.$fila['idVenta'].'</td>
    <td>'.$fila['Cliente'].'</td>
    <td>$'.$fila['Monto'].'</td>
    <td>'.$fila['TipoPago'].'</td>
    <td>'.$fila['Estatus'].'</td>
    </tr>';
}
$html .= '</table>';


3. Estado de Inventario

$query = "SELECT * FROM VistaEstadoInventario";
$result = $conexion->query($query);

$html = '<h2>Estado de Inventario</h2>';
$html .= '<table border="1" width="100%" cellpadding="4">
<tr><th>Producto</th><th>Stock</th><th>Compra</th><th>Venta</th><th>Proveedor</th><th>Categoria</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr>
    <td>'.$fila['Nombre'].'</td>
    <td>'.$fila['Stock'].'</td>
    <td>$'.$fila['PrecioCompra'].'</td>
    <td>$'.$fila['PrecioVenta'].'</td>
    <td>'.$fila['Proveedor'].'</td>
    <td>'.$fila['Categoria'].'</td>
    </tr>';
}
$html .= '</table>';


4. Reporte de Pedidos Pendientes / Recibidos

$query1 = "SELECT * FROM VistaPedidosPendientes";
$query2 = "SELECT * FROM VistaPedidosRecibidos";

$result1 = $conexion->query($query1);
$result2 = $conexion->query($query2);

$html = '<h2>Pedidos Pendientes</h2><table border="1">
<tr><th>ID</th><th>Cliente</th><th>Fecha</th><th>Hora</th><th>Estatus</th></tr>';
while ($fila = $result1->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['idPedido'].'</td><td>'.$fila['Cliente'].'</td><td>'.$fila['Fecha'].'</td><td>'.$fila['Hora'].'</td><td>'.$fila['Estatus'].'</td></tr>';
}
$html .= '</table><hr>';

$html .= '<h2>Pedidos Recibidos</h2><table border="1">
<tr><th>ID</th><th>Cliente</th><th>Fecha</th><th>Hora</th><th>Estatus</th></tr>';
while ($fila = $result2->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['idPedido'].'</td><td>'.$fila['Cliente'].'</td><td>'.$fila['Fecha'].'</td><td>'.$fila['Hora'].'</td><td>'.$fila['Estatus'].'</td></tr>';
}
$html .= '</table>';

5. Lista de Clientes Activos

$query = "SELECT * FROM VistaClientesActivos";
$result = $conexion->query($query);

$html = '<h2>Lista de Clientes Activos</h2><table border="1">
<tr><th>Nombre</th><th>Teléfono</th><th>Email</th><th>Crédito</th><th>Límite</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['NombreCompleto'].'</td><td>'.$fila['Telefono'].'</td><td>'.$fila['Email'].'</td><td>$'.$fila['Credito'].'</td><td>$'.$fila['Limite'].'</td></tr>';
}
$html .= '</table>';

6. Lista de Empleados Activos

$query = "SELECT * FROM VistaEmpleadosActivos";
$result = $conexion->query($query);

$html = '<h2>Empleados Activos</h2><table border="1">
<tr><th>Nombre</th><th>Puesto</th><th>Teléfono</th><th>Email</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['NombreCompleto'].'</td><td>'.$fila['Puesto'].'</td><td>'.$fila['Telefono'].'</td><td>'.$fila['Email'].'</td></tr>';
}
$html .= '</table>';

7. Lista de Proveedores Activos

$query = "SELECT * FROM VistaProveedoresActivos";
$result = $conexion->query($query);

$html = '<h2>Lista de Proveedores</h2><table border="1"><tr><th>ID</th><th>Nombre</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['idProveedor'].'</td><td>'.$fila['Nombre'].'</td></tr>';
}
$html .= '</table>';


-- Después de construir $html, en todos los casos, agrega esto al final para generar el PDF:

php
Copy
Edit
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("reporte.pdf", ["Attachment" => false]); // Cambia nombre según el reporte

-- Procedimientos Almacenados 

DELIMITER $$

CREATE PROCEDURE AgregarProducto (
    IN p_Nombre VARCHAR(100),
    IN p_PrecioCompra DECIMAL(10,2),
    IN p_PrecioVenta DECIMAL(10,2),
    IN p_CodigoBarras BIGINT,
    IN p_Stock INT,
    IN p_idCategoria INT,
    IN p_idProveedor INT
)
BEGIN
    INSERT INTO Productos (
        Nombre, PrecioCompra, PrecioVenta, CodigoBarras,
        Stock, Estado, idCategoria, idProveedor
    )
    VALUES (
        p_Nombre, p_PrecioCompra, p_PrecioVenta, p_CodigoBarras,
        p_Stock, 'Activo', p_idCategoria, p_idProveedor
    );
END$$

CREATE PROCEDURE ActualizarProductoCompleto (
    IN p_idProducto INT,
    IN p_Nombre VARCHAR(100),
    IN p_PrecioCompra DECIMAL(10,2),
    IN p_PrecioVenta DECIMAL(10,2),
    IN p_CodigoBarras BIGINT,
    IN p_Stock INT,
    IN p_idCategoria INT,
    IN p_idProveedor INT
)
BEGIN
    UPDATE Productos
    SET 
        Nombre = p_Nombre,
        PrecioCompra = p_PrecioCompra,
        PrecioVenta = p_PrecioVenta,
        CodigoBarras = p_CodigoBarras,
        Stock = p_Stock,
        idCategoria = p_idCategoria,
        idProveedor = p_idProveedor
    WHERE idProducto = p_idProducto;
END$$

CREATE PROCEDURE EliminarProducto (
    IN p_idProducto INT
)
BEGIN
    UPDATE Productos
    SET Estado = 'Inactivo'
    WHERE idProducto = p_idProducto;
END$$

-- Metodos de Busqueda

CREATE PROCEDURE BuscarProductoPorNombre (
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT * FROM Producto
    WHERE nombre LIKE CONCAT('%', p_nombre, '%') AND estatus = 'Activo';
END$$

CREATE PROCEDURE BuscarProductoPorCodigoBarras (
    IN p_codigo_barras VARCHAR(50)
)
BEGIN
    SELECT * FROM Producto
    WHERE codigo_barras = p_codigo_barras AND estatus = 'Activo';
END$$

--

CREATE PROCEDURE AgregarEmpleado (
    IN p_Nombre VARCHAR(50),
    IN p_Paterno VARCHAR(50),
    IN p_Materno VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Email VARCHAR(50),
    IN p_Edad SMALLINT,
    IN p_Sexo ENUM('H','M'),
    IN p_idDomicilio INT,
    IN p_Puesto ENUM('Administrador', 'Cajero', 'Agente de Venta'),
    IN p_RFC VARCHAR(13),
    IN p_NumeroSeguroSocial VARCHAR(11),
    IN p_Usuario VARCHAR(255),
    IN p_Contrasena VARCHAR(255)
)
BEGIN
    DECLARE nuevo_idPersona INT;

    -- Insertar en Personas
    INSERT INTO Personas (
        Nombre, Paterno, Materno, Telefono, Email, Edad, Sexo, Estatus, idDomicilio
    ) VALUES (
        p_Nombre, p_Paterno, p_Materno, p_Telefono, p_Email, p_Edad, p_Sexo, 'Activo', p_idDomicilio
    );

    SET nuevo_idPersona = LAST_INSERT_ID();

    -- Insertar en Empleados
    INSERT INTO Empleados (
        Puesto, RFC, NumeroSeguroSocial, Usuario, Contraseña, idPersona
    ) VALUES (
        p_Puesto, p_RFC, p_NumeroSeguroSocial, p_Usuario, p_Contrasena, nuevo_idPersona
    );
END$$


CREATE PROCEDURE ActualizarEmpleado (
    IN p_idEmpleado INT,
    IN p_Nombre VARCHAR(50),
    IN p_Paterno VARCHAR(50),
    IN p_Materno VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Email VARCHAR(50),
    IN p_Edad SMALLINT,
    IN p_Sexo ENUM('H','M'),
    IN p_idDomicilio INT,
    IN p_Puesto ENUM('Administrador', 'Cajero', 'Agente de Venta'),
    IN p_RFC VARCHAR(13),
    IN p_NumeroSeguroSocial VARCHAR(11),
    IN p_Usuario VARCHAR(255),
    IN p_Contrasena VARCHAR(255)
)
BEGIN
    DECLARE persona_id INT;

    -- Obtener el idPersona vinculado al empleado
    SELECT idPersona INTO persona_id
    FROM Empleados
    WHERE idEmpleado = p_idEmpleado;

    -- Actualizar en Personas
    UPDATE Personas
    SET Nombre = p_Nombre,
        Paterno = p_Paterno,
        Materno = p_Materno,
        Telefono = p_Telefono,
        Email = p_Email,
        Edad = p_Edad,
        Sexo = p_Sexo,
        idDomicilio = p_idDomicilio
    WHERE idPersona = persona_id;

    -- Actualizar en Empleados
    UPDATE Empleados
    SET Puesto = p_Puesto,
        RFC = p_RFC,
        NumeroSeguroSocial = p_NumeroSeguroSocial,
        Usuario = p_Usuario,
        Contraseña = p_Contrasena
    WHERE idEmpleado = p_idEmpleado;
END$$


CREATE PROCEDURE EliminarEmpleado (
    IN p_idEmpleado INT
)
BEGIN
    DECLARE persona_id INT;

    SELECT idPersona INTO persona_id
    FROM Empleados
    WHERE idEmpleado = p_idEmpleado;

    UPDATE Personas
    SET Estatus = 'Inactivo'
    WHERE idPersona = persona_id;
END$$


--

CREATE PROCEDURE AgregarCliente (
    IN p_Nombre VARCHAR(50),
    IN p_Paterno VARCHAR(50),
    IN p_Materno VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Email VARCHAR(50),
    IN p_Edad SMALLINT,
    IN p_Sexo ENUM('H','M'),
    IN p_idDomicilio INT,
    IN p_Credito DECIMAL(10,2),
    IN p_Limite DECIMAL(10,2),
    IN p_idDescuento INT
)
BEGIN
    DECLARE nuevo_idPersona INT;

    -- Insertar en Personas
    INSERT INTO Personas (
        Nombre, Paterno, Materno, Telefono, Email, Edad, Sexo, Estatus, idDomicilio
    ) VALUES (
        p_Nombre, p_Paterno, p_Materno, p_Telefono, p_Email, p_Edad, p_Sexo, 'Activo', p_idDomicilio
    );

    SET nuevo_idPersona = LAST_INSERT_ID();

    -- Insertar en Clientes
    INSERT INTO Clientes (
        Credito, Limite, idPersona, idDescuento
    ) VALUES (
        p_Credito, p_Limite, nuevo_idPersona, p_idDescuento
    );
END$$

CREATE PROCEDURE ActualizarCliente (
    IN p_idCliente INT,
    IN p_Nombre VARCHAR(50),
    IN p_Paterno VARCHAR(50),
    IN p_Materno VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Email VARCHAR(50),
    IN p_Edad SMALLINT,
    IN p_Sexo ENUM('H','M'),
    IN p_idDomicilio INT,
    IN p_Credito DECIMAL(10,2),
    IN p_Limite DECIMAL(10,2),
    IN p_idDescuento INT
)
BEGIN
    DECLARE persona_id INT;

    -- Obtener idPersona correspondiente al cliente
    SELECT idPersona INTO persona_id
    FROM Clientes
    WHERE idCliente = p_idCliente;

    -- Actualizar Persona
    UPDATE Personas
    SET Nombre = p_Nombre,
        Paterno = p_Paterno,
        Materno = p_Materno,
        Telefono = p_Telefono,
        Email = p_Email,
        Edad = p_Edad,
        Sexo = p_Sexo,
        idDomicilio = p_idDomicilio
    WHERE idPersona = persona_id;

    -- Actualizar Cliente
    UPDATE Clientes
    SET Credito = p_Credito,
        Limite = p_Limite,
        idDescuento = p_idDescuento
    WHERE idCliente = p_idCliente;
END$$

CREATE PROCEDURE EliminarCliente (
    IN p_idCliente INT
)
BEGIN
    DECLARE persona_id INT;

    SELECT idPersona INTO persona_id
    FROM Clientes
    WHERE idCliente = p_idCliente;

    -- Solo baja lógica en Personas
    UPDATE Personas
    SET Estatus = 'Inactivo'
    WHERE idPersona = persona_id;
END$$

--

CREATE PROCEDURE AgregarProveedor (
    IN p_nombre VARCHAR(100)
)
BEGIN
    INSERT INTO Proveedores (Nombre, Estado)
    VALUES (p_nombre, 'Activo');
END$$

CREATE PROCEDURE EliminarProveedor (
    IN p_id_proveedor INT
)
BEGIN
    UPDATE Proveedores
    SET Estado = 'Inactivo'
    WHERE idProveedor = p_id_proveedor;
END$$

CREATE PROCEDURE ActualizarProveedor (
    IN p_id_proveedor INT,
    IN p_nombre VARCHAR(100),
    IN p_estado ENUM('Activo', 'Inactivo')
)
BEGIN
    UPDATE Proveedores
    SET Nombre = p_nombre,
        Estado = p_estado
    WHERE idProveedor = p_id_proveedor;
END$$

--

CREATE PROCEDURE RegistrarPedido (
    IN p_id_cliente INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_productos JSON
)
BEGIN
    DECLARE v_id_pedido INT;

    START TRANSACTION;

    INSERT INTO Pedidos (idCliente, idEmpleado, Fecha, Estatus)
    VALUES (p_id_cliente, p_id_empleado, p_fecha, 'Pendiente');

    SET v_id_pedido = LAST_INSERT_ID();

    -- Insertar detalles del pedido
    INSERT INTO DetallePedidos (idPedido, idProducto, Cantidad, PrecioUnitario)
    SELECT
        v_id_pedido,
        CAST(JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.id_producto')) AS UNSIGNED),
        CAST(JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.cantidad')) AS UNSIGNED),
        CAST(JSON_UNQUOTE(JSON_EXTRACT(j.value, '$.precioUnitario')) AS DECIMAL(10,2))
    FROM JSON_TABLE(p_productos, "$[*]"
        COLUMNS (value JSON PATH "$")
    ) AS j;

    COMMIT;
END$$


CREATE PROCEDURE CambiaEstatusPedido (
    IN p_id_pedido INT,
    IN p_estatus ENUM('Pendiente', 'Aceptado', 'Enviado', 'Cancelado')
)
BEGIN
    UPDATE Pedidos
    SET Estatus = p_estatus
    WHERE idPedido = p_id_pedido;
END$$

--

CREATE PROCEDURE AgregarAlCarrito (
    IN p_id_empleado INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_stock INT;

    -- Obtener el stock actual del producto
    SELECT stock INTO v_stock FROM Productos WHERE idProducto = p_id_producto;

    IF p_cantidad <= v_stock THEN
        INSERT INTO Temp_Ventas (idEmpleado, idProducto, Cantidad)
        VALUES (p_id_empleado, p_id_producto, p_cantidad)
        ON DUPLICATE KEY UPDATE Cantidad = Cantidad + p_cantidad;
    END IF;
END$$


CREATE PROCEDURE SumarCantidadProductoCarrito (
    IN p_id_empleado INT,
    IN p_id_producto INT
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_cantidad INT;

    SELECT stock INTO v_stock FROM Productos WHERE idProducto = p_id_producto;
    SELECT Cantidad INTO v_cantidad FROM Temp_Ventas WHERE idEmpleado = p_id_empleado AND idProducto = p_id_producto;

    IF v_cantidad < v_stock THEN
        UPDATE Temp_Ventas
        SET Cantidad = Cantidad + 1
        WHERE idEmpleado = p_id_empleado AND idProducto = p_id_producto;
    END IF;
END$$


CREATE PROCEDURE RestarCantidadProductoCarrito (
    IN p_id_empleado INT,
    IN p_id_producto INT
)
BEGIN
    DECLARE v_cantidad INT;

    SELECT Cantidad INTO v_cantidad FROM Temp_Ventas WHERE idEmpleado = p_id_empleado AND idProducto = p_id_producto;

    IF v_cantidad > 1 THEN
        UPDATE Temp_Ventas
        SET Cantidad = Cantidad - 1
        WHERE idEmpleado = p_id_empleado AND idProducto = p_id_producto;
    ELSE
        DELETE FROM Temp_Ventas
        WHERE idEmpleado = p_id_empleado AND idProducto = p_id_producto;
    END IF;
END$$


CREATE PROCEDURE ProcesarUnaVenta (
    IN p_id_empleado INT,
    IN p_id_cliente INT,
    IN p_tipo_pago ENUM('Contado', 'Cheque', 'Transferencia', 'Credito'),
    IN p_pago DECIMAL(10,2)
)
BEGIN
    DECLARE v_subtotal DECIMAL(10,2);
    DECLARE v_iva DECIMAL(10,2);
    DECLARE v_ieps DECIMAL(10,2);
    DECLARE v_monto DECIMAL(10,2);
    DECLARE v_cantidad_productos INT;
    DECLARE v_id_venta INT;

    -- Calcular subtotal, IVA, IEPS y cantidad de productos sumados
    SELECT 
        SUM(p.Precio * t.Cantidad),
        SUM(p.Precio * t.Cantidad * 0.16), -- Ejemplo IVA 16%
        SUM(p.Precio * t.Cantidad * 0.08), -- Ejemplo IEPS 8%
        SUM(t.Cantidad)
    INTO 
        v_subtotal, v_iva, v_ieps, v_cantidad_productos
    FROM Temp_Ventas t
    JOIN Productos p ON t.idProducto = p.idProducto
    WHERE t.idEmpleado = p_id_empleado;

    SET v_monto = v_subtotal + v_iva + v_ieps;

    -- Insertar la venta
    INSERT INTO Ventas (Monto, Fecha, Subtotal, IVA, IEPS, CantidadProductos, TipoPago, Estatus, idCliente, idEmpleado)
    VALUES (v_monto, NOW(), v_subtotal, v_iva, v_ieps, v_cantidad_productos, p_tipo_pago, 
        CASE WHEN p_tipo_pago = 'Credito' THEN 'En Espera de Pago' ELSE 'Pagada' END, 
        p_id_cliente, p_id_empleado);

    SET v_id_venta = LAST_INSERT_ID();

    -- Insertar el detalle de la venta
    INSERT INTO DetalleVenta (Cantidad, Total, IVA, IEPS, idVenta, idProducto, idDescuento)
    SELECT 
        t.Cantidad,
        p.Precio * t.Cantidad,
        p.Precio * t.Cantidad * 0.16, -- IVA
        p.Precio * t.Cantidad * 0.08, -- IEPS
        v_id_venta,
        t.idProducto,
        NULL -- Puedes agregar lógica para descuentos si quieres
    FROM Temp_Ventas t
    JOIN Productos p ON t.idProducto = p.idProducto
    WHERE t.idEmpleado = p_id_empleado;

    -- Actualizar stock de productos
    UPDATE Productos p
    JOIN Temp_Ventas t ON p.idProducto = t.idProducto
    SET p.Stock = p.Stock - t.Cantidad
    WHERE t.idEmpleado = p_id_empleado;

    -- Limpiar carrito
    DELETE FROM Temp_Ventas WHERE idEmpleado = p_id_empleado;

    -- Insertar registro en Finanzas (invertido = 0 por simplificar, cambia según necesites)
    INSERT INTO Finanzas (idVenta, TotalVenta, Invertido)
    VALUES (v_id_venta, v_monto, 0);
END$$

--


CREATE PROCEDURE DevolverProductoIndividual (
    IN p_idVenta INT,
    IN p_idProducto INT
)
BEGIN
    DECLARE v_cantidad INT;

    -- Obtener la cantidad del producto en el detalle de venta
    SELECT Cantidad INTO v_cantidad FROM DetalleVenta
    WHERE idVenta = p_idVenta AND idProducto = p_idProducto;

    -- Actualizar el stock del producto sumando la cantidad devuelta
    UPDATE Productos
    SET stock = stock + v_cantidad
    WHERE idProducto = p_idProducto;

    -- Eliminar ese producto del detalle de la venta
    DELETE FROM DetalleVenta
    WHERE idVenta = p_idVenta AND idProducto = p_idProducto;
END$$


CREATE PROCEDURE DevolverVentaCompleta (
    IN p_idVenta INT
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_idProducto INT;
    DECLARE v_cantidad INT;

    DECLARE cur CURSOR FOR
        SELECT idProducto, Cantidad FROM DetalleVenta WHERE idVenta = p_idVenta;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_idProducto, v_cantidad;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Actualizar stock para cada producto de la venta
        UPDATE Productos
        SET stock = stock + v_cantidad
        WHERE idProducto = v_idProducto;
    END LOOP;

    CLOSE cur;

    -- Eliminar todos los detalles de la venta
    DELETE FROM DetalleVenta WHERE idVenta = p_idVenta;

    -- Eliminar la venta
    DELETE FROM Ventas WHERE idVenta = p_idVenta;
END$$

DELIMITER ;
