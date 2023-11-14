<?php
    require "./../utils/db_connection.php";

    if(isset($_POST["functionname"]))
    {
        $functionname = $_POST["functionname"];

        if(isset($_POST["clave"]))
            $clave = $_POST["clave"];
        if(isset($_POST["nombre"]))
            $nombre = $_POST["nombre"];
        if(isset($_POST["creditos"]))
            $creditos = $_POST["creditos"];
        if(isset($_POST["clave_docente"]))
            $clave_docente = $_POST["clave_docente"];
        
        switch ($functionname) 
        {
            case 'InsertMateria':
                $response["data"] = InsertMateria($clave, $nombre, $creditos);
                $response["success"] = true;
                break;
            case 'FetchMaterias':
                $response["data"] = FetchMaterias()["data"];
                $response["success"] = true;
            break;
            case 'DeleteMateria':
                $response["data"] = DeleteMateria($clave);
                $response["success"] = true;
            break;
            case 'AsignarDocenteMateria':
                $response["data"] = AsignarDocenteMateria($clave, $clave_docente);
                $response["success"] = true;
            break;
            default:
                $response["data"] = null;
                $response["success"] = false;
                $response["message"] = "Function does not exist!";
            break;
        }
    }
    else
    {
        $response["data"] = null;
        $response["success"] = false;
        $response["message"] = "No function name!";
    }
    echo json_encode($response);

    function InsertMateria($f_clave, $f_nombre, $f_creditos)
    {
        $query = "CALL SP_INSERT_MATERIA('$f_clave', '$f_nombre', $f_creditos);";
        $result = insert($query);
        return $result;
    }

    function FetchMaterias()
    {
        $query = "CALL SP_FETCH_MATERIAS();";
        $result = selectMultiple($query);
        return $result;
    }

    function DeleteMateria($f_clave)
    {
        $query = "CALL SP_DELETE_MATERIA('$f_clave');";
        $response = update($query);
        return $response;
    }

    function AsignarDocenteMateria($f_clave, $f_clave_docente)
    {
        $query = "CALL SP_ASIGNAR_DOCENTE_MATERIA('$f_clave', '$f_clave_docente');";
        return insert($query);
    }