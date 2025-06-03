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
