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
    p.Nombre,
    p.Paterno,
    p.Materno,
    p.Telefono,
    p.Email,
    p.Edad,
    p.Sexo,
    p.Estatus,
    
    e.Puesto,
    e.RFC,
    e.NumeroSeguroSocial,
    e.Usuario,

    dom.Calle,
    dom.Numero,
    cp.d_codigo AS CodigoPostal,
    a.d_asenta AS Asentamiento,
    m.D_mnpio AS Municipio,
    ciu.d_ciudad AS Ciudad,
    est.d_Estado AS Estado,
    pais.Nombre AS Pais

FROM Empleados e
JOIN Personas p ON e.idPersona = p.idPersona
LEFT JOIN Domicilios dom ON p.idDomicilio = dom.idDomicilio
LEFT JOIN CodigosPostales cp ON dom.c_CP = cp.c_CP
LEFT JOIN Asentamiento a ON cp.c_tipo_asenta = a.c_tipo_asenta
LEFT JOIN Municipio m ON a.c_mnpio = m.c_mnpio
LEFT JOIN Ciudad ciu ON m.c_cve_ciudad = ciu.c_cve_ciudad
LEFT JOIN Estado est ON ciu.c_estado = est.c_estado
LEFT JOIN Pais pais ON est.id_Pais = pais.id_Pais
WHERE p.Estatus = 'Activo';


-- 4. VistaEmpleadosInactivos
CREATE OR REPLACE VIEW VistaEmpleadosInactivos AS
SELECT 
    e.idEmpleado,
    p.Nombre,
    p.Paterno,
    p.Materno,
    p.Telefono,
    p.Email,
    p.Edad,
    p.Sexo,
    p.idDomicilio,
    e.Puesto,
    e.RFC,
    e.NumeroSeguroSocial,
    e.Usuario
FROM Empleados e
JOIN Personas p ON e.idPersona = p.idPersona
WHERE p.Estatus = 'Inactivo';


-- 5. VistaEstadoInventario
CREATE OR REPLACE VIEW VistaProductosActivos AS
SELECT 
    p.idProducto,
    p.Nombre AS Producto,
    c.Nombre AS Categoria,
    pr.Nombre AS Proveedor,
    p.Stock,
    p.PrecioCompra,
    p.PrecioVenta,
    p.Estado
FROM Productos p
JOIN Categorias c ON p.idCategoria = c.idCategoria
JOIN Proveedores pr ON p.idProveedor = pr.idProveedor
WHERE p.Estado = 'Activo';

-- 5.1 VistaEstadoInventario
CREATE OR REPLACE VIEW VistaProductosInactivos AS
SELECT 
    p.idProducto,
    p.Nombre AS Producto,
    c.Nombre AS Categoria,
    pr.Nombre AS Proveedor,
    p.Stock,
    p.PrecioCompra,
    p.PrecioVenta,
    p.Estado
FROM Productos p
JOIN Categorias c ON p.idCategoria = c.idCategoria
JOIN Proveedores pr ON p.idProveedor = pr.idProveedor
WHERE p.Estado = 'Inactivo';




-- 6. VistaClientesActivos
CREATE OR REPLACE VIEW VistaClientesActivos AS
SELECT 
    c.idCliente,
    p.Nombre, p.Paterno, p.Materno,
    p.Email, p.Telefono,
    c.Credito, c.Limite,
    d.Categoria AS TipoCliente,
    
    dom.Calle,
    dom.Numero,
    cp.d_codigo AS CodigoPostal,
    a.d_asenta AS Asentamiento,
    m.D_mnpio AS Municipio,
    ciu.d_ciudad AS Ciudad,
    est.d_Estado AS Estado,
    pais.Nombre AS Pais

FROM Clientes c
JOIN Personas p ON c.idPersona = p.idPersona
LEFT JOIN Descuentos d ON c.idDescuento = d.idDescuento
LEFT JOIN Domicilios dom ON p.idDomicilio = dom.idDomicilio
LEFT JOIN CodigosPostales cp ON dom.c_CP = cp.c_CP
LEFT JOIN Asentamiento a ON cp.c_tipo_asenta = a.c_tipo_asenta
LEFT JOIN Municipio m ON a.c_mnpio = m.c_mnpio
LEFT JOIN Ciudad ciu ON m.c_cve_ciudad = ciu.c_cve_ciudad
LEFT JOIN Estado est ON ciu.c_estado = est.c_estado
LEFT JOIN Pais pais ON est.id_Pais = pais.id_Pais
WHERE p.Estatus = 'Activo';


-- 7. VistaClientesInactivo
CREATE OR REPLACE VIEW VistaClientesInactivos AS
SELECT 
    c.idCliente,
    p.Nombre, p.Paterno, p.Materno,
    p.Email, p.Telefono,
    c.Credito, c.Limite,
    d.Categoria AS TipoCliente,
    
    dom.Calle,
    dom.Numero,
    cp.d_codigo AS CodigoPostal,
    a.d_asenta AS Asentamiento,
    m.D_mnpio AS Municipio,
    ciu.d_ciudad AS Ciudad,
    est.d_Estado AS Estado,
    pais.Nombre AS Pais

