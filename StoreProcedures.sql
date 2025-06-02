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

    -- Marcar la venta como devuelta en lugar de eliminarla
    UPDATE Ventas
    SET Estatus = 'Devuelta'
    WHERE idVenta = p_idVenta;
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


DELIMITER //

CREATE PROCEDURE RegistrarEmpleado(
    IN p_Nombre VARCHAR(50),
    IN p_Paterno VARCHAR(50),
    IN p_Materno VARCHAR(50),
    IN p_Telefono VARCHAR(10),
    IN p_Email VARCHAR(50),
    IN p_Edad SMALLINT,
    IN p_Sexo ENUM('H', 'M'),
    IN p_Calle VARCHAR(50),
    IN p_Numero INT,
    IN p_c_CP INT,
    IN p_RFC VARCHAR(13),
    IN p_CURP VARCHAR(18),
    IN p_NumeroSeguro VARCHAR(11),
    IN p_Usuario VARCHAR(50),
    IN p_Contrasena VARCHAR(50)
)
BEGIN
    DECLARE v_idDomicilio INT;
    DECLARE v_idPersona INT;
    DECLARE v_idEmpleado INT;

    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al registrar el empleado. No se pueden agregar con datos ya registrados en el sistema.';
    END;

    -- Validación previa: Teléfono o Email ya existen
    IF EXISTS (
        SELECT 1 FROM Personas WHERE Telefono = p_Telefono OR Email = p_Email
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Teléfono o Email ya registrados';
    END IF;

    -- Validación previa: Usuario ya existe
    IF EXISTS (
        SELECT 1 FROM Empleados WHERE Usuario = p_Usuario
    ) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario ya registrado';
    END IF;

    START TRANSACTION;

        -- Insertar domicilio
        INSERT INTO Domicilios (Calle, Numero, c_CP)
        VALUES (p_Calle, p_Numero, p_c_CP);
        SET v_idDomicilio = LAST_INSERT_ID();

        -- Insertar persona
        INSERT INTO Personas (Nombre, Paterno, Materno, Telefono, Email, Edad, Sexo, idDomicilio)
        VALUES (p_Nombre, p_Paterno, p_Materno, p_Telefono, p_Email, p_Edad, p_Sexo, v_idDomicilio);
        SET v_idPersona = LAST_INSERT_ID();

        -- Insertar empleado
        INSERT INTO Empleados (Puesto, RFC, NumeroSeguroSocial, Usuario, Contraseña, idPersona)
        VALUES ('Agente de Venta', p_RFC, p_NumeroSeguro, p_Usuario, p_Contrasena, v_idPersona);
        SET v_idEmpleado = LAST_INSERT_ID();

    COMMIT;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE RegistrarCliente(
    IN p_Calle VARCHAR(50),
    IN p_Numero INT,
    IN p_c_CP INT,

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
    DECLARE v_idCliente INT;
    DECLARE v_error_text TEXT;
    DECLARE v_error_code INT;
    DECLARE v_mensaje_error TEXT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 v_error_code = MYSQL_ERRNO, v_error_text = MESSAGE_TEXT;
        SET v_mensaje_error = CONCAT('Error [', v_error_code, ']: ', v_error_text);
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = v_mensaje_error;
    END;

    -- Verificar si ya existe la persona
    IF EXISTS (
        SELECT 1 FROM Personas
        WHERE TRIM(Telefono) = TRIM(p_Telefono)
           OR LOWER(TRIM(Email)) = LOWER(TRIM(p_Email))
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ya existe una persona con ese teléfono o email.';
    END IF;

    START TRANSACTION;

    -- Insertar domicilio
    INSERT INTO Domicilios (Calle, Numero, c_CP)
    VALUES (p_Calle, p_Numero, p_c_CP);
    SET v_idDomicilio = LAST_INSERT_ID();

    -- Insertar persona
    INSERT INTO Personas (Nombre, Paterno, Materno, Telefono, Email, Edad, Sexo, idDomicilio)
    VALUES (p_Nombre, p_Paterno, p_Materno, p_Telefono, p_Email, p_Edad, p_Sexo, v_idDomicilio);
    SET v_idPersona = LAST_INSERT_ID();

    -- Insertar cliente
    INSERT INTO Clientes (Credito, Limite, idPersona, idDescuento)
    VALUES (p_Credito, p_Limite, v_idPersona, p_idDescuento);
    SET v_idCliente = LAST_INSERT_ID();

    COMMIT;
END;
//

DELIMITER ;
