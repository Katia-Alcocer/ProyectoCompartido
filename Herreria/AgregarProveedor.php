<?php
$host = "db";
$usuario = "root";
$clave = "clave";
$bd = "HerreriaUG";

$conn = new mysqli($host, $usuario, $clave, $bd);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['Boton'])) {
    $nombre = $_POST['Nombre'];

    // Llamar al procedimiento almacenado
    $stmt = $conn->prepare("CALL AgregarProveedor(?)");
    $stmt->bind_param("s", $nombre);

    if ($stmt->execute()) {
        echo "<script>alert('Proveedor agregado correctamente'); window.location.href = 'Provedores.php';</script>";
    } else {
        echo "<script>alert('Error al agregar proveedor: " . $stmt->error . "');</script>";
    }

    $stmt->close();
    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Agregar Proveedor</title>
    <link rel="stylesheet" href="AgregarProveedor.css" />
</head>
<body>
    <main>
        <section class="izquierda"></section>
        <section class="centro">
            <br><br>
            <div class="log">
                <div class="login">
                    <form method="POST" action="">
                        <div class="titulo">
                            <h2>Agregar Proveedor</h2>
                            <a href="Provedores.php">
                                <img src="Imagenes/atras.png" alt="Botón Atrás" class="boton-atras" />
                            </a>
                        </div>

                        <div class="input-group">
                            <input type="text" name="Nombre" id="Nombre" required />
                            <label>Nombre del Proveedor</label>
                        </div>

                        <button type="submit" class="Acceder" name="Boton">Agregar</button>
                    </form>
                </div>
            </div>
        </section>
        <section class="derecha"></section>
    </main>
</body>
</html>
