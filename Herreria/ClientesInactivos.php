<?php
session_start(); // Asegúrate de iniciar sesión para usar $_SESSION

// Conexión a la base de datos
$host = "db";
$usuario = "root";
$clave = "clave";
$bd = "HerreriaUG";

$conn = new mysqli($host, $usuario, $clave, $bd);

// Verifica conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Asignar empleado_id en variable de sesión MySQL, si es necesario
$empleado_id = $_SESSION['id'] ?? 1;
$conn->query("SET @empleado_id = $empleado_id");

// Consulta a la vista
$sql = "SELECT * FROM VistaClientesInactivos";
$resultado = $conn->query($sql);

if(!$resultado){
    die("Error en la consulta: " . $conn->error);
}

// No cerramos la conexión todavía para poder usar $resultado en la página
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Clientes Inactivos</title>
    <link rel="stylesheet" type="text/css" href="Clientes.css">
    <link rel="icon" type="image/jpg" href="Imagenes/Logo.jpg">
</head>
<body>
    <div class="overlay"></div>

    <header class="titulo">
        <div class="boton-atras-contenedor">
            <a href="Clientes.php" title="Agregar"><img src="Imagenes/Atras.png" alt="Agregar" class="agregar"></a>
        </div>
        <h1>Clientes Inactivos</h1>
    </header>

    <main class="contenido">
        <section class="container">
            <!-- Contenedor para la tabla -->
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Cliente</th>
                            <th>Tipo Cliente</th>
                            <th>Email</th>
                            <th>Teléfono</th>
                            <th>Límite de Crédito</th>
                            <th>Crédito Disponible</th>
                            <th>Recuperar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($cliente = $resultado->fetch_assoc()): ?>
                            <tr>
                                <td>
                                    <?php 
                                        // Mostrar nombre completo concatenando apellidos
                                        echo htmlspecialchars($cliente['Nombre'] . ' ' . $cliente['Paterno'] . ' ' . $cliente['Materno']);
                                    ?>
                                </td>
                                <td><?php echo htmlspecialchars($cliente['TipoCliente'] ?? 'Sin categoría'); ?></td>
                                <td><?php echo htmlspecialchars($cliente['Email'] ?? ''); ?></td>
                                <td><?php echo htmlspecialchars($cliente['Telefono'] ?? ''); ?></td>
                                <td>$<?php echo number_format($cliente['Credito'] ?? 0, 2); ?></td>
                                <td>$<?php echo number_format($cliente['Limite'] ?? 0, 2); ?></td>
                                <td>
                                    <div class="acciones">
                                        <a href="RecuperarCliente.php?idCliente=<?php echo urlencode($cliente['idCliente']); ?>">
                                            <img src="Imagenes/Recuperar.png" alt="Editar" class="mi-imagen">
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2025 Diamonds Corporation. Todos los derechos reservados.</p>
    </footer>
</body>
</html>

<?php
// Cierra la conexión después de imprimir todo
$conn->close();
?>