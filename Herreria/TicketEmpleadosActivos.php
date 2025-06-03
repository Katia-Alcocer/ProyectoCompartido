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