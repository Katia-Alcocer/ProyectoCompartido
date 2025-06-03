<?php
session_start();

if (!isset($_SESSION['id'])) {
    die("Acceso denegado. Por favor inicia sesión.");
}

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

$host = "db";
$usuario = "root";
$clave = "clave";
$bd = "HerreriaUG";

try {
    $conn = new mysqli($host, $usuario, $clave, $bd);
    $conn->set_charset("utf8mb4");

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $nombre = $_POST['Nombre'];
        $apellidoP = $_POST['ApellidoP'];
        $apellidoM = $_POST['ApellidoM'];
        $telefono = $_POST['Telefono'];
        $email = $_POST['Email'];
        $edad = (int)$_POST['Edad'];
        $sexo = $_POST['Sexo'];
        $calle = $_POST['Calle'];
        $numero = (int)$_POST['Numero'];
        $cp = (int)$_POST['CP'];
        $puesto = $_POST['Puesto'];
        $rfc = $_POST['RFC'];
        $nss = $_POST['NSS'];
        $usuarioReg = $_POST['Usuario'];
        $claveReg = $_POST['Clave'];

        $passwordHash = password_hash($claveReg, PASSWORD_DEFAULT);

        $sql = "CALL RegistrarEmpleado(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);

        if (!$stmt) {
            throw new Exception("Error al preparar el procedimiento: " . $conn->error);
        }

        $stmt->bind_param(
            "sssssisssisssss",
            $nombre,
            $apellidoP,
            $apellidoM,
            $telefono,
            $email,
            $edad,
            $sexo,
            $calle,
            $numero,
            $cp,
            $puesto,
            $rfc,
            $nss,
            $usuarioReg,
            $passwordHash
        );

        $stmt->execute();

        echo "<script>alert('Empleado registrado correctamente'); window.location.href='Login.php';</script>";
    }
} catch (Exception $e) {
    echo "<h3>Error durante el registro:</h3>";
    echo "<pre>" . $e->getMessage() . "</pre>";
    echo "<pre>POST Recibido: " . print_r($_POST, true) . "</pre>";
} finally {
    if (isset($stmt)) $stmt->close();
    if (isset($conn)) $conn->close();
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Registro Empleados</title>
    <link rel="stylesheet" type="text/css" href="Registro.css" />
    <link rel="icon" href="Imagenes/Logo.jpg" type="image" />
</head>
<body>
    <main>
        <section class="centro">
            <div class="log">
                <div class="login">
                    <form method="POST" action="Registro.php">
                        <div class="titulo">
                            <h2>Registro de Empleado</h2>
                            <img src="Imagenes/Atras.png" alt="Volver" class="boton-atras" onclick="window.history.back();" />
                        </div>

                        <div class="input-group"><input type="text" name="Nombre" required placeholder=" " /><label>Nombre</label></div>
                        <div class="input-group"><input type="text" name="ApellidoP" required placeholder=" " /><label>Apellido Paterno</label></div>
                        <div class="input-group"><input type="text" name="ApellidoM" required placeholder=" " /><label>Apellido Materno</label></div>
                        <div class="input-group"><input type="tel" name="Telefono" required placeholder=" " /><label>Teléfono</label></div>
                        <div class="input-group"><input type="email" name="Email" required placeholder=" " /><label>Email</label></div>
                        <div class="input-group"><input type="number" name="Edad" required min="18" placeholder=" " /><label>Edad</label></div>
                        
                        <div class="input-group">
                            <select name="Sexo" required>
                                <option value="" disabled selected>Selecciona la opción</option>
                                <option value="H">Masculino</option>
                                <option value="M">Femenino</option>
                            </select>
                            <label>Sexo</label>
                        </div>

                        <div class="input-group"><input type="text" name="Calle" required placeholder=" " /><label>Calle</label></div>
                        <div class="input-group"><input type="number" name="Numero" required placeholder=" " /><label>Número</label></div>
                        <div class="input-group"><input type="number" name="CP" required placeholder=" " /><label>Código Postal</label></div>

                        <div class="input-group">
                            <select name="Puesto" required>
                                <option value="" disabled selected>Selecciona el puesto</option>
                                <option value="Cajero">Cajero</option>
                                <option value="Agente de Venta">Agente de Venta</option>
                            </select>
                            <label>Puesto</label>
                        </div>

                        <div class="input-group"><input type="text" name="RFC" required placeholder=" " /><label>RFC</label></div>
                        <div class="input-group"><input type="text" name="NSS" required placeholder=" " /><label>NSS</label></div>
                        <div class="input-group"><input type="text" name="Usuario" required placeholder=" " /><label>Usuario</label></div>
                        <div class="input-group"><input type="password" name="Clave" required placeholder=" " /><label>Contraseña</label></div>

                        <button type="submit" class="Acceder">Registrar</button>
                    </form>
                </div>
            </div>
        </section>
    </main>
    <footer>
        <p>&copy; 2025 Diamonds Corporation. Todos los derechos reservados.</p>
    </footer>
</body>
</html>
