session_start();
$idEmpleado = $_SESSION['id'];
$conexion->query("SET @id_empleado_sesion := $idEmpleado"); -- Sin esta parte te va a marcas errores por que bloqueo de los triggers

- Triggers
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