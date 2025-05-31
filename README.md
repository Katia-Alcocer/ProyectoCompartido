--Base de Datos
 ✅️  = Realizado y Funcionando al 100% 
Favor de poner abajo de cada uno como es que se corre y si ocupa entrar con la secion

--Vistas
✅️ 1. VistaVentasDiarias -- Esta vista separa las ventas por empleado y por dia 

✅️ 2. VistaArticuloSimplificado -- Solo muestra Nobre, cantidad y presio de un producto 
SELECT * FROM vistaarticulosimplificado

✅️ 3. VistaEmpleadosActivos -- Solo muetra los empleados con es estatus de activo 
SELECT * FROM vistaempleadosactivos;

✅️ 4. VistaEmpleadosInactivos -- Solo muetra los empleados con es estatus de inactivo 
SELECT * FROM vistaempleadosinactivos;

✅️ 5. VistaEstadoInventario -- Muestra la informacion del inventario 

✅️ 6. VistaClientesActivos -- Solo muetra los clientes con es estatus de activo 
SELECT * FROM vistaclientesactivos;

✅️ 7. VistaClientesInactivo -- Solo muetra los clientes con es estatus de inactivo 
SELECT * FROM VistaClientesInactivos;



✅️ 8. VistaPedidosPendientes -- Solo muestra los pedidos que tiene estatus de Pendiente 
SELECT * FROM vistapedidospendientes;


✅️ 9. VistaPedidosAceptados -- Solo muetra los pedidos que tiene estatus de aceptados 
SELECT * FROM vistapedidosaceptados;

10. VistaPedidosEnviados -- Solo muetra los pedidos que tienen estatus de enviados 

✅️ 11. VistaObtenerCarritoPorEmpleado -- Muestra los productos del carrito temporal por empleado 

✅️ 12. - Vista Acentamiento por CP --Despliega todos los asentamientos que pertenecen a un CP 
-- Con estas instrucciones se corre --
SELECT * 
FROM Vista_AsentamientosPorCP 
WHERE CodigoPostal = 'XXXXX';
--

--Procedimintos Almacenados
✅️ 1. AgregarProducto
✅️ 2. ActualizarProductoCompleto
✅️ 3. EliminarProducto -- Solo cambia estatus a inactivo
✅️ 4. BuscarProductoPorNombre
✅️ 5. BuscarProductoPorCodigoBarras

✅️ 6. AgergarEmpelado
✅️ 7. ActualizarEmpleado  
✅️ 8. EliminarEmpleado -- Solo cambia estatus a inactivo

✅️ 9. AgregarCliente
✅️ 10. EliminarCliente -- Solo cambia estatus a inactivo
✅️ 11. ActualizarClientes

✅️ 12. AgergarProveedor
✅️ 13 EditarProvvedor

14. RegistrarPedido

15. CambiaPedidoAceptado -- Solo cambia estatus a Aceptado
16. CambiaPedidoEnviado --Solo cambia estatus a enviado

✅️ 17. AgregarAlCarrito
✅️ 18. SumarCantidadProductoCarrito -- Que no se pueda sumar mas producto del que existe en stock
✅️ 19. RestarCantidadProductoCarrito -- Si al estar restando llega a 0 que se elimine del Tem_Venta

20. ProcesarUnaVenta -- Haver la venta en la tabla venta y detalle venta

22. DevolverProductoIndividual -- Devulve un producto seleccionado suma nuevamnete los productos al stock

✅️ 23. DevolverVentaCompleta -- Devulev una venta comleta y suma los productos nuevamente al stock 
CALL DevolverVentaCompleta(idVenta);

✅️ 24.  InsertarDomicilioPorID --Guarda en la tabla domiciliod el id de el domicilio dependiendo el que seleccione el usuario 
CALL InsertarDomicilioPorID('Av. Universidad', 789, 5);


--Funcion 
1. ObtenerPrecioCliente, aqui hay que checar tambien que el cliente si pertenezca al agente de venta que esta checando por que cada agente tendra a sus propios clientes 
2. InsertarEmpleado 
3. InsertarCliente --Checar que el cliente no haya existido antes

--Triggers
✅️ 2. VerificarCreditoClienteBefore --Antes de hgacer una venta a credito verifica que el credito disponble del clinte si cubra lo que planea comprar 
✅️ 3. VerificarVentaProducto

✅️ 4. ProductoUpdateAuditoriaAfter
✅️ 5. ProductoDeleteAuditoriaAfter
✅️ 6. ProductoInsertAuditoriaAfter

✅️ 7. EmpleadosUpdateAuditoriaAfter
✅️ 8. EmpleadosDeleteAuditoriaAfter
✅️ 9. EmpleadosInsertAuditoriaAfte

✅️ 10. ClienteUpdateAuditoriaAfter
✅️ 11. ClienteDeleteAuditoriaAfter
✅️ 12. ClienteInsertAuditoriaAfter

✅️ 13. EmpleadoUpdateBefore
✅️ 14. EmpleadoInsertBefore

✅️ 15. ProductoUpdateBefore -- No permote que la cantida del stock sea 0 y que el precio de venta sea menor que el de compra
✅️ 16. ProductoInsertBefore -- No permote que la cantida del stock sea 0 y que el precio de venta sea menor que el de compra

✅️ 17. ClienteUpdateBefore -- No permite que la cantidad de credito supere el limite de credito 
✅️ 18. ClienteInsertBefore -- No permite que la cantidad de credito supere el limite de credito 

✅️ 19. InsertVentaClearCarritoAfter -- Que solo lo limpie por empleado

✅️ 20. VentaCantidadBefore -- No permite hacer una venta si exede la existencia del producto

21. DevolucionCantidadBefore -- No permitedevolucion mas de lo vendido

22. DescontarCantidadDespuesDeVenta -- Descuenta la cantidad del producto vendido despues de porcesar la venta 

--Impresiones PDF
✅️ 1. Ticket de Venta 
✅️ 2. Reporte de Ventas Diarias
✅️ 3. Estado de Inventario
✅️ 4. Reporte de Pedidos Pendientes / Recibidos
✅️ 5. Lista de Clientes Activos
✅️ 6. Lista de Empleados Activos

--Transacciones
