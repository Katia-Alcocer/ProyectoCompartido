<?php
require 'vendor/autoload.php';
use Dompdf\Dompdf;

// Conexión a la base de datos
$conn = new mysqli("db", "root", "clave", "HerreriaUG");
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consulta única a la vista
$query = "SELECT * FROM VistaPedidosConProductos ORDER BY Estatus, idPedido, idDetallePedido";
$result = $conn->query($query);

// Inicia el HTML del PDF
$html = '<h2 style="text-align:center;">Reporte de Pedidos</h2>';

// Agrupación por estatus
$estatusActual = '';
while ($fila = $result->fetch_assoc()) {
    if ($fila['Estatus'] !== $estatusActual) {
        // Si cambia el estatus, cerrar tabla anterior (si hay)
        if ($estatusActual !== '') {
            $html .= '</table><br>';
        }

        // Nuevo encabezado de sección
        $estatusActual = $fila['Estatus'];
        $html .= '<h3>Pedidos ' . htmlspecialchars($estatusActual) . '</h3>';
        $html .= '<table border="1" width="100%" cellpadding="5" cellspacing="0">
        <tr style="background-color:#f2f2f2;">
            <th>ID Pedido</th>
            <th>Cliente</th>
            <th>Empleado</th>
            <th>Fecha</th>
            <th>Hora</th>
            <th>Producto</th>
            <th>Cantidad</th>
            <th>Precio Unitario</th>
            <th>Subtotal</th>
        </tr>';
    }

    // Fila de producto dentro del pedido
    $html .= '<tr>
        <td>' . htmlspecialchars($fila['idPedido']) . '</td>
        <td>' . htmlspecialchars($fila['NombreCliente']) . '</td>
        <td>' . htmlspecialchars($fila['NombreEmpleado']) . '</td>
        <td>' . htmlspecialchars($fila['Fecha']) . '</td>
        <td>' . htmlspecialchars($fila['Hora']) . '</td>
        <td>' . htmlspecialchars($fila['NombreProducto']) . '</td>
        <td>' . htmlspecialchars($fila['Cantidad']) . '</td>
        <td>' . htmlspecialchars(number_format($fila['PrecioUnitario'], 2)) . '</td>
        <td>' . htmlspecialchars(number_format($fila['Subtotal'], 2)) . '</td>
    </tr>';
}

// Cierra la última tabla si hubo resultados
if ($estatusActual !== '') {
    $html .= '</table>';
} else {
    $html .= '<p>No se encontraron pedidos.</p>';
}

// Generar el PDF
$dompdf = new Dompdf();
$dompdf->loadHtml($html);
$dompdf->setPaper('A4', 'landscape'); // Puedes cambiar a 'portrait' si prefieres
$dompdf->render();
$dompdf->stream("reporte_pedidos.pdf", ["Attachment" => false]);

$conn->close();
?>