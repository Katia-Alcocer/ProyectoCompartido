--Base de Datos

--Vistas
1. Vista_VentasDiarias
2. Vista_ArticuloSimplificado
3. VistaEmpleadosActivos
4. VistaEstadoInventario
5. vista_recargas_por_dia
6. VistaClientesActivos
7. VistaProveedoresActivos
8. VistaProveedoresPorDia--Esta considero que devemos quitarla para no complicarnosla
9. VistaPedidosPendientes
10. VistaPedidosRecibidos
11. Mostrar precios de productos con descuentos -- Este por que los agentes de venta pueden ver los precios de los productos pero solamente de los que le tocan al cliente con el que esten

--Procedimintos Almacenados
1. sp_CalcularPrecioConPromocion
2. sp_CalcularPrecioConDescuentoEmpleado--Este no aplica en nuestro caso entonces no es necesario
3. sp_AgregarProducto_Completo
4. sp_ActualizarProducto_Completo
5. sp_EliminarProducto
6. sp_BuscarProductoPorNombre
7. sp_BuscarProductoPorCodigoBarras
8. InsertarEmpleado --Esto hay que hacerlo con una funcion para usar transacciones ya que tenemos que alterar la tabla personas y empleados 

9. sp_ActualizarEmpleado --Esta hay que ponerle que solo puedan hacerlo si es administrador y que guarde los cambios en la tabla de historiales 
10. sp_CambiarEstadoEmpleado --Este igual que el anterior 

11. InsertarCliente --Esto tambien solo lo pueden hacer los administradores, y tenemos que checar que el cliente no haya existido antes, Tambien hay que hacerlo con una funcion para usar transacciones 

12. sp_ActualizarCliente --Tambien solo administradores 
13. sp_CambiarEstadoCliente --Aministradores
14. sp_AgregarProveedor --Solo administradores 
15. EditarProveedor --Solo administradores(SA)
16. sp_CambiarEstadoProveedor --SA
17. sp_RegistrarPedidoCompleto 
18. sp_AgregarOActualizarProductoPedido
19. sp_CambiarEstadoPedido --SA
20. sp_RegistrarRecarga
21. sp_AgregarAlCarrito
22. sp_ObtenerCarritoPorEmpleado --Esto lompodemos implementar como vista y pienso que seria mejor 
23. sp_SumarCantidadProductoCarrito
24. sp_RestarCantidadProductoCarrito
25. sp_LimpiarCarritoPorEmpleado
26. sp_RegistrarVentaCompleta
27. DevolverProductoIndividual
28. DevolverVentaCompleta
29. DevolverProductoConDescuento

--Funcion 
1. ObtenerPrecioCliente, aqui hay que checar tambien que el cliente si pertenezca al agente de venta que esta checando por que cada agente tendra a sus propios clientes 

--Triggers
1. trg_promocion_existencia_baja
2. trg_promocion_fecha_caducidad --Este no creo que nos sirva ya que estamos trabajando con productos que no tienen caducidad
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
