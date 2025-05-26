--Base de Datos

--Vistas
1. Vista_VentasDiarias
2. Vista_ArticuloSimplificado
3. VistaEmpleadosActivos
4. VistaEstadoInventario
5. vista_recargas_por_dia
6. VistaClientesActivos
7. VistaProveedoresActivos
8. VistaProveedoresPorDia
9. VistaPedidosPendientes
10. VistaPedidosRecibidos

--Procedimintos Almacenados
1. sp_CalcularPrecioConPromocion
2. sp_CalcularPrecioConDescuentoEmpleado
3. sp_AgregarProducto_Completo
4. sp_ActualizarProducto_Completo
5. sp_EliminarProducto
6. sp_BuscarProductoPorNombre
7. sp_BuscarProductoPorCodigoBarras
8. InsertarEmpleado
9. sp_ActualizarEmpleado
10. sp_CambiarEstadoEmpleado
11. InsertarCliente
12. sp_ActualizarCliente
13. sp_CambiarEstadoCliente
14. sp_AgregarProveedor
15. EditarProveedor
16. sp_CambiarEstadoProveedor
17. sp_RegistrarPedidoCompleto
18. sp_AgregarOActualizarProductoPedido
19. sp_CambiarEstadoPedido
20. sp_RegistrarRecarga
21. sp_AgregarAlCarrito
22. sp_ObtenerCarritoPorEmpleado
23. sp_SumarCantidadProductoCarrito
24. sp_RestarCantidadProductoCarrito
25. sp_LimpiarCarritoPorEmpleado
26. sp_RegistrarVentaCompleta
27. DevolverProductoIndividual
28. DevolverVentaCompleta
29. DevolverProductoConDescuento

--Funcion 
1. ObtenerPrecioCliente

--Triggers
1. trg_promocion_existencia_baja
2. trg_promocion_fecha_caducidad
3. verificar_credito_cliente
4. VerificarVentaProducto
5. AuditoriaProductoUpdate
6. before_insert_producto
7. before_update_producto
8. before_delete_empleado
9. before_update_pedido
10. after_insert_venta
11. after_delete_producto
12. after_update_empleado
13. after_insert_recarga
14. after_insert_venta_clear_carrito

--Impresiones PDF
1. Ticket de Venta 
2. Reporte de Ventas Diarias
3. Estado de Inventario
4. Reporte de Recargas por Día
5. Reporte de Pedidos Pendientes / Recibidos
6. Lista de Clientes Activos
7. Lista de Empleados Activos
8. Lista de Proveedores Activos

--Transacciones
