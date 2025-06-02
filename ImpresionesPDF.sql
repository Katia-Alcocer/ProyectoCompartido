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

<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// Conexión directa a la base de datos
$conn = new mysqli("db", "root", "clave", "HerreriaUG");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

$query = "SELECT NumeroVenta, Fecha, Hora, Empleado, Cliente, TotalVenta, TipoPago, Estatus FROM VistaVentasDiarias";
$result = $conn->query($query);

// Encabezado del HTML
$html = '<h2 style="text-align: center;">Reporte de Ventas Diarias</h2>';
$html .= '<table border="1" width="100%" cellpadding="5" cellspacing="0">
<tr style="background-color: #f2f2f2; font-weight: bold;">
    <th># Venta</th>
    <th>Fecha</th>
    <th>Hora</th>
    <th>Empleado</th>
    <th>Cliente</th>
    <th>Total</th>
    <th>Pago</th>
    <th>Estatus</th>
</tr>';

// Cuerpo de la tabla
while ($fila = $result->fetch_assoc()) {
    $html .= '<tr>
        <td>' . htmlspecialchars($fila['NumeroVenta']) . '</td>
        <td>' . htmlspecialchars($fila['Fecha']) . '</td>
        <td>' . htmlspecialchars($fila['Hora']) . '</td>
        <td>' . htmlspecialchars($fila['Empleado']) . '</td>
        <td>' . htmlspecialchars($fila['Cliente']) . '</td>
        <td>$' . number_format($fila['TotalVenta'], 2) . '</td>
        <td>' . htmlspecialchars($fila['TipoPago']) . '</td>
        <td>' . htmlspecialchars($fila['Estatus']) . '</td>
    </tr>';
}

$html .= '</table>';

// Crear y enviar el PDF
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'landscape'); // Para que quepa mejor horizontalmente
$dompdf->render();
$dompdf->stream("reporte_ventas_diarias.pdf", ["Attachment" => false]);

$conn->close();
?>


3. Estado de Inventario
<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// Conexión a la base de datos
$conn = new mysqli("db", "root", "clave", "HerreriaUG");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consulta a la vista de productos activos
$query = "SELECT * FROM VistaProductosActivos";
$result = $conn->query($query);

// Generar el contenido HTML
$html = '<h2 style="text-align: center;">Estado de Inventario</h2>';
$html .= '<table border="1" width="100%" cellpadding="5" cellspacing="0">
<tr style="background-color: #f2f2f2; font-weight: bold;">
    <th>Producto</th>
    <th>Stock</th>
    <th>Compra</th>
    <th>Venta</th>
    <th>Proveedor</th>
    <th>Categoría</th>
</tr>';

while ($fila = $result->fetch_assoc()) {
    $html .= '<tr>
        <td>' . htmlspecialchars($fila['Producto']) . '</td>
        <td>' . $fila['Stock'] . '</td>
        <td>$' . number_format($fila['PrecioCompra'], 2) . '</td>
        <td>$' . number_format($fila['PrecioVenta'], 2) . '</td>
        <td>' . htmlspecialchars($fila['Proveedor']) . '</td>
        <td>' . htmlspecialchars($fila['Categoria']) . '</td>
    </tr>';
}

$html .= '</table>';

// Crear el PDF con Dompdf
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("estado_inventario.pdf", ["Attachment" => false]);

// Cerrar la conexión
$conn->close();
?>

4. Reporte de Pedidos Pendientes / Recibidos

<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// Conexión a la base de datos
$conn = new mysqli("db", "root", "clave", "HerreriaUG");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consultas a las vistas
$query1 = "SELECT * FROM VistaPedidosPendientes";
$query2 = "SELECT * FROM VistaPedidosAceptados";
$query3 = "SELECT * FROM VistaPedidosEnviados";

$result1 = $conn->query($query1);
$result2 = $conn->query($query2);
$result3 = $conn->query($query3);

// Inicia el HTML del PDF
$html = '<h2 style="text-align:center;">Reporte de Pedidos</h2>';

// Tabla 1: Pedidos Pendientes
$html .= '<h3>Pedidos Pendientes</h3>
<table border="1" width="100%" cellpadding="5" cellspacing="0">
<tr style="background-color:#f2f2f2;"><th>ID</th><th>Cliente</th><th>Fecha</th><th>Hora</th><th>Estatus</th></tr>';
while ($fila = $result1->fetch_assoc()) {
    $html .= '<tr>
        <td>' . htmlspecialchars($fila['idPedido']) . '</td>
        <td>' . htmlspecialchars($fila['NombreCliente']) . '</td>
        <td>' . htmlspecialchars($fila['Fecha']) . '</td>
        <td>' . htmlspecialchars($fila['Hora']) . '</td>
        <td>' . htmlspecialchars($fila['Estatus']) . '</td>
    </tr>';
}
$html .= '</table><br>';

// Tabla 2: Pedidos Aceptados
$html .= '<h3>Pedidos Aceptados</h3>
<table border="1" width="100%" cellpadding="5" cellspacing="0">
<tr style="background-color:#f2f2f2;"><th>ID</th><th>Cliente</th><th>Fecha</th><th>Hora</th><th>Estatus</th></tr>';
while ($fila = $result2->fetch_assoc()) {
    $html .= '<tr>
        <td>' . htmlspecialchars($fila['idPedido']) . '</td>
        <td>' . htmlspecialchars($fila['NombreCliente']) . '</td>
        <td>' . htmlspecialchars($fila['Fecha']) . '</td>
        <td>' . htmlspecialchars($fila['Hora']) . '</td>
        <td>' . htmlspecialchars($fila['Estatus']) . '</td>
    </tr>';
}
$html .= '</table><br>';

