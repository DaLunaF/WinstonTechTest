<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Materias</title>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.22.1/dist/bootstrap-table.min.css">
</head>
<body>
    <?php include "./components/navbar.php" ?>

    <p class="title">Administrar materias</p>
    <div class="container">
        <div class="data-management">
            <form action="" id="create-materia-form">
                <span>
                    <input type="text" name="clave" placeholder="Clave">
                </span>
                <span>
                    <input type="text" name="nombre" placeholder="Nombre">
                </span>
                <span>
                    <input type="number" name="creditos" placeholder="Creditos">
                </span>
                <input type="text" name="functionname" value="InsertMateria" style="display:none;">
                <button>Crear</button>
            </form>
        </div>
    
        <div class="data-display">
            <table class="table table-striped table-bordered table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Clave</th>
                        <th scope="col">Nombre</th>
                        <th scope="col">Créditos</th>
                        <th scope="col">Docente</th>
                        <th scope="col">Options</th>
                    </tr>
                </thead>
                <tbody id="materias-table-body" class="materias-table-body">
                </tbody>
            </table>
        </div>
    </div>
    <!-- LOCAL STYLESHEETS -->
    <link rel="stylesheet" href="styles/app.css">
    <link rel="stylesheet" href="styles/materia.css">
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
    <script src="./scripts/materia.js"></script>
</body>
</html>