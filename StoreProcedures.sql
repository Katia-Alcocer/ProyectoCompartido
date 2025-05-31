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
    IN p_Sexo CHAR(1),  -- Cambiado de ENUM a CHAR(1)
    IN p_idDomicilio INT,
    IN p_Puesto ENUM('Administrador', 'Cajero', 'Agente de Venta'),
    IN p_RFC VARCHAR(13),
    IN p_NumeroSeguroSocial VARCHAR(11),
    IN p_Usuario VARCHAR(255)
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

    -- Actualizar en Empleados (sin contraseña)
    UPDATE Empleados
    SET Puesto = p_Puesto,
        RFC = p_RFC,
        NumeroSeguroSocial = p_NumeroSeguroSocial,
        Usuario = p_Usuario
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
    DECLARE v_cliente INT;

    -- Asignar cliente: si no es válido, asignar 0 (cliente genérico)
    SET v_cliente = IF(p_id_cliente IS NULL OR p_id_cliente <= 0, 0, p_id_cliente);

    -- Calcular subtotal, IVA, IEPS y cantidad de productos sumados
    SELECT 
        SUM(p.PrecioVenta * t.Cantidad),
        SUM(p.PrecioVenta * t.Cantidad * 0.16), -- Ejemplo IVA 16%
        SUM(p.PrecioVenta * t.Cantidad * 0.08), -- Ejemplo IEPS 8%
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

DELIMITER ;
