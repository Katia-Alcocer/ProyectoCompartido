<?php
session_start();

// Conexión a la base de datos
$host = "db";
$usuario = "root";
$clave = "clave";
$bd = "HerreriaUG";

$conn = new mysqli($host, $usuario, $clave, $bd);
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$empleado_id = $_SESSION['id'] ?? 1;
$conn->query("SET @empleado_id = $empleado_id");

$sql = "SELECT * FROM VistaEmpleadosActivos";
$resultado = $conn->query($sql);
if (!$resultado) {
    die("Error en la consulta: " . $conn->error);
}
$conn->close();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Empleados Activos</title>
    <link rel="stylesheet" type="text/css" href="Empleados.css">
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
                <h2 class="menu-title">Abarrotes Guzman</h2>
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

        <h1>Empleados Activos</h1>
    </header>

    <main class="contenido">
        <section class="container">
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Apellido Paterno</th>
                            <th>Apellido Materno</th>
                            <th>Teléfono</th>
                            <th>Puesto</th>
                            <th>Usuario</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        if ($resultado->num_rows > 0) {
                            while ($empleado = $resultado->fetch_assoc()) {
                                echo "<tr>";
                                echo "<td>" . htmlspecialchars($empleado['Nombre']) . "</td>";
                                echo "<td>" . htmlspecialchars($empleado['Paterno']) . "</td>";
                                echo "<td>" . htmlspecialchars($empleado['Materno']) . "</td>";
                                echo "<td>" . htmlspecialchars($empleado['Telefono']) . "</td>";
                                echo "<td>" . htmlspecialchars($empleado['Puesto']) . "</td>";
                                echo "<td>" . htmlspecialchars($empleado['Usuario']) . "</td>";
                                echo "<td>
                                    <div class='acciones'>
                                        <a href='EditarEmpleado.php?idEmpleado=" . urlencode($empleado['idEmpleado']) . "'>
                                            <img src='Imagenes/Editar.png' alt='Editar' class='mi-imagen'>
                                        </a>
                                        <a href='BorrarEmpleado.php?idEmpleado=" . urlencode($empleado['idEmpleado']) . "'>
                                            <img src='Imagenes/Borrar.png' alt='Eliminar' class='mi-imagen'>
                                        </a>
                                    </div>
                                </td>";
                                echo "</tr>";
                            }
                        } else {
                            echo "<tr><td colspan='13'>No se encontraron empleados activos.</td></tr>";
                        }
                        ?>
                    </tbody>
                </table>
                <div class="boton-agregar-container">
                     <a href="Registro.php" title="Agregar"><img src="Imagenes/Agregar.png" alt="Agregar" class="agregar"></a>
                     <a href="EmpleadosInactivos.php" title="Descargar"><img src="Imagenes/Inactivos.png" alt="Agregar" class="agregar"></a>
                     <a href="TicketEmpleadosActivos.php" title="Descargar"><img src="Imagenes/Descargar.png" alt="Agregar" class="agregar"></a>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2025 Diamonds Corporation. Todos los derechos reservados.</p>
    </footer>
</body>
</html>
