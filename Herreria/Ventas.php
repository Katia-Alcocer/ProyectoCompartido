<?php
session_start(); // Iniciar sesión para usar $_SESSION

// Conexión a la base de datos
$host = "db";
$usuario = "root";
$clave = "clave";
$bd = "HerreriaUG";

// Crear la conexión
$conexion = new mysqli($host, $usuario, $clave, $bd);

// Verificar la conexión
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// Establecer variable de sesión para el empleado (si aplica)
$empleado_id = $_SESSION['id'] ?? 1;
$conexion->query("SET @empleado_id = $empleado_id");

// Fecha seleccionada
$fechaSeleccionada = date('Y-m-d'); // Valor por defecto

// Verificar si el formulario fue enviado
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    if (isset($_POST["fecha"])) {
        $fechaSeleccionada = $_POST["fecha"];
    }

    if (isset($_POST["accion"])) {
        $accion = $_POST["accion"];

        if ($accion === "descargar") {
            // Redirige a la página de generación de PDF con la fecha seleccionada como parámetro GET
            header("Location: TicketVentasDiarias.php?fecha=" . urlencode($fechaSeleccionada));
            exit;
        }

        // Si la acción es buscar, simplemente continúa para mostrar los resultados
    }
}

// Consultar las ventas del día desde la vista filtrando por fecha
$ventas = [];
$sql = "SELECT * FROM VistaVentasDiarias WHERE DATE(Fecha) = ?";
$stmt = $conexion->prepare($sql);
$stmt->bind_param("s", $fechaSeleccionada);
$stmt->execute();
$resultado = $stmt->get_result();

// Guardar resultados en array
while ($fila = $resultado->fetch_assoc()) {
    $ventas[] = $fila;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resumen Ventas</title>
    <link rel="stylesheet" type="text/css" href="Ventas.css">
    <link rel="icon" type="image/jpg" href="Imagenes/Logo.jpg">
</head>
<body>
    <div class="overlay"></div>

    <header class="titulo">
        <div class="boton-atras-contenedor">
            <img src="Imagenes/Menu.png" alt="Atrás" class="boton-atras">
        </div>

        <nav class="menu">
            <div class="menu-header">
                <img src="Imagenes/Casa.png" alt="Logo" class="menu-logo">
                <h2 class="menu-title">Abarrotes Guzmán</h2>
            </div>
            <ul class="list">
                <li><a href="InicioTrabajadores.php"><img src="Imagenes/Casa.png" alt=""> Inicio</a></li>
                <li><a href="Almacen.php"><img src="Imagenes/Almacen.png" alt=""> Almacen</a></li>
                <li><a href="Empleados.php"><img src="Imagenes/Empleado.png" alt=""> Empleados</a></li>
                <li><a href="Clientes.php"><img src="Imagenes/Cliente.png" alt=""> Clientes</a></li>
                <li><a href="Devolucion.php"><img src="Imagenes/Devolucion.png" alt=""> Hacer Devolucion</a></li>
                <li><a href="Ventas.php"><img src="Imagenes/Ventas.png" alt=""> Ventas</a></li>
                <li><a href="PedidosPendientes.php"><img src="Imagenes/Pedido.png" alt=""> Pedidos</a></li>
                <li><a href="Login.php"><img src="Imagenes/Salir.png" alt=""> Cerrar Sesión</a></li>
            </ul>
        </nav>

        <h1>Resumen de Ventas del Día</h1>
    </header>

    <main class="contenido">
        <section class="container">
            <div class="formulario">
                <form method="POST" action="">
                    <label for="fecha">Fecha:</label>
                    <input type="date" name="fecha" id="fecha" required value="<?php echo htmlspecialchars($fechaSeleccionada); ?>">

                    <button type="submit" name="accion" value="buscar">Buscar</button>
                    <button type="submit" name="accion" value="descargar">Descargar</button>
                </form>

            </div>

            <?php if (empty($ventas)): ?>
                <p style="text-align: center; font-weight: bold;">No hay ventas registradas en esta fecha.</p>
            <?php else: ?>
                <?php 
                $ventasPorEmpleado = [];
                foreach ($ventas as $venta) {
                    $ventasPorEmpleado[$venta['Empleado']][] = $venta;
                }

                foreach ($ventasPorEmpleado as $empleado => $ventasEmpleado): 
                ?>
                    <h2>Ventas de <?php echo htmlspecialchars($empleado); ?></h2>
                    <div class="tabla">
                        <table class="table">
                            <thead>
                                <tr class="headtable">
                                    <th>Número de Venta</th>
                                    <th>Cliente</th>
                                    <th>Producto</th>
                                    <th>Cantidad</th>
                                    <th>Precio</th>
                                    <th>Subtotal</th>
                                    <th>Hora</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                $sumaTotalEmpleado = 0;
                                foreach ($ventasEmpleado as $venta): 
                                    $sumaTotalEmpleado += $venta['Subtotal'];
                                ?>
                                    <tr>
                                        <td><?php echo $venta['NumeroVenta']; ?></td>
                                        <td><?php echo $venta['Cliente']; ?></td>
                                        <td><?php echo $venta['Producto']; ?></td>
                                        <td><?php echo number_format($venta['Cantidad'], 2); ?></td>
                                        <td><?php echo '$' . number_format($venta['PrecioUnitario'], 2); ?></td>
                                        <td><?php echo '$' . number_format($venta['Subtotal'], 2); ?></td>
                                        <td><?php echo $venta['Hora']; ?></td>
                                    </tr>
                                <?php endforeach; ?>
                                <tr>
                                    <td colspan="5" style="text-align: right;"><strong>Total del día:</strong></td>
                                    <td colspan="2"><strong><?php echo '$' . number_format($sumaTotalEmpleado, 2); ?></strong></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </section>
    </main>

    <footer>
        <p>&copy; 2025 Diamonds Corporation. Todos los derechos reservados.</p>
    </footer>
</body>
</html>
