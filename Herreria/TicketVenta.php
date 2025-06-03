<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// Obtener el ID de la venta desde la URL
$idVenta = isset($_GET['id']) ? (int) $_GET['id'] : 0;
if ($idVenta <= 0) {
    die("ID de venta inválido.");
}

// Conexión directa a la base de datos
$conn = new mysqli("db", "root", "clave", "HerreriaUG");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consulta de la venta y el cliente
$query = "SELECT V.*, C.idCliente, CONCAT(P.Nombre,' ',P.Paterno,' ',P.Materno) AS ClienteNombre
          FROM Ventas V
          JOIN Clientes C ON V.idCliente = C.idCliente
          JOIN Personas P ON C.idPersona = P.idPersona
          WHERE V.idVenta = $idVenta";
$result = $conn->query($query);
if (!$result || $result->num_rows == 0) {
    die("Venta no encontrada.");
}
$venta = $result->fetch_assoc();

// Consulta del detalle de la venta
$query_detalle = "SELECT DV.*, P.Nombre 
                  FROM DetalleVenta DV
                  JOIN Productos P ON DV.idProducto = P.idProducto
                  WHERE DV.idVenta = $idVenta";
$detalles = $conn->query($query_detalle);
if (!$detalles) {
    die("Error al obtener el detalle de la venta.");
}

// Construir el HTML del ticket
$html = '<h2>Ticket de Venta</h2>';
$html .= 'Cliente: ' . htmlspecialchars($venta['ClienteNombre']) . '<br>';
$html .= 'Fecha: ' . $venta['Fecha'] . '<br><hr>';
$html .= '<table width="100%" border="1" cellspacing="0" cellpadding="4">
<tr><th>Producto</th><th>Cantidad</th><th>Total</th></tr>';

while ($fila = $detalles->fetch_assoc()) {
    $html .= '<tr>
                <td>' . htmlspecialchars($fila['Nombre']) . '</td>
                <td>' . $fila['Cantidad'] . '</td>
                <td>$' . number_format($fila['Total'], 2) . '</td>
              </tr>';
}
$html .= '</table><hr>';
$html .= 'Subtotal: $' . number_format($venta['Subtotal'], 2) . '<br>';
$html .= 'IVA: $' . number_format($venta['IVA'], 2) . '<br>';
$html .= 'IEPS: $' . number_format($venta['IEPS'], 2) . '<br>';
$html .= '<strong>Total: $' . number_format($venta['Monto'], 2) . '</strong>';

// Generar PDF con Dompdf
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'portrait');
$dompdf->render();
$dompdf->stream("ticket_venta_$idVenta.pdf", ["Attachment" => false]);

// Cerrar la conexión
$conn->close();
?>