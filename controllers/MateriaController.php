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