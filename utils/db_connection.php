<?php
    date_default_timezone_set('America/Monterrey');
	session_start();

    function open_connection()
    {	
		$dbhost = "localhost";
		$dbuser = "root";
		$dbpass = "";
		$dbname = "winstontechtest";
		$conn = new mysqli($dbhost, $dbuser, $dbpass,$dbname) or die("Connect failed: %s\n". $conn -> error);
		mysqli_set_charset($conn, 'utf8');
		return $conn;        
    }

    function close_connection($mysqli)
    {
        $mysqli -> close();
    }

    function selectOne($query)
    {
        $mysqli = open_connection();
        $result = mysqli_query($mysqli, $query);
        $response['data'] = mysqli_fetch_assoc($result);
        $response['success'] = $response["data"] ? true : false;
        close_connection($mysqli);
        return $response;
    }

    function selectMultiple($query)
    {
        $mysqli = open_connection();
        $result = mysqli_query($mysqli, $query);
        $data = [];
        if($mysqli != false)
        {
            $i = 0;
            $empleados = [];
            while($row = mysqli_fetch_assoc($result))
            {
                $empleados[$i] = $row;
                $i++;
            }
            $response['success'] = true;
            $response['data'] = $empleados;
        }
        else
        {
            $response['success'] = false;
            $response['data'] = NULL;
        }
        close_connection($mysqli);
        return $response;
    }

    function insert($query)
    {
        $mysqli = open_connection();
        $result = mysqli_query($mysqli, $query);
        $data['success'] = $result ? true : false;
        
        if($result=mysqli_store_result($mysqli)){
            mysqli_free_result($result);
        } while(mysqli_more_results($mysqli) && mysqli_next_result($mysqli));
        
        close_connection($mysqli);
        return $data;
    }

    function update($query)
    {
        $mysqli = open_connection();
        $result = mysqli_query($mysqli, $query);
        $data['success'] = $result ? true : false;
        close_connection($mysqli);
        return $data;
    }

    function multiInsert($query)
    {
        $mysqli = open_connection();
        $result = mysqli_multi_query($mysqli, $query) or die(mysqli_error($mysqli));
        $data['success'] = $result ? true : false;

        if($result=mysqli_store_result($mysqli)){
            mysqli_free_result($result);
        } while(mysqli_more_results($mysqli) && mysqli_next_result($mysqli));

        close_connection($mysqli);
        return $data;
    }

    function multiResultSet($query)
    {
        $mysqli = open_connection();
        if (mysqli_multi_query($mysqli, $query)) 
        {
            $resultSets = array();
            do 
            {
                if ($result = mysqli_store_result($mysqli)) 
                {
                    $resultSet = array();
                    while ($row = mysqli_fetch_assoc($result)) 
                    {
                        $resultSet[] = $row;
                    }
                    mysqli_free_result($result);
                    $resultSets[] = $resultSet;
                }
            } 
            while (mysqli_more_results($mysqli) && mysqli_next_result($mysqli));
        } 
        
        close_connection($mysqli);
        return $resultSets;
    }