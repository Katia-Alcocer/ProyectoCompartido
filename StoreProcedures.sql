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

CREATE PROCEDURE RecuperarProducto (
    IN p_idProducto INT
)
BEGIN
    UPDATE Productos
    SET Estado = 'Activo'
    WHERE idProducto = p_idProducto;
END$$


-- Metodos de Busqueda

CREATE PROCEDURE BuscarProductoPorNombre (
    IN p_nombre VARCHAR(100)
)
BEGIN
    SELECT * FROM Productos
    WHERE Nombre = p_nombre AND Estado = 'Activo';
END$$

CREATE PROCEDURE BuscarProductoPorCodigoBarras (
    IN p_codigo_barras VARCHAR(50)
)
BEGIN
    SELECT * FROM Productos
    WHERE CodigoBarras = p_codigo_barras AND Estado = 'Activo';
END$$

--
DELIMITER $$

CREATE PROCEDURE ActualizarCliente (
    IN p_idCliente INT,
    IN p_Nombre VARCHAR(50),
    IN p_Paterno VARCHAR(50),
    IN p_Materno VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Email VARCHAR(50),
    IN p_Edad SMALLINT,
    IN p_Sexo ENUM('H','M'),
    IN p_Credito DECIMAL(10,2),
    IN p_Limite DECIMAL(10,2),
    IN p_idDescuento INT,
    IN p_Calle VARCHAR(50),
    IN p_Numero INT,
    IN p_d_CP VARCHAR(10)
)
BEGIN
    DECLARE persona_id INT;
    DECLARE domicilio_id INT;
    DECLARE v_c_CP INT;

    -- Buscar el c_CP correspondiente al código postal legible (d_CP)
    SELECT c_CP INTO v_c_CP FROM CodigosPostales WHERE d_CP = p_d_CP LIMIT 1;

    -- Validar si se encontró el código postal
    IF v_c_CP IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Código postal no encontrado.';
    END IF;

    -- Obtener el idPersona vinculado al cliente
    SELECT idPersona INTO persona_id FROM Clientes WHERE idCliente = p_idCliente;

    -- Obtener idDomicilio actual de la persona
    SELECT idDomicilio INTO domicilio_id FROM Personas WHERE idPersona = persona_id;

    -- Actualizar domicilio con la nueva calle, número y c_CP
    UPDATE Domicilios
    SET Calle = p_Calle,
        Numero = p_Numero,
        c_CP = v_c_CP
    WHERE idDomicilio = domicilio_id;

    -- Actualizar en Personas
    UPDATE Personas
    SET Nombre = p_Nombre,
        Paterno = p_Paterno,
        Materno = p_Materno,
        Telefono = p_Telefono,
        Email = p_Email,
        Edad = p_Edad,
        Sexo = p_Sexo,
        idDomicilio = domicilio_id
    WHERE idPersona = persona_id;

    -- Actualizar en Clientes
    UPDATE Clientes
    SET Credito = p_Credito,
        Limite = p_Limite,
        idDescuento = p_idDescuento
    WHERE idCliente = p_idCliente;
END $$

DELIMITER ;

CREATE PROCEDURE RecuperarEmpleado (
    IN p_idEmpleado INT
)
BEGIN
    DECLARE persona_id INT;

    SELECT idPersona INTO persona_id
    FROM Empleados
    WHERE idEmpleado = p_idEmpleado;

    UPDATE Personas
    SET Estatus = 'Activo'
    WHERE idPersona = persona_id;
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
    IN p_idDescuento INT,
    IN p_Calle VARCHAR(50),
    IN p_Numero INT,
    IN p_d_CP VARCHAR(10)
)
BEGIN
    DECLARE persona_id INT;
    DECLARE v_c_CP INT;

    -- Obtener idPersona correspondiente al cliente
    SELECT idPersona INTO persona_id
    FROM Clientes
    WHERE idCliente = p_idCliente;

    -- Obtener c_CP a partir del d_CP
    SELECT c_CP INTO v_c_CP FROM CodigosPostales WHERE d_CP = p_d_CP LIMIT 1;

    IF v_c_CP IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Código postal no encontrado.';
    END IF;

    -- Actualizar domicilio
    UPDATE Domicilios
    SET Calle = p_Calle,
        Numero = p_Numero,
        c_CP = v_c_CP
    WHERE idDomicilio = p_idDomicilio;

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
END $$

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

