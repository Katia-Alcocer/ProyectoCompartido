--Base de Datos

--Vistas
1. VistaVentasDiarias --(SA)
2. VistaArticuloSimplificado -- Todos
3. VistaEmpleadosActivos --(SA)
4. VistaEstadoInventario --(SA)
5. VistaClientesActivos --(SA)
6. VistaProveedoresActivos --(SA)
7. VistaPedidosPendientes --Caja y Administrativo
8. VistaPedidosRecibidos --Caja y Administrativo
9. VistaProductosConDescuentos --Agente de ventas(AV)
10. VistaObtenerCarritoPorEmpleado 

--Procedimintos Almacenados
1. sp_CalcularPrecioConPromocion
2. sp_AgregarProducto_Completo
3. sp_ActualizarProducto_Completo
4. sp_EliminarProducto
5. sp_BuscarProductoPorNombre
6. sp_BuscarProductoPorCodigoBarras
7. sp_ActualizarEmpleado  
8. sp_CambiarEstadoEmpleado --Este igual que el anterior 
8. sp_ActualizarCliente --Tambien solo administradores 
9. sp_CambiarEstadoCliente --Aministradores
10. sp_AgregarProveedor --Solo administradores 
11. EditarProveedor --Solo administradores(SA)
12. sp_CambiarEstadoProveedor --SA
13. sp_RegistrarPedidoCompleto 
14. sp_AgregarOActualizarProductoPedido
15. sp_CambiarEstadoPedido --SA
16. sp_RegistrarRecarga
17. sp_AgregarAlCarrito
18. sp_SumarCantidadProductoCarrito
19. sp_RestarCantidadProductoCarrito
20. sp_LimpiarCarritoPorEmpleado
21. sp_RegistrarVentaCompleta
22. DevolverProductoIndividual
23. DevolverVentaCompleta
24. DevolverProductoConDescuento

--Funcion 
1. ObtenerPrecioCliente, aqui hay que checar tambien que el cliente si pertenezca al agente de venta que esta checando por que cada agente tendra a sus propios clientes 
2. InsertarEmpleado 
3. InsertarCliente --Checar que el cliente no haya existido antes

--Triggers
1. trg_promocion_existencia_baja
2. verificar_credito_cliente
3. VerificarVentaProducto
4. AuditoriaProductoUpdate
5. before_insert_producto
6. before_update_producto
7. before_delete_empleado
8. before_update_pedido
9. after_insert_venta
10. after_delete_producto
11. after_update_empleado
12. after_insert_venta_clear_carrito

--Impresiones PDF
1. Ticket de Venta 
2. Reporte de Ventas Diarias
3. Estado de Inventario
4. Reporte de Pedidos Pendientes / Recibidos
5. Lista de Clientes Activos
6. Lista de Empleados Activos
7. Lista de Proveedores Activos

--Transacciones
