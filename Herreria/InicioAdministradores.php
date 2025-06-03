<?php
session_start();
$conn = new mysqli("db", "root", "clave", "HerreriaUG");

if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

$idEmpleado = $_SESSION['id'] ?? 1;

// Definir variable de sesión en MySQL para el id empleado
$conn->query("SET @id_empleado_sesion := $idEmpleado");

$productos_registrados = [];
$clientes = [];

// Obtener lista de clientes
$sql = "SELECT c.idCliente AS id, p.Nombre
        FROM Clientes c
        INNER JOIN Personas p ON c.idPersona = p.idPersona
        WHERE p.Estatus = 1";
$result = $conn->query($sql);
if ($result) {
    $clientes = $result->fetch_all(MYSQLI_ASSOC);
} else {
    die("Error al obtener clientes: " . $conn->error);
}

// Variables para mantener selección
$cliente_id = $_POST['cliente_id'] ?? '';
$tipo_cliente = $_POST['tipo_cliente'] ?? 'normal';

// Buscar producto
if (isset($_POST['buscar'])) {
    $termino = trim($_POST['termino']);

    // Intentar buscar por nombre primero
    $stmt = $conn->prepare("CALL BuscarProductoPorNombre(?)");
    if ($stmt === false) {
        die("Error en prepare BuscarProductoPorNombre: " . $conn->error);
    }
    $stmt->bind_param("s", $termino);
    $stmt->execute();
    $resultadoNombre = $stmt->get_result();
    $producto = $resultadoNombre->fetch_assoc();
    $stmt->close();
    $conn->next_result();

    // Si no se encontró por nombre, buscar por código de barras
    if (!$producto) {
        $stmt = $conn->prepare("CALL BuscarProductoPorCodigoBarras(?)");
        if ($stmt === false) {
            die("Error en prepare BuscarProductoPorCodigoBarras: " . $conn->error);
        }
        $stmt->bind_param("s", $termino);
        $stmt->execute();
        $resultadoCodigo = $stmt->get_result();
        $producto = $resultadoCodigo->fetch_assoc();
        $stmt->close();
        $conn->next_result();
    }

    if ($producto) {
        $cantidad = 1;
        $stmt = $conn->prepare("CALL AgregarAlCarrito(?, ?, ?)");
        if ($stmt === false) {
            die("Error en prepare AgregarAlCarrito: " . $conn->error);
        }
        $stmt->bind_param("iii", $idEmpleado, $producto['idProducto'], $cantidad);
        if (!$stmt->execute()) {
            die("Error en execute AgregarAlCarrito: " . $stmt->error);
        }
        $stmt->close();

        while ($conn->more_results() && $conn->next_result()) {
            $res = $conn->store_result();
            if ($res instanceof mysqli_result) {
                $res->free();
            }
        }
    }
}

// Sumar cantidad
if (isset($_POST['sumar'])) {
    $idProducto = $_POST['producto_id'];
    $stmt = $conn->prepare("CALL SumarCantidadProductoCarrito(?, ?)");
    if ($stmt === false) {
        die("Error en prepare SumarCantidadProductoCarrito: " . $conn->error);
    }
    $stmt->bind_param("ii", $idEmpleado, $idProducto);
    $stmt->execute();
    $stmt->close();
    $conn->next_result();
}

// Restar cantidad
if (isset($_POST['restar'])) {
    $idProducto = $_POST['producto_id'];
    $stmt = $conn->prepare("CALL RestarCantidadProductoCarrito(?, ?)");
    if ($stmt === false) {
        die("Error en prepare RestarCantidadProductoCarrito: " . $conn->error);
    }
    $stmt->bind_param("ii", $idEmpleado, $idProducto);
    $stmt->execute();
    $stmt->close();
    $conn->next_result();
}