FROM Clientes c
JOIN Personas p ON c.idPersona = p.idPersona
LEFT JOIN Descuentos d ON c.idDescuento = d.idDescuento
LEFT JOIN Domicilios dom ON p.idDomicilio = dom.idDomicilio
LEFT JOIN CodigosPostales cp ON dom.c_CP = cp.c_CP
LEFT JOIN Asentamiento a ON cp.c_tipo_asenta = a.c_tipo_asenta
LEFT JOIN Municipio m ON a.c_mnpio = m.c_mnpio
LEFT JOIN Ciudad ciu ON m.c_cve_ciudad = ciu.c_cve_ciudad
LEFT JOIN Estado est ON ciu.c_estado = est.c_estado
LEFT JOIN Pais pais ON est.id_Pais = pais.id_Pais
WHERE p.Estatus = 'Inactivo';


-- Vista para Pedidos Pendientes
CREATE OR REPLACE VIEW VistaPedidosPendientes AS
SELECT 
    p.idPedido,
    p.Fecha,
    p.Hora,
    p.Estatus,
    p.idCliente,
    clp.Nombre AS NombreCliente,
    p.idEmpleado,
    epl.Nombre AS NombreEmpleado,
    dp.idDetallePedido,
    dp.idProducto,
    prod.Nombre AS NombreProducto,
    dp.Cantidad,
    dp.PrecioUnitario,
    dp.Subtotal
FROM Pedidos p
JOIN Clientes cl ON p.idCliente = cl.idCliente
JOIN Personas clp ON cl.idPersona = clp.idPersona
LEFT JOIN Empleados e ON p.idEmpleado = e.idEmpleado
LEFT JOIN Personas epl ON e.idPersona = epl.idPersona
JOIN DetallePedidos dp ON p.idPedido = dp.idPedido
JOIN Productos prod ON dp.idProducto = prod.idProducto
WHERE p.Estatus = 'Pendiente';

-- Vista para Pedidos Aceptados
CREATE OR REPLACE VIEW VistaPedidosAceptados AS
SELECT 
    p.idPedido,
    p.Fecha,
    p.Hora,
    p.Estatus,
    p.idCliente,
    clp.Nombre AS NombreCliente,
    p.idEmpleado,
    epl.Nombre AS NombreEmpleado,
    dp.idDetallePedido,
    dp.idProducto,
    prod.Nombre AS NombreProducto,
    dp.Cantidad,
    dp.PrecioUnitario,
    dp.Subtotal
FROM Pedidos p
JOIN Clientes cl ON p.idCliente = cl.idCliente
JOIN Personas clp ON cl.idPersona = clp.idPersona
LEFT JOIN Empleados e ON p.idEmpleado = e.idEmpleado
LEFT JOIN Personas epl ON e.idPersona = epl.idPersona
JOIN DetallePedidos dp ON p.idPedido = dp.idPedido
JOIN Productos prod ON dp.idProducto = prod.idProducto
WHERE p.Estatus = 'Aceptado';


CREATE OR REPLACE VIEW VistaPedidosConProductos AS
SELECT 
    p.idPedido,
    p.Fecha,
    p.Hora,
    p.Estatus,
    p.idCliente,
    clp.Nombre AS NombreCliente,
    p.idEmpleado,
    epl.Nombre AS NombreEmpleado,
    dp.idDetallePedido,
    dp.idProducto,
    prod.Nombre AS NombreProducto,
    dp.Cantidad,
    dp.PrecioUnitario,
    dp.Subtotal
FROM Pedidos p
JOIN Clientes cl ON p.idCliente = cl.idCliente
JOIN Personas clp ON cl.idPersona = clp.idPersona
LEFT JOIN Empleados e ON p.idEmpleado = e.idEmpleado
LEFT JOIN Personas epl ON e.idPersona = epl.idPersona
JOIN DetallePedidos dp ON p.idPedido = dp.idPedido
JOIN Productos prod ON dp.idProducto = prod.idProducto
WHERE p.Estatus IN ('Pendiente', 'Aceptado', 'Enviado', 'Cancelado');




-- 11. VistaObtenerCarritoPorEmpleado
CREATE OR REPLACE VIEW VistaObtenerCarritoPorEmpleado AS
SELECT 
    t.idEmpleado,
    p.Nombre AS Producto,
    t.Cantidad,
    (p.PrecioVenta * t.Cantidad) AS Total
FROM Temp_Ventas t
JOIN Productos p ON t.idProducto = p.idProducto;

--12. VistaParaProveedores
CREATE OR REPLACE VIEW Vista_Todos_Proveedores AS
SELECT idProveedor, Nombre
FROM Proveedores;


--13. VistaAsentamientosPorCP
CREATE VIEW Vista_AsentamientosPorCP AS
SELECT 
    cp.c_CP,
    cp.d_codigo AS CodigoPostal,
    a.d_asenta AS Asentamiento,
    a.d_tipo_asenta AS TipoAsentamiento
FROM 
    CodigosPostales cp
JOIN 
    Asentamiento a ON cp.c_tipo_asenta = a.c_tipo_asenta;


CREATE VIEW VistaHistorialModificaciones AS
SELECT 
    h.idHistorial,
    h.Movimiento,
    h.TablaAfectada,
    h.ColumnaAfectada,
    h.DatoAnterior,
    h.DatoNuevo,
    h.Fecha,
    h.Hora,
    e.idEmpleado,
    CONCAT(p.Nombre, ' ', p.Paterno, ' ', p.Materno) AS NombreEmpleado,
    e.Puesto
FROM 
    HistorialModificaciones h
JOIN 
    Empleados e ON h.idEmpleado = e.idEmpleado
JOIN 
    Personas p ON e.idPersona = p.idPersona;
