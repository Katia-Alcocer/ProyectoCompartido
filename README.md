--Base de Datos

--Vistas
1. VistaVentasDiarias -- Esta vista separa las ventas por empleado y por dia 
2. VistaArticuloSimplificado -- Solo muestra Nobre, cantidad y presio de un producto
3. VistaEmpleadosActivos -- Solo muetra los empleados con es estatus de activo
4. VistaEmpleadosInactivos -- Solo muetra los empleados con es estatus de activo
5. VistaEstadoInventario -- Muestra la informacion del inventario 
6. VistaClientesActivos -- Solo muetra los clientes con es estatus de activo
7. VistaClientesInactivo -- Solo muetra los clientes con es estatus de activo

8. VistaPedidosPendientes -- Solo muestra los pedidos que tiene estatus de Pendiente
9. VistaPedidosAceptados -- Solo muetra los pedidos que tiene estatus de aceptados 
10. VistaPedidosEnviados -- Solo muetra los pedidos que tienen estatus de enviados 

11. VistaObtenerCarritoPorEmpleado -- Muestra los productos del carrito temporal por empleado

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
1. PromocionExistenciaBaja -- Cuando un producto tiene baja existencia crea una promocio con un descuento 15% de descuento
2. VerificarCreditoClienteBefore --Antes de hgacer una venta a credito verifica que el credito disponble del clinte si cubra lo que planea comprar 
3. VerificarVentaProducto

4. ProductoUpdateAuditoriaAfter
5. ProductoDeleteAuditoriaAfter
6. ProductoInsertAuditoriaAfter

7. EmpleadosUpdateAuditoriaAfter
8. EmpleadosDeleteAuditoriaAfter
9. EmpleadosInsertAuditoriaAfte

10. ClienteUpdateAuditoriaAfter
11. ClienteDeleteAuditoriaAfter
12. ClienteInsertAuditoriaAfter

13. EmpleadoUpdateBefore
14. EmpleadoInsertBefore

15. ProductoUpdateBefore -- No permote que la cantida del stock sea 0 y que el precio de venta sea menor que el de compra
16. ProductoInsertBefore -- No permote que la cantida del stock sea 0 y que el precio de venta sea menor que el de compra

17. ClienteUpdateBefore -- No permite que la cantidad de credito supere el limite de credito 
18. ClienteInsertBefore -- No permite que la cantidad de credito supere el limite de credito 

19. InsertVentaClearCarritoAfter -- Que solo lo limpie por empleado

20. VentaCantidadBefore -- No permite hacer una venta si exede la existencia del producto

21. DevolucionCantidadBefore -- No permitedevolucion mas de lo vendido

22. DescontarCantidadDespuesDeVenta -- Descuenta la cantidad del producto vendido despues de porcesar la venta 


--Impresiones PDF
1. Ticket de Venta 
2. Reporte de Ventas Diarias
3. Estado de Inventario
4. Reporte de Pedidos Pendientes / Recibidos
5. Lista de Clientes Activos
6. Lista de Empleados Activos

--Transacciones