CREATE PROCEDURE RecuperarCliente (
    IN p_idCliente INT
)
BEGIN
    DECLARE persona_id INT;

    SELECT idPersona INTO persona_id
    FROM Clientes
    WHERE idCliente = p_idCliente;

    -- Recuperación lógica en Personas
    UPDATE Personas
    SET Estatus = 'Activo'
    WHERE idPersona = persona_id;
END$$


--

CREATE PROCEDURE AgregarProveedor (
    IN p_nombre VARCHAR(100)
)
BEGIN
    INSERT INTO Proveedores (Nombre)
    VALUES (p_nombre);
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
    IN p_nombre VARCHAR(100)
)
BEGIN
    UPDATE Proveedores
    SET Nombre = p_nombre
    WHERE idProveedor = p_id_proveedor;
END$$

--

CREATE PROCEDURE RegistrarPedido (
    IN p_id_cliente INT,
    IN p_id_empleado INT,
    IN p_fecha DATE
)
BEGIN
    DECLARE v_id_pedido INT;

    START TRANSACTION;

    -- Insertar pedido
    INSERT INTO Pedidos (idCliente, idEmpleado, Fecha, Estatus)
    VALUES (p_id_cliente, p_id_empleado, p_fecha, 'Pendiente');

    SET v_id_pedido = LAST_INSERT_ID();

    -- Insertar detalles usando Temp_Ventas y precio actual de Productos
    INSERT INTO DetallePedidos (idPedido, idProducto, Cantidad, PrecioUnitario)
    SELECT
        v_id_pedido,
        tv.idProducto,
        tv.Cantidad,
        p.PrecioVenta -- o el campo que almacene el precio unitario
    FROM Temp_Ventas tv
    JOIN Productos p ON tv.idProducto = p.idProducto
    WHERE tv.idEmpleado = p_id_empleado;

    -- Vaciar carrito temporal para el empleado
    DELETE FROM Temp_Ventas WHERE idEmpleado = p_id_empleado;

    COMMIT;
END$$


-- Procedimiento para cambiar el estatus a 'Aceptado'
CREATE PROCEDURE CambiarPedidoAAceptado (
    IN p_id_pedido INT
)
BEGIN
    UPDATE Pedidos
    SET Estatus = 'Aceptado'
    WHERE idPedido = p_id_pedido;
END$$

-- Procedimiento para cambiar el estatus a 'Enviado'
CREATE PROCEDURE CambiarPedidoAEnviado (
    IN p_id_pedido INT
)
BEGIN
    UPDATE Pedidos
    SET Estatus = 'Enviado'
    WHERE idPedido = p_id_pedido;
END$$

-- Procedimiento para cambiar el estatus a 'Cancelado'
CREATE PROCEDURE CambiarPedidoACancelado (
    IN p_id_pedido INT
)
BEGIN
    UPDATE Pedidos
    SET Estatus = 'Cancelado'
    WHERE idPedido = p_id_pedido;
END$$

--

