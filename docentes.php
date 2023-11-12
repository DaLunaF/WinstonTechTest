<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Docentes</title>
</head>
<body>
<?php include "./components/navbar.php" ?>

<p class="title">Administrar docentes</p>
<div class="container">
    <div class="data-management">
        <form action="" id="create-docente-form">
            <span>
                <input type="text" name="primer_nombre" placeholder="Primer nombre">
            </span>
            <span>
                <input type="text" name="segundo_nombre" placeholder="Segundo nombre">
            </span>
            <span>
                <input type="text" name="apellido_paterno" placeholder="Apellido materno">
            </span>
            <span>
                <input type="text" name="apellido_materno" placeholder="Apellido materno">
            </span>
            <span>
                <input type="text" name="clave" placeholder="Clave">
            </span>
            <span>
                <select name="contrato" id="">
                    <option value="fijo">Fijo</option>
                    <option value="variable">Variable</option>
                    <option value="mixto">Mixto</option>
                </select>
            </span>
            <span>
                <input type="text" name="calle" placeholder="Calle">
            </span>
            <span>
                <input type="text" name="numero" placeholder="Número">
            </span>
            <span>
                <input type="text" name="colonia" placeholder="Colonia">
            </span>
            <span>
                <input type="tel" name="telefono" placeholder="Numero telefónico">
            </span>
            <input type="text" name="functionname" value="InsertDocente" style="display:none;">
            <button>Crear</button>
        </form>
    </div>

    <div class="data-display">
        <table class="table table-striped table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">#</th>
                    <td>Nombre</td>
                    <td>Clave</td>
                    <td>Contrato</td>
                    <td>Dirección</td>
                    <td>Teléfono(s)</td>
                    <td>Options</td>
                </tr>
            </thead>
            <tbody id="docentes-table-body" class="docentes-table-body">
                <!-- <tr>
                    <th scope="row">1</th>
                    <td>Mark</td>
                    <td>Otto</td>
                    <td>@mdo</td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                </tr> -->
            </tbody>
        </table>
    </div>
</div>
<!-- LOCAL STYLESHEETS -->
<link rel="stylesheet" href="styles/app.css">
<link rel="stylesheet" href="styles/docentes.css">
<!-- JQUERY -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script type="text/javascript" src="./scripts/jquery.validate.min.js"></script>
<!-- BOOTSTRAP -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script src="https://unpkg.com/bootstrap-table@1.22.1/dist/bootstrap-table.min.js"></script>z
<!-- FONT -->
<link href="https://fonts.googleapis.com/css2?family=Young+Serif&display=swap" rel="stylesheet">
<!-- LOCAL SCRIPT -->
<script src="./scripts/docentes.js"></script>
</body>
</html>