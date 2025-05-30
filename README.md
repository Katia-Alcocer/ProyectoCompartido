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
1. PromocionExistenciaBaja
2. VerificarCreditoCliente
3. VerificarVentaProducto
4. AuditoriaProductoUpdate
5. BeforeInsertProducto
6. BeforeUpdateProducto
7. BeforeDeleteEmpleado
8. BeforeUpdatePedido
9. AfterInsertVenta
10. AfterDeleteProducto
11. AfterUpdateEmpleado
12. AfterInsertVentaClearCarrito

--Impresiones PDF
1. Ticket de Venta 
2. Reporte de Ventas Diarias
3. Estado de Inventario
4. Reporte de Pedidos Pendientes / Recibidos
5. Lista de Clientes Activos
6. Lista de Empleados Activos
7. Lista de Proveedores Activos

--Transacciones
