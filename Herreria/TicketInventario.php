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