CREATE PROCEDURE AgregarAlCarrito (
    IN p_id_empleado INT,
    IN p_id_producto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_stock INT DEFAULT 0;
    DECLARE v_cantidad_actual INT DEFAULT 0;
    DECLARE v_cantidad_total INT DEFAULT 0;

    -- Obtener el stock actual del producto
    SELECT stock INTO v_stock FROM Productos WHERE idProducto = p_id_producto;

    -- Obtener la cantidad actual en el carrito para ese producto y empleado (si existe)
    SELECT Cantidad INTO v_cantidad_actual 
    FROM Temp_Ventas 
    WHERE idEmpleado = p_id_empleado AND idProducto = p_id_producto;

    IF v_cantidad_actual IS NULL THEN
        SET v_cantidad_actual = 0;
    END IF;

    SET v_cantidad_total = v_cantidad_actual + p_cantidad;

    -- Validar si la cantidad total no supera el stock
    IF v_cantidad_total <= v_stock THEN
        INSERT INTO Temp_Ventas (idEmpleado, idProducto, Cantidad)
        VALUES (p_id_empleado, p_id_producto, p_cantidad)
        ON DUPLICATE KEY UPDATE Cantidad = Cantidad + p_cantidad;
    ELSE
        -- Opcional: aquí podrías lanzar un error o hacer otra acción si se excede el stock
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cantidad solicitada excede el stock disponible.';
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
    DECLARE v_cliente INT;
    DECLARE v_credito_cliente DECIMAL(10,2);
    DECLARE v_limite_cliente DECIMAL(10,2);

    -- Asignar cliente: si no es válido, asignar 0 (cliente genérico)
    SET v_cliente = IF(p_id_cliente IS NULL OR p_id_cliente <= 0, 0, p_id_cliente);

    -- Calcular subtotal, IVA, IEPS y cantidad de productos sumados
    SELECT 
        SUM(p.PrecioVenta * t.Cantidad),
        SUM(p.PrecioVenta * t.Cantidad * 0.16), -- IVA 16%
        SUM(p.PrecioVenta * t.Cantidad * 0.08), -- IEPS 8%
        SUM(t.Cantidad)
    INTO 
        v_subtotal, v_iva, v_ieps, v_cantidad_productos
    FROM Temp_Ventas t
    JOIN Productos p ON t.idProducto = p.idProducto
    WHERE t.idEmpleado = p_id_empleado;

    SET v_monto = v_subtotal + v_iva + v_ieps;

    -- Si es venta a credito, validar que cliente tenga suficiente credito
    IF p_tipo_pago = 'Credito' THEN
        SELECT Credito, Limite
        INTO v_credito_cliente, v_limite_cliente
        FROM Clientes
        WHERE idCliente = v_cliente
        FOR UPDATE;

        IF v_cliente = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente generico no puede comprar a credito.';
        END IF;

        IF v_credito_cliente < v_monto THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Credito insuficiente para realizar la venta.';
        END IF;

        -- Descontar el credito del cliente
        UPDATE Clientes
        SET Credito = Credito - v_monto
        WHERE idCliente = v_cliente;
    END IF;

    -- Insertar la venta
    INSERT INTO Ventas (Monto, Fecha, Subtotal, IVA, IEPS, CantidadProductos, TipoPago, Estatus, idCliente, idEmpleado)
    VALUES (v_monto, NOW(), v_subtotal, v_iva, v_ieps, v_cantidad_productos, p_tipo_pago, 
        CASE WHEN p_tipo_pago = 'Credito' THEN 'En Espera de Pago' ELSE 'Pagada' END, 
        v_cliente, p_id_empleado);

    SET v_id_venta = LAST_INSERT_ID();

    -- Insertar el detalle de la venta
    INSERT INTO DetalleVenta (Cantidad, Total, IVA, IEPS, idVenta, idProducto, idDescuento)
    SELECT 
        t.Cantidad,
        p.PrecioVenta * t.Cantidad,
        p.PrecioVenta * t.Cantidad * 0.16, -- IVA
        p.PrecioVenta * t.Cantidad * 0.08, -- IEPS
        v_id_venta,
        t.idProducto,
        NULL -- Aquí puedes añadir lógica para descuentos si quieres
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

    -- Insertar registro en Finanzas (invertido = 0 para simplificar, cambia según necesites)
    INSERT INTO Finanzas (idVenta, TotalVenta, Invertido)
    VALUES (v_id_venta, v_monto, 0);
END$$

CREATE PROCEDURE ProcesarVentaDePedido (
    IN p_id_pedido INT
)
BEGIN
    DECLARE v_id_empleado INT;
    DECLARE v_id_cliente INT;
    DECLARE v_tipo_pago ENUM('Contado', 'Cheque', 'Transferencia', 'Credito');
    DECLARE v_subtotal DECIMAL(10,2);
    DECLARE v_iva DECIMAL(10,2);
    DECLARE v_ieps DECIMAL(10,2);
    DECLARE v_monto DECIMAL(10,2);
    DECLARE v_cantidad_productos INT;
    DECLARE v_id_venta INT;
    DECLARE v_credito_cliente DECIMAL(10,2);
    DECLARE v_limite_cliente DECIMAL(10,2);

    -- Establecer tipo de pago fijo (puedes cambiarlo si quieres)
    SET v_tipo_pago = 'Credito';

    -- Obtener datos del pedido
    SELECT idEmpleado, idCliente
    INTO v_id_empleado, v_id_cliente
    FROM Pedidos
    WHERE idPedido = p_id_pedido;

    -- Calcular totales del pedido a partir de DetallePedidos y Productos
    SELECT
        SUM(dp.Cantidad * dp.PrecioUnitario),
        SUM(dp.Cantidad * dp.PrecioUnitario * 0.16),
        SUM(dp.Cantidad * dp.PrecioUnitario * 0.08),
        SUM(dp.Cantidad)
    INTO
        v_subtotal, v_iva, v_ieps, v_cantidad_productos
    FROM DetallePedidos dp
    WHERE dp.idPedido = p_id_pedido;

    SET v_monto = v_subtotal + v_iva + v_ieps;

    -- Validar crédito si es pago a credito
    IF v_tipo_pago = 'Credito' THEN
        IF v_id_cliente = 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente genérico no puede comprar a crédito.';
        END IF;

        SELECT Credito, Limite
        INTO v_credito_cliente, v_limite_cliente
        FROM Clientes
        WHERE idCliente = v_id_cliente
        FOR UPDATE;

        IF v_credito_cliente < v_monto THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Crédito insuficiente para realizar la venta.';
        END IF;

        -- Descontar crédito
        UPDATE Clientes SET Credito = Credito - v_monto WHERE idCliente = v_id_cliente;
    END IF;

    -- Insertar la venta
    INSERT INTO Ventas (Monto, Fecha, Subtotal, IVA, IEPS, CantidadProductos, TipoPago, Estatus, idCliente, idEmpleado)
    VALUES (v_monto, NOW(), v_subtotal, v_iva, v_ieps, v_cantidad_productos, v_tipo_pago,
            CASE WHEN v_tipo_pago = 'Credito' THEN 'En Espera de Pago' ELSE 'Pagada' END,
            v_id_cliente, v_id_empleado);

    SET v_id_venta = LAST_INSERT_ID();

    -- Insertar detalle venta copiando de detalle pedido
    INSERT INTO DetalleVenta (Cantidad, Total, IVA, IEPS, idVenta, idProducto, idDescuento)
    SELECT 
        dp.Cantidad,
        dp.Cantidad * dp.PrecioUnitario,
        dp.Cantidad * dp.PrecioUnitario * 0.16,
        dp.Cantidad * dp.PrecioUnitario * 0.08,
        v_id_venta,
        dp.idProducto,
        NULL
    FROM DetallePedidos dp
    WHERE dp.idPedido = p_id_pedido;

    -- Actualizar stock
    UPDATE Productos p
    JOIN DetallePedidos dp ON p.idProducto = dp.idProducto
    SET p.Stock = p.Stock - dp.Cantidad
    WHERE dp.idPedido = p_id_pedido;

    -- Actualizar estatus del pedido a 'Procesado'
    UPDATE Pedidos SET Estatus = 'Procesado' WHERE idPedido = p_id_pedido;

    -- Registrar movimiento financiero
    INSERT INTO Finanzas (idVenta, TotalVenta, Invertido)
    VALUES (v_id_venta, v_monto, 0);

END$$

--
DELIMITER $$

DELIMITER $$

CREATE PROCEDURE DevolverProductoIndividual(
    IN p_idVenta INT,
    IN p_idProducto INT,
    IN p_cantidad INT
)
BEGIN
    DECLARE v_cantidadVendida INT DEFAULT 0;
    DECLARE v_totalProducto DECIMAL(10,2);
    DECLARE v_ivaProducto DECIMAL(10,2);
    DECLARE v_iepsProducto DECIMAL(10,2);
    DECLARE v_cantidadActualVentas INT DEFAULT 0;

    -- Validar existencia del producto en la venta y obtener detalles
    SELECT Cantidad, Total, IVA, IEPS
    INTO v_cantidadVendida, v_totalProducto, v_ivaProducto, v_iepsProducto
    FROM DetalleVenta
    WHERE idVenta = p_idVenta AND idProducto = p_idProducto;

    -- Validaciones
    IF v_cantidadVendida IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto no fue encontrado en la venta.';
    ELSEIF p_cantidad <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad a devolver debe ser mayor que cero.';
    ELSEIF p_cantidad > v_cantidadVendida THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede devolver más de lo vendido.';
    ELSE
        -- Actualizar la cantidad en DetalleVenta
        UPDATE DetalleVenta
        SET Cantidad = Cantidad - p_cantidad,
            Total = Total - (v_totalProducto / v_cantidadVendida) * p_cantidad,
            IVA = IVA - (v_ivaProducto / v_cantidadVendida) * p_cantidad,
            IEPS = IEPS - (v_iepsProducto / v_cantidadVendida) * p_cantidad
        WHERE idVenta = p_idVenta AND idProducto = p_idProducto;

        -- Eliminar el detalle si la cantidad queda en 0
        DELETE FROM DetalleVenta
        WHERE idVenta = p_idVenta AND idProducto = p_idProducto AND Cantidad = 0;

        -- Devolver productos al inventario
        UPDATE Productos
        SET stock = stock + p_cantidad
        WHERE idProducto = p_idProducto;

        -- Recalcular cantidad total de productos en la venta
        SELECT IFNULL(SUM(Cantidad),0)
        INTO v_cantidadActualVentas
        FROM DetalleVenta
        WHERE idVenta = p_idVenta;

        -- Actualizar la cantidad total de productos en Ventas restando la cantidad devuelta
        UPDATE Ventas
        SET CantidadProductos = v_cantidadActualVentas
        WHERE idVenta = p_idVenta;

        -- Recalcular totales de la venta basados en detalles actualizados
        UPDATE Ventas v
        JOIN (
            SELECT 
                idVenta,
                IFNULL(SUM(Total), 0) AS nuevo_total,
                IFNULL(SUM(IVA), 0) AS nuevo_iva,
                IFNULL(SUM(IEPS), 0) AS nuevo_ieps
            FROM DetalleVenta
            WHERE idVenta = p_idVenta
            GROUP BY idVenta
        ) dv ON v.idVenta = dv.idVenta
        SET 
            v.Subtotal = dv.nuevo_total,
            v.IVA = dv.nuevo_iva,
            v.IEPS = dv.nuevo_ieps,
            v.Monto = dv.nuevo_total + dv.nuevo_iva + dv.nuevo_ieps;

        -- Si ya no quedan productos en la venta, actualizar el estatus y totales a cero
        IF v_cantidadActualVentas = 0 THEN
            UPDATE Ventas
            SET Estatus = 'Cancelada',
                Subtotal = 0,
                IVA = 0,
                IEPS = 0,
                Monto = 0,
                CantidadProductos = 0
            WHERE idVenta = p_idVenta;
        END IF;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE DevolverVentaCompleta (
    IN p_idVenta INT
)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE v_idProducto INT;
    DECLARE v_cantidad INT;

    -- Cursor para recorrer los productos de la venta
    DECLARE cur CURSOR FOR
        SELECT idProducto, Cantidad FROM DetalleVenta WHERE idVenta = p_idVenta;

    -- Manejador cuando se terminan los datos del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_idProducto, v_cantidad;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Devolver la cantidad al stock del producto
        UPDATE Productos
        SET stock = stock + v_cantidad
        WHERE idProducto = v_idProducto;
    END LOOP;

    CLOSE cur;

    -- Eliminar los detalles de la venta (productos vendidos)
    DELETE FROM DetalleVenta WHERE idVenta = p_idVenta;

    -- Actualizar la venta: marcar como cancelada y resetear valores
    UPDATE Ventas
    SET Estatus = 'Cancelada',
        Monto = 0,
        Subtotal = 0,
        IVA = 0,
        IEPS = 0,
        CantidadProductos = 0
    WHERE idVenta = p_idVenta;
END$$

DELIMITER ;


DELIMITER ;


CREATE PROCEDURE sp_ObtenerCarritoPorEmpleado(IN empleadoId INT)
BEGIN
    SELECT 
        tv.idProducto,
        p.Nombre,
        tv.Cantidad,
        p.PrecioVenta,
        (p.PrecioVenta * tv.Cantidad) AS Total
    FROM Temp_Ventas tv
    INNER JOIN Productos p ON tv.idProducto = p.idProducto
    WHERE tv.idEmpleado = empleadoId;
END $$

CREATE PROCEDURE InsertarDomicilioPorID(
    IN p_Calle VARCHAR(50),
    IN p_Numero INT,
    IN p_c_CP INT
)
BEGIN
    -- Verificar si el c_CP existe en la tabla CodigosPostales
    IF EXISTS (
        SELECT 1 FROM CodigosPostales WHERE c_CP = p_c_CP
    ) THEN
        -- Insertar en la tabla Domicilios
        INSERT INTO Domicilios (Calle, Numero, c_CP)
        VALUES (p_Calle, p_Numero, p_c_CP);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El c_CP proporcionado no existe.';
    END IF;
END //


CREATE PROCEDURE RegistrarEmpleado(
    IN p_Nombre VARCHAR(50),
    IN p_Paterno VARCHAR(50),
    IN p_Materno VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Email VARCHAR(50),
    IN p_Edad SMALLINT,
    IN p_Sexo ENUM('H','M'),
    IN p_Calle VARCHAR(50),
    IN p_Numero INT,
    IN p_d_CP VARCHAR(10), -- Ahora se pasa el código postal real, como 36013
    IN p_Puesto ENUM('Administrador', 'Cajero', 'Agente de Venta'),
    IN p_RFC VARCHAR(13),
    IN p_NumeroSeguroSocial VARCHAR(11),
    IN p_Usuario VARCHAR(255),
    IN p_Contraseña VARCHAR(255)
)
BEGIN
    DECLARE v_idDomicilio INT;
    DECLARE v_idPersona INT;
    DECLARE v_c_CP INT;

    -- Buscar el c_CP correspondiente al código postal real (d_CP)
    SELECT c_CP INTO v_c_CP
    FROM CodigosPostales
    WHERE d_CP = p_d_CP
    LIMIT 1;

    -- Validar si se encontró el código
    IF v_c_CP IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El código postal proporcionado no existe en CodigosPostales.';
    END IF;

    -- Insertar domicilio
    INSERT INTO Domicilios (Calle, Numero, c_CP) VALUES (p_Calle, p_Numero, v_c_CP);
    SET v_idDomicilio = LAST_INSERT_ID();

    -- Insertar persona
    INSERT INTO Personas (Nombre, Paterno, Materno, Telefono, Email, Edad, Sexo, idDomicilio)
    VALUES (p_Nombre, p_Paterno, p_Materno, p_Telefono, p_Email, p_Edad, p_Sexo, v_idDomicilio);
    SET v_idPersona = LAST_INSERT_ID();

    -- Insertar empleado
    INSERT INTO Empleados (Puesto, RFC, NumeroSeguroSocial, Usuario, Contraseña, idPersona)
    VALUES (p_Puesto, p_RFC, p_NumeroSeguroSocial, p_Usuario, p_Contraseña, v_idPersona);
END //

CREATE PROCEDURE RegistrarCliente(
    IN p_Calle VARCHAR(50),
    IN p_Numero INT,
    IN p_d_CP VARCHAR(10),  -- Se recibe el código postal legible del formulario

    IN p_Nombre VARCHAR(50),
    IN p_Paterno VARCHAR(50),
    IN p_Materno VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Email VARCHAR(50),
    IN p_Edad SMALLINT,
    IN p_Sexo ENUM('H', 'M'),

    IN p_Credito DECIMAL(10,2),
    IN p_Limite DECIMAL(10,2),
    IN p_idDescuento INT
)
BEGIN
    DECLARE v_idDomicilio INT;
    DECLARE v_idPersona INT;
    DECLARE v_c_CP INT;
    DECLARE v_mensaje_error TEXT;

    START TRANSACTION;

    -- Obtener el c_CP a partir del d_CP
    SELECT c_CP INTO v_c_CP FROM CodigosPostales WHERE d_CP = p_d_CP LIMIT 1;

    -- Validar si se encontró el código postal
    IF v_c_CP IS NULL THEN
        SET v_mensaje_error = CONCAT('No se encontró c_CP para el código postal: ', p_d_CP);
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_mensaje_error;
    END IF;

    -- Verificar si ya existe la persona con teléfono o email
    IF EXISTS (
        SELECT 1 FROM Personas
        WHERE TRIM(Telefono) = TRIM(p_Telefono)
           OR LOWER(TRIM(Email)) = LOWER(TRIM(p_Email))
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya existe una persona con ese teléfono o email.';
    END IF;

    -- Insertar domicilio
    INSERT INTO Domicilios (Calle, Numero, c_CP)
    VALUES (p_Calle, p_Numero, v_c_CP);
    SET v_idDomicilio = LAST_INSERT_ID();

    -- Insertar persona
    INSERT INTO Personas (Nombre, Paterno, Materno, Telefono, Email, Edad, Sexo, idDomicilio)
    VALUES (p_Nombre, p_Paterno, p_Materno, p_Telefono, p_Email, p_Edad, p_Sexo, v_idDomicilio);
    SET v_idPersona = LAST_INSERT_ID();

    -- Insertar cliente
    INSERT INTO Clientes (Credito, Limite, idPersona, idDescuento)
    VALUES (p_Credito, p_Limite, v_idPersona, p_idDescuento);

    COMMIT;
END;

DELIMITER ;