// Procesar venta
if (isset($_POST['procesar'])) {
    $cliente_id = $_POST['cliente_id'] ?? '';
    if (empty($cliente_id)) {
        die("Debe seleccionar un cliente para procesar la venta.");
    }
    $tipo_pago = isset($_POST['es_credito']) ? 'Credito' : 'Contado';
    $pago = 0.0;

    $stmt = $conn->prepare("CALL ProcesarUnaVenta(?, ?, ?, ?)");
    if ($stmt === false) {
        die("Error en prepare ProcesarUnaVenta: " . $conn->error);
    }
    $stmt->bind_param("iisd", $idEmpleado, $cliente_id, $tipo_pago, $pago);
    if (!$stmt->execute()) {
        die("Error en execute ProcesarUnaVenta: " . $stmt->error);
    }
    $stmt->close();
    $conn->next_result();
}

// Obtener productos del carrito
$stmt = $conn->prepare("CALL sp_ObtenerCarritoPorEmpleado(?)");
if ($stmt === false) {
    die("Error en prepare sp_ObtenerCarritoPorEmpleado: " . $conn->error);
}
$stmt->bind_param("i", $idEmpleado);
$stmt->execute();
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    $productos_registrados[] = [
        'idProducto' => $row['idProducto'],
        'nombre' => $row['Nombre'],
        'cantidad' => $row['Cantidad'],
        'precioProducto' => $row['PrecioVenta'],
        'precioVenta' => $row['Total'],
    ];
}
$stmt->close();
$conn->next_result();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Inicio Administradores</title>
    <link rel="stylesheet" href="InicioTrabajadores.css" />
    <link rel="icon" type="image/jpg" href="Imagenes/Logo.jpg" />
</head>
<body>
    <div class="overlay"></div>

    <header class="titulo">
        <div class="boton-atras-contenedor">
            <img src="Imagenes/Menu.png" alt="Menú" class="boton-atras" />
        </div>

        <nav class="menu">
            <div class="menu-header">
                <img src="Imagenes/Casa.png" alt="Logo" class="menu-logo" />
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

        <h1>Abarrotes Guzmán</h1>
    </header>

    <main class="contenido">
        <section class="container">
            <form method="POST" class="barcode-form">
                <input type="text" name="termino" placeholder="Nombre o código de barras" value="<?= htmlspecialchars($_POST['termino'] ?? '') ?>" />

                <select name="cliente_id" required>
                    <option value="">Seleccione un cliente</option>
                    <?php foreach ($clientes as $cliente): ?>
                        <option value="<?= htmlspecialchars($cliente['id']) ?>" <?= ($cliente_id == $cliente['id']) ? 'selected' : '' ?>>
                            <?= htmlspecialchars($cliente['Nombre']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>

                <button type="submit" name="buscar">Buscar producto</button>

                <label>
                    <input type="checkbox" name="es_credito" <?= isset($_POST['es_credito']) ? 'checked' : '' ?> />
                    Crédito
                </label>

                <button type="submit" name="procesar">Procesar Venta</button>
            </form>

            <div class="table-container">
                <table class="table">
                    <thead>
                        <tr class="headtable">
                            <th>Producto</th>
                            <th>Cantidad</th>
                            <th>Precio Unitario</th>
                            <th>Total</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $total = 0;
                        if ($productos_registrados) {
                            foreach ($productos_registrados as $row) {
                                $total += $row['precioProducto'] * $row['cantidad'];
                                echo "<tr>
                                    <td>" . htmlspecialchars($row['nombre']) . "</td>
                                    <td>" . intval($row['cantidad']) . "</td>
                                    <td>$" . number_format($row['precioProducto'], 2) . "</td>
                                    <td>$" . number_format($row['precioVenta'], 2) . "</td>
                                    <td>
                                        <form method='POST' style='display:inline'>
                                            <input type='hidden' name='producto_id' value='" . intval($row['idProducto']) . "' />
                                            <button type='submit' name='sumar'>+</button>
                                            <button type='submit' name='restar'>-</button>
                                        </form>
                                    </td>
                                </tr>";
                            }
                        } else {
                            echo "<tr><td colspan='5'>No hay productos en el carrito.</td></tr>";
                        }
                        ?>
                        <tr>
                            <td colspan="3" style="text-align:right; font-weight:bold;">Total:</td>
                            <td colspan="2" style="font-weight:bold;">$<?= number_format($total, 2) ?></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</body>
</html>
