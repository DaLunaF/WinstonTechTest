<?php
    require "./../utils/db_connection.php";

    if(isset($_POST["functionname"]))
    {
        $functionname = $_POST["functionname"];

        if(isset($_POST["primer_nombre"]))
            $primer_nombre = $_POST["primer_nombre"];
        if(isset($_POST["segundo_nombre"]))
            $segundo_nombre = $_POST["segundo_nombre"];
        if(isset($_POST["apellido_paterno"]))
            $apellido_paterno = $_POST["apellido_paterno"];
        if(isset($_POST["apellido_materno"]))
            $apellido_materno = $_POST["apellido_materno"];
        if(isset($_POST["clave"]))
            $clave = $_POST["clave"];
        if(isset($_POST["contrato"]))
            $contrato = $_POST["contrato"];
        if(isset($_POST["calle"]))
            $calle = $_POST["calle"];
        if(isset($_POST["numero"]))
            $numero = $_POST["numero"];
        if(isset($_POST["colonia"]))
            $colonia = $_POST["colonia"];
        if(isset($_POST["telefono"]))
            $telefono = $_POST["telefono"];
        
        switch ($functionname) 
        {
            case 'InsertDocente':
                $response["data"] = InsertDocente($primer_nombre, $segundo_nombre, $apellido_paterno, $apellido_materno, $clave, $contrato, $calle, $numero, $colonia, $telefono);
                $response["success"] = true;
                break;
            case 'FetchDocentes':
                $response["data"] = FetchDocentes()["data"];
                $response["success"] = true;
            break;
            case 'DeleteDocente':
                $response["data"] = DeleteDocente($clave);
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

    function InsertDocente($f_primer_nombre, $f_segundo_nombre, $f_apellido_paterno, $f_apellido_materno, $f_clave, $f_contrato, $f_calle, $f_numero, $f_colonia, $f_telefono)
    {
        $query = "CALL SP_INSERT_DOCENTE('$f_calle', '$f_numero', '$f_colonia', '$f_primer_nombre', '$f_segundo_nombre', '$f_apellido_paterno', '$f_apellido_materno', '$f_clave', '$f_contrato', '$f_telefono');";
        $result = insert($query);
        return $result;
    }

    function FetchDocentes()
    {
        $query = "CALL SP_FETCH_DOCENTES();";
        $result = selectMultiple($query);
        return $result;
    }

    function DeleteDocente($f_clave)
    {
        $query = "CALL SP_DELETE_DOCENTE('$f_clave');";
        $response = update($query);
        return $response;
    }