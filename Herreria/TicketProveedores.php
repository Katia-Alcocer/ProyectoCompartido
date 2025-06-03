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
