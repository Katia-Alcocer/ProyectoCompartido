<?php
session_start(); // Asegúrate de iniciar sesión para acceder a $_SESSION

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

// No parece que necesites @empleado_id para esta consulta, pero si quieres mantenerlo:
$empleado_id = $_SESSION['id'] ?? 1;
$conexion->query("SET @empleado_id = $empleado_id");

// Consulta a la vista de todos los proveedores
$sql = "SELECT * FROM Vista_Todos_Proveedores";
$resultado = $conexion->query($sql);

if (!$resultado) {
    die("Error al consultar los proveedores: " . $conexion->error);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Todos los Proveedores</title>
    <link rel="stylesheet" type="text/css" href="Provedores.css">
    <link rel="icon" type="image/jpg" href="Imagenes/Logo.jpg">
</head>
<body>
    <div class="overlay"></div>

    <header class="titulo">
        <!-- Botón de atrás -->
        <div class="boton-atras-contenedor">
            <img src="Imagenes/Menu.png" alt="Atrás" class="boton-atras">
        </div>

        <!-- Menú lateral -->
        <nav class="menu">
            <div class="menu-header">
                <img src="Imagenes/Casa.png" alt="Logo" class="menu-logo">
                <h2 class="menu-title">Abarrotes Guzman</h2>
            </div>
            <ul class="list">
                <li><a href="InicioAdministradores.php"><img src="Imagenes/Casa.png" alt=""> Inicio</a></li>
                <li><a href="Almacen.php"><img src="Imagenes/Almacen.png" alt=""> Almacen</a></li>
                <li><a href="Empleados.php"><img src="Imagenes/Empleado.png" alt=""> Empleados</a></li>
                <li><a href="Clientes.php"><img src="Imagenes/Cliente.png" alt=""> Clientes</a></li>
                <li><a href="Provedores.php"><img src="Imagenes/Proveedor.png" alt=""> Proveedores</a></li>
                <li><a href="Ventas.php"><img src="Imagenes/Ventas.png" alt=""> Ventas</a></li>
                <li><a href="VerPedidos.php"><img src="Imagenes/Pedido.png" alt=""> Pedidos</a></li>
                <li><a href="Recargas.php"><img src="Imagenes/Recarga.png" alt=""> Recargas</a></li>
                <li><a href="Login.php"><img src="Imagenes/Salir.png" alt=""> Cerrar Sesión</a></li>
            </ul>
        </nav>

        <h1>Todos los Proveedores</h1>
    </header>

    <main class="contenido">
        <section class="container">
            <!-- Contenedor para la tabla -->
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($proveedor = $resultado->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($proveedor['Nombre']); ?></td>
                                <td>
                                    <div class="acciones">
                                        <!-- Enlace para editar el proveedor -->
                                        <a href="EditarProveedor.php?idProveedor=<?php echo urlencode($proveedor['idProveedor']); ?>">
                                            <img src="Imagenes/Editar.png" alt="Editar" class="mi-imagen">
                                        </a>
                                        <!-- Enlace para eliminar el proveedor -->
                                        <a href="BorrarProveedor.php?idProveedor=<?php echo urlencode($proveedor['idProveedor']); ?>">
                                            <img src="Imagenes/Borrar.png" alt="Eliminar" class="mi-imagen">
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>

            <!-- Contenedor para el botón de agregar proveedor -->
            <div class="boton-agregar-container">
                <a href="AgregarProveedor.php">
                    <img src="Imagenes/Agregar.png" alt="Agregar Proveedor" class="agregar">
                </a>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2025 Diamonds Corporation. Todos los derechos reservados.</p>
    </footer>
</body>
</html>
