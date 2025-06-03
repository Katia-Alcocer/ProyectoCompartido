<?php
// Conexión a la base de datos
$host = "db";
$usuario = "root";
$clave = "clave";
$bd = "HerreriaUG";

// Crear conexión
$conexion = new mysqli($host, $usuario, $clave, $bd);

// Verificar conexión
if ($conexion->connect_error) {
    die("Error de conexión: " . $conexion->connect_error);
}

// Consulta la vista VistaEstadoInventario
$sql = "SELECT * FROM VistaProductosActivos";
$resultado = $conexion->query($sql);

// Verificar si hubo error en la consulta
if (!$resultado) {
    die("Error al consultar la vista: " . $conexion->error);
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Estado del Inventario</title>
    <link rel="stylesheet" type="text/css" href="Almacen.css">
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

        <h1>Estado del Inventario</h1>
    </header>

    <main class="contenido">
        <section class="container">
            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Categoría</th>
                            <th>Proveedor</th>
                            <th>Stock</th>
                            <th>Precio Compra</th>
                            <th>Precio Venta</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($producto = $resultado->fetch_assoc()): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($producto['Producto']); ?></td>
                                <td><?php echo htmlspecialchars($producto['Categoria']); ?></td>
                                <td><?php echo htmlspecialchars($producto['Proveedor']); ?></td>
                                <td><?php echo htmlspecialchars($producto['Stock']); ?></td>
                                <td>$<?php echo number_format($producto['PrecioCompra'], 2); ?></td>
                                <td>$<?php echo number_format($producto['PrecioVenta'], 2); ?></td>
                                <td>
                                    <div class="acciones">
                                        <a href="EditarProducto.php?idProducto=<?php echo urlencode($producto['idProducto']); ?>">
                                            <img src="Imagenes/Editar.png" alt="Editar" class="mi-imagen">
                                        </a>
                                        <a href="BorrarProducto.php?idProducto=<?php echo urlencode($producto['idProducto']); ?>">
                                            <img src="Imagenes/Borrar.png" alt="Eliminar" class="mi-imagen">
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
                <div class="boton-agregar-container">
                     <a href="AgregarProducto.php" title="Agregar"><img src="Imagenes/Agregar.png" alt="Agregar" class="agregar"></a>
                     <a href="AlmacenInactivos.php" title="Agregar"><img src="Imagenes/Inactivos2.png" alt="Agregar" class="agregar"></a>
                     <a href="TicketInventario.php" title="Descargar"><img src="Imagenes/Descargar.png" alt="Agregar" class="agregar"></a>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2025 Diamonds Corporation. Todos los derechos reservados.</p>
    </footer>
</body>
</html>