// Tabla 3: Pedidos Enviados
$html .= '<h3>Pedidos Enviados</h3>
<table border="1" width="100%" cellpadding="5" cellspacing="0">
<tr style="background-color:#f2f2f2;"><th>ID</th><th>Cliente</th><th>Fecha</th><th>Hora</th><th>Estatus</th></tr>';
while ($fila = $result3->fetch_assoc()) {
    $html .= '<tr>
        <td>' . htmlspecialchars($fila['idPedido']) . '</td>
        <td>' . htmlspecialchars($fila['NombreCliente']) . '</td>
        <td>' . htmlspecialchars($fila['Fecha']) . '</td>
        <td>' . htmlspecialchars($fila['Hora']) . '</td>
        <td>' . htmlspecialchars($fila['Estatus']) . '</td>
    </tr>';
}
$html .= '</table>';

// Generar el PDF
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("reporte_pedidos.pdf", ["Attachment" => false]);

$conn->close();
?>

5. Lista de Clientes Activos

<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// Conexión directa a la base de datos
$conn = new mysqli("db", "root", "clave", "HerreriaUG");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consulta a la vista de clientes activos
$query = "SELECT * FROM VistaClientesActivos";
$result = $conn->query($query);

// Generar el contenido HTML
$html = '<h2 style="text-align: center;">Lista de Clientes Activos</h2>';
$html .= '<table border="1" width="100%" cellpadding="5" cellspacing="0">
<tr style="background-color: #f2f2f2; font-weight: bold;">
    <th>Nombre</th>
    <th>Teléfono</th>
    <th>Email</th>
    <th>Crédito</th>
    <th>Límite</th>
    <th>Tipo Cliente</th>
</tr>';

while ($fila = $result->fetch_assoc()) {
    $nombreCompleto = htmlspecialchars($fila['Nombre'] . ' ' . $fila['Paterno'] . ' ' . $fila['Materno']);
    $html .= '<tr>
        <td>' . $nombreCompleto . '</td>
        <td>' . htmlspecialchars($fila['Telefono']) . '</td>
        <td>' . htmlspecialchars($fila['Email']) . '</td>
        <td>$' . number_format($fila['Credito'], 2) . '</td>
        <td>$' . number_format($fila['Limite'], 2) . '</td>
        <td>' . htmlspecialchars($fila['TipoCliente']) . '</td>
    </tr>';
}

$html .= '</table>';

// Crear el PDF con Dompdf
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("clientes_activos.pdf", ["Attachment" => false]);

// Cerrar la conexión
$conn->close();
?>


6. Lista de Empleados Activos

<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// Conexión directa a la base de datos
$conn = new mysqli("db", "root", "clave", "HerreriaUG");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consulta a la vista de empleados activos
$query = "SELECT * FROM VistaEmpleadosActivos";
$result = $conn->query($query);

// Generar el contenido HTML
$html = '<h2 style="text-align: center;">Empleados Activos</h2>';
$html .= '<table border="1" width="100%" cellpadding="5" cellspacing="0">
<tr style="background-color: #f2f2f2; font-weight: bold;">
    <th>Nombre</th>
    <th>Puesto</th>
    <th>Teléfono</th>
    <th>Email</th>
</tr>';

while ($fila = $result->fetch_assoc()) {
    $nombreCompleto = htmlspecialchars($fila['Nombre'] . ' ' . $fila['Paterno'] . ' ' . $fila['Materno']);
    $html .= '<tr>
        <td>' . $nombreCompleto . '</td>
        <td>' . htmlspecialchars($fila['Puesto']) . '</td>
        <td>' . htmlspecialchars($fila['Telefono']) . '</td>
        <td>' . htmlspecialchars($fila['Email']) . '</td>
    </tr>';
}

$html .= '</table>';

// Crear el PDF con Dompdf
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("empleados_activos.pdf", ["Attachment" => false]);

// Cerrar la conexión
$conn->close();
?>

7. Lista de Proveedores Activos

<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// Conexión directa a la base de datos
$conn = new mysqli("db", "root", "clave", "HerreriaUG");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consulta a la vista correcta
$query = "SELECT * FROM Vista_Todos_Proveedores";
$result = $conn->query($query);

// Verifica que la consulta haya funcionado
if (!$result) {
    die("Error en la consulta: " . $conn->error);
}

// HTML del reporte
$html = '<h2 style="text-align:center;">Lista de Proveedores</h2>';
$html .= '<table border="1" width="100%" cellpadding="5" cellspacing="0">
<tr style="background-color: #f2f2f2;"><th>ID</th><th>Nombre</th></tr>';

while ($fila = $result->fetch_assoc()) {
    $html .= '<tr>
        <td>' . htmlspecialchars($fila['idProveedor']) . '</td>
        <td>' . htmlspecialchars($fila['Nombre']) . '</td>
    </tr>';
}
$html .= '</table>';

// Generar el PDF
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("proveedores_activos.pdf", ["Attachment" => false]);

$conn->close();
?>
