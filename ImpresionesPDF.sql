
-- Impresiones PDF 
--Para usar las impresiones debemos de instalar la librería DomPDF

-- 1. Ticket de Venta 

<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// ID de la venta
$idVenta = $_GET['id'];

$query = "SELECT V.*, C.idCliente, CONCAT(P.Nombre,' ',P.Paterno,' ',P.Materno) AS ClienteNombre
          FROM Ventas V
          JOIN Clientes C ON V.idCliente = C.idCliente
          JOIN Personas P ON C.idPersona = P.idPersona
          WHERE V.idVenta = $idVenta";
$result = $conexion->query($query);
$venta = $result->fetch_assoc();

$query_detalle = "SELECT DV.*, P.Nombre 
                  FROM DetalleVenta DV
                  JOIN Productos P ON DV.idProducto = P.idProducto
                  WHERE idVenta = $idVenta";
$detalles = $conexion->query($query_detalle);

$html = '<h2>Ticket de Venta</h2>';
$html .= 'Cliente: ' . $venta['ClienteNombre'] . '<br>';
$html .= 'Fecha: ' . $venta['Fecha'] . '<br><hr>';
$html .= '<table width="100%" border="1" cellspacing="0" cellpadding="4">
<tr><th>Producto</th><th>Cantidad</th><th>Total</th></tr>';
while ($fila = $detalles->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['Nombre'].'</td><td>'.$fila['Cantidad'].'</td><td>$'.$fila['Total'].'</td></tr>';
}
$html .= '</table><hr>';
$html .= 'Subtotal: $' . $venta['Subtotal'] . '<br>';
$html .= 'IVA: $' . $venta['IVA'] . '<br>';
$html .= 'IEPS: $' . $venta['IEPS'] . '<br>';
$html .= '<strong>Total: $' . $venta['Monto'] . '</strong>';

// Generar PDF
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->render();
$dompdf->stream("ticket_venta_$idVenta.pdf", ["Attachment" => false]);
?>


2. Reporte de Ventas Diarias

$query = "SELECT * FROM VistaVentasDiarias";
$result = $conexion->query($query);

$html = '<h2>Reporte de Ventas Diarias</h2>';
$html .= '<table border="1" width="100%" cellpadding="4" cellspacing="0">
<tr><th>ID</th><th>Cliente</th><th>Monto</th><th>Pago</th><th>Estatus</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr>
    <td>'.$fila['idVenta'].'</td>
    <td>'.$fila['Cliente'].'</td>
    <td>$'.$fila['Monto'].'</td>
    <td>'.$fila['TipoPago'].'</td>
    <td>'.$fila['Estatus'].'</td>
    </tr>';
}
$html .= '</table>';


3. Estado de Inventario

$query = "SELECT * FROM VistaEstadoInventario";
$result = $conexion->query($query);

$html = '<h2>Estado de Inventario</h2>';
$html .= '<table border="1" width="100%" cellpadding="4">
<tr><th>Producto</th><th>Stock</th><th>Compra</th><th>Venta</th><th>Proveedor</th><th>Categoria</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr>
    <td>'.$fila['Nombre'].'</td>
    <td>'.$fila['Stock'].'</td>
    <td>$'.$fila['PrecioCompra'].'</td>
    <td>$'.$fila['PrecioVenta'].'</td>
    <td>'.$fila['Proveedor'].'</td>
    <td>'.$fila['Categoria'].'</td>
    </tr>';
}
$html .= '</table>';


4. Reporte de Pedidos Pendientes / Recibidos

$query1 = "SELECT * FROM VistaPedidosPendientes";
$query2 = "SELECT * FROM VistaPedidosRecibidos";

$result1 = $conexion->query($query1);
$result2 = $conexion->query($query2);

$html = '<h2>Pedidos Pendientes</h2><table border="1">
<tr><th>ID</th><th>Cliente</th><th>Fecha</th><th>Hora</th><th>Estatus</th></tr>';
while ($fila = $result1->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['idPedido'].'</td><td>'.$fila['Cliente'].'</td><td>'.$fila['Fecha'].'</td><td>'.$fila['Hora'].'</td><td>'.$fila['Estatus'].'</td></tr>';
}
$html .= '</table><hr>';

$html .= '<h2>Pedidos Recibidos</h2><table border="1">
<tr><th>ID</th><th>Cliente</th><th>Fecha</th><th>Hora</th><th>Estatus</th></tr>';
while ($fila = $result2->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['idPedido'].'</td><td>'.$fila['Cliente'].'</td><td>'.$fila['Fecha'].'</td><td>'.$fila['Hora'].'</td><td>'.$fila['Estatus'].'</td></tr>';
}
$html .= '</table>';

5. Lista de Clientes Activos

$query = "SELECT * FROM VistaClientesActivos";
$result = $conexion->query($query);

$html = '<h2>Lista de Clientes Activos</h2><table border="1">
<tr><th>Nombre</th><th>Teléfono</th><th>Email</th><th>Crédito</th><th>Límite</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['NombreCompleto'].'</td><td>'.$fila['Telefono'].'</td><td>'.$fila['Email'].'</td><td>$'.$fila['Credito'].'</td><td>$'.$fila['Limite'].'</td></tr>';
}
$html .= '</table>';

6. Lista de Empleados Activos

$query = "SELECT * FROM VistaEmpleadosActivos";
$result = $conexion->query($query);

$html = '<h2>Empleados Activos</h2><table border="1">
<tr><th>Nombre</th><th>Puesto</th><th>Teléfono</th><th>Email</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['NombreCompleto'].'</td><td>'.$fila['Puesto'].'</td><td>'.$fila['Telefono'].'</td><td>'.$fila['Email'].'</td></tr>';
}
$html .= '</table>';

7. Lista de Proveedores Activos

$query = "SELECT * FROM VistaProveedoresActivos";
$result = $conexion->query($query);

$html = '<h2>Lista de Proveedores</h2><table border="1"><tr><th>ID</th><th>Nombre</th></tr>';
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr><td>'.$fila['idProveedor'].'</td><td>'.$fila['Nombre'].'</td></tr>';
}
$html .= '</table>';


-- Después de construir $html, en todos los casos, agrega esto al final para generar el PDF:

php
Copy
Edit
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("reporte.pdf", ["Attachment" => false]); // Cambia nombre según el reporte