-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 14, 2023 at 06:50 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `winstontechtest`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ADD_TELEFONO` (IN `SP_CLAVE_DOCENTE` VARCHAR(10), IN `SP_TELEFONO` VARCHAR(10))   BEGIN
	SELECT pk_docente INTO @SP_FK_DOCENTE
    FROM t_docente
    WHERE clave = SP_CLAVE_DOCENTE;
    
    INSERT INTO t_telefono(fk_docente, telfono)
    VALUES(@SP_FK_DOCENTE, SP_TELEFONO);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ASIGNAR_DOCENTE_MATERIA` (IN `SP_CLAVE_MATERIA` VARCHAR(10), IN `SP_CLAVE_DOCENTE` VARCHAR(10))   BEGIN
	SELECT tr_docente_materia.pk_docente_materia 
    INTO @SP_PK_DOCENTE_MATERIA
    FROM tr_docente_materia 
    JOIN t_materia ON tr_docente_materia.fk_materia = t_materia.pk_materia
    WHERE t_materia.clave = SP_CLAVE_MATERIA;

	SELECT t_docente.pk_docente INTO @SP_PK_DOCENTE
    FROM t_docente 
    WHERE t_docente.clave = SP_CLAVE_DOCENTE;

	IF(@SP_PK_DOCENTE_MATERIA IS NULL)
        THEN BEGIN
        	SELECT t_materia.pk_materia INTO @SP_PK_MATERIA 
            FROM t_materia 
            WHERE t_materia.clave = SP_CLAVE_MATERIA;
            
        	INSERT INTO tr_docente_materia(tr_docente_materia.fk_docente, tr_docente_materia.fk_materia)
            VALUES(@SP_PK_DOCENTE, @SP_PK_MATERIA);
        END;
        ELSE BEGIN
        	UPDATE tr_docente_materia
            SET tr_docente_materia.fk_docente = @SP_PK_DOCENTE
            WHERE tr_docente_materia.pk_docente_materia = @SP_PK_DOCENTE_MATERIA;
        END;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DELETE_DOCENTE` (IN `SP_CLAVE` VARCHAR(10))   BEGIN
    SELECT t_docente.pk_docente, t_docente.fk_direccion, t_docente.fk_nombre  
    INTO @SP_PK_DOCENTE, @SP_PK_DIRECCION, @SP_PK_NOMBRE 
    FROM t_docente
    WHERE t_docente.clave = SP_CLAVE;
    
    DELETE FROM t_telefono
    WHERE t_telefono.fk_docente = @SP_PK_DOCENTE;
    
    DELETE FROM t_docente 
    WHERE t_docente.clave = SP_CLAVE;
    
    DELETE FROM t_direccion
    WHERE t_direccion.pk_direccion = @SP_PK_DIRECCION;
    
    DELETE FROM t_nombre 
    WHERE t_nombre.pk_nombre = @SP_FK_NOMBRE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_DELETE_MATERIA` (IN `SP_CLAVE` VARCHAR(10))   BEGIN
	SELECT tr_docente_materia.fk_materia 
    INTO @SP_PK_MATERIA
    FROM tr_docente_materia 
    JOIN t_materia ON tr_docente_materia.fk_materia = t_materia.pk_materia
    WHERE t_materia.clave = SP_CLAVE;

	DELETE FROM tr_docente_materia 
    WHERE tr_docente_materia.fk_materia = @SP_PK_MATERIA; 
    
	DELETE
    FROM t_materia 
    WHERE t_materia.clave = SP_CLAVE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_FETCH_DOCENTES` ()   BEGIN
	SELECT t_nombre.primer_nombre, t_nombre.segundo_nombre, t_nombre.apellido_paterno, t_nombre.apellido_materno, t_docente.clave, t_docente.contrato, t_telefono.telfono, t_direccion.calle, t_direccion.numero, t_direccion.colonia
    FROM t_docente
    JOIN t_nombre ON t_docente.fk_nombre = t_nombre.pk_nombre
    JOIN t_direccion ON t_docente.fk_direccion = t_direccion.pk_direccion
    LEFT JOIN t_telefono ON t_telefono.fk_docente = t_docente.pk_docente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_FETCH_MATERIAS` ()   BEGIN
	SELECT t_materia.nombre, t_materia.clave, t_materia.creditos, t_docente.clave AS clave_docente
    FROM t_materia
    LEFT JOIN tr_docente_materia
    ON t_materia.pk_materia = tr_docente_materia.fk_materia
    LEFT JOIN t_docente 
    ON tr_docente_materia.fk_docente = t_docente.pk_docente;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERT_DOCENTE` (IN `SP_CALLE` VARCHAR(50), IN `SP_NUMERO` VARCHAR(5), IN `SP_COLONIA` VARCHAR(50), IN `SP_PRIMER_NOMBRE` VARCHAR(50), IN `SP_SEGUNDO_NOMBRE` VARCHAR(50), IN `SP_APELLIDO_PATERNO` VARCHAR(50), IN `SP_APELLIDO_MATERNO` VARCHAR(50), IN `SP_CLAVE` VARCHAR(10), IN `SP_CONTRATO` VARCHAR(50), IN `SP_TELEFONO` VARCHAR(10))   BEGIN
	INSERT INTO t_direccion(t_direccion.calle, t_direccion.numero, t_direccion.colonia)
    VALUES(SP_CALLE, SP_NUMERO, SP_COLONIA);
    SET @SP_FK_DIRECCION = last_insert_id();
    
    INSERT INTO t_nombre(primer_nombre, segundo_nombre, apellido_paterno, apellido_materno)
    VALUES(SP_PRIMER_NOMBRE, SP_SEGUNDO_NOMBRE, SP_APELLIDO_PATERNO, SP_APELLIDO_MATERNO);
    SET @SP_FK_NOMBRE = last_insert_id();
    
    INSERT INTO t_docente(fk_direccion, fk_nombre, clave, contrato)
    VALUES(@SP_FK_DIRECCION, @SP_FK_NOMBRE, SP_CLAVE, SP_CONTRATO);
	SET @SP_FK_DOCENTE = last_insert_id();
    
    INSERT INTO t_telefono(fk_docente, telfono)
    VALUES(@SP_FK_DOCENTE, SP_TELEFONO);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_INSERT_MATERIA` (IN `SP_CLAVE` VARCHAR(10), IN `SP_NOMBRE` VARCHAR(50), IN `SP_CREDITOS` INT)   BEGIN
	INSERT INTO t_materia(clave, nombre, creditos)
    VALUES(SP_CLAVE, SP_NOMBRE, SP_CREDITOS);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tr_alumno_materia`
--

CREATE TABLE `tr_alumno_materia` (
  `pk_alumno_materia` int(11) NOT NULL,
  `fk_alumno` int(11) NOT NULL,
  `fk_materia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tr_docente_materia`
--

CREATE TABLE `tr_docente_materia` (
  `pk_docente_materia` int(11) NOT NULL,
  `fk_docente` int(11) NOT NULL,
  `fk_materia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tr_docente_materia`
--

INSERT INTO `tr_docente_materia` (`pk_docente_materia`, `fk_docente`, `fk_materia`) VALUES
(3, 5, 10);

-- --------------------------------------------------------

--
-- Table structure for table `t_alumno`
--

CREATE TABLE `t_alumno` (
  `pk_alumno` int(11) NOT NULL,
  `fk_direccion` int(11) NOT NULL,
  `fk_nombre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_direccion`
--

CREATE TABLE `t_direccion` (
  `pk_direccion` int(11) NOT NULL,
  `calle` varchar(50) DEFAULT NULL,
  `numero` varchar(5) DEFAULT NULL,
  `colonia` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_direccion`
--

INSERT INTO `t_direccion` (`pk_direccion`, `calle`, `numero`, `colonia`) VALUES
(3, 'Mares', '512', 'Vista del Sol'),
(4, 'Mares', '512', 'Vista del Sol'),
(5, 'Marte', '356', 'Asteroides del Valle');

-- --------------------------------------------------------

--
-- Table structure for table `t_docente`
--

CREATE TABLE `t_docente` (
  `pk_docente` int(11) NOT NULL,
  `fk_direccion` int(11) NOT NULL,
  `fk_nombre` int(11) NOT NULL,
  `clave` varchar(10) NOT NULL,
  `contrato` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_docente`
--

INSERT INTO `t_docente` (`pk_docente`, `fk_direccion`, `fk_nombre`, `clave`, `contrato`) VALUES
(4, 4, 4, 'JAVI_0238', 'variable'),
(5, 5, 5, 'JUAN_3578', 'fijo');

-- --------------------------------------------------------

--
-- Table structure for table `t_materia`
--

CREATE TABLE `t_materia` (
  `pk_materia` int(11) NOT NULL,
  `clave` varchar(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `creditos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_materia`
--

INSERT INTO `t_materia` (`pk_materia`, `clave`, `nombre`, `creditos`) VALUES
(10, 'HIS3_P687', 'Historia III', 4);

-- --------------------------------------------------------

--
-- Table structure for table `t_nombre`
--

CREATE TABLE `t_nombre` (
  `pk_nombre` int(11) NOT NULL,
  `primer_nombre` varchar(50) NOT NULL,
  `segundo_nombre` varchar(50) NOT NULL,
  `apellido_paterno` varchar(50) NOT NULL,
  `apellido_materno` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_nombre`
--

INSERT INTO `t_nombre` (`pk_nombre`, `primer_nombre`, `segundo_nombre`, `apellido_paterno`, `apellido_materno`) VALUES
(1, 'Nemesio', 'Mir', 'Arévalo', 'Verutes'),
(2, 'Mariano', 'Florencio', 'Flores', 'Mirlo'),
(3, 'Mariano', 'Florencio', 'Flores', 'Mirlo'),
(4, 'Javier', 'Armando', 'Cavazos', 'De La Garza'),
(5, 'Juan', 'Manuel', 'Ortega', 'Salinas');

-- --------------------------------------------------------

--
-- Table structure for table `t_telefono`
--

CREATE TABLE `t_telefono` (
  `pk_telefono` int(11) NOT NULL,
  `fk_docente` int(11) NOT NULL,
  `telfono` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `t_telefono`
--

INSERT INTO `t_telefono` (`pk_telefono`, `fk_docente`, `telfono`) VALUES
(3, 4, '8114730300'),
(4, 5, '8123675986');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tr_alumno_materia`
--
ALTER TABLE `tr_alumno_materia`
  ADD PRIMARY KEY (`pk_alumno_materia`),
  ADD KEY `fk_alumno` (`fk_alumno`),
  ADD KEY `fk_materia` (`fk_materia`);

--
-- Indexes for table `tr_docente_materia`
--
ALTER TABLE `tr_docente_materia`
  ADD PRIMARY KEY (`pk_docente_materia`),
  ADD KEY `fk_docente` (`fk_docente`),
  ADD KEY `fk_materia` (`fk_materia`);

--
-- Indexes for table `t_alumno`
--
ALTER TABLE `t_alumno`
  ADD PRIMARY KEY (`pk_alumno`),
  ADD KEY `fk_direccion` (`fk_direccion`),
  ADD KEY `fk_nombre` (`fk_nombre`);

--
-- Indexes for table `t_direccion`
--
ALTER TABLE `t_direccion`
  ADD PRIMARY KEY (`pk_direccion`);

--
-- Indexes for table `t_docente`
--
ALTER TABLE `t_docente`
  ADD PRIMARY KEY (`pk_docente`),
  ADD UNIQUE KEY `clave` (`clave`),
  ADD KEY `fk_direccion` (`fk_direccion`),
  ADD KEY `fk_nombre` (`fk_nombre`);

--
-- Indexes for table `t_materia`
--
ALTER TABLE `t_materia`
  ADD PRIMARY KEY (`pk_materia`),
  ADD UNIQUE KEY `clave` (`clave`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `t_nombre`
--
ALTER TABLE `t_nombre`
  ADD PRIMARY KEY (`pk_nombre`);

--
-- Indexes for table `t_telefono`
--
ALTER TABLE `t_telefono`
  ADD PRIMARY KEY (`pk_telefono`),
  ADD KEY `fk_docente` (`fk_docente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tr_alumno_materia`
--
ALTER TABLE `tr_alumno_materia`
  MODIFY `pk_alumno_materia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tr_docente_materia`
--
ALTER TABLE `tr_docente_materia`
  MODIFY `pk_docente_materia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `t_alumno`
--
ALTER TABLE `t_alumno`
  MODIFY `pk_alumno` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `t_direccion`
--
ALTER TABLE `t_direccion`
  MODIFY `pk_direccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `t_docente`
--
ALTER TABLE `t_docente`
  MODIFY `pk_docente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `t_materia`
--
ALTER TABLE `t_materia`
  MODIFY `pk_materia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `t_nombre`
--
ALTER TABLE `t_nombre`
  MODIFY `pk_nombre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `t_telefono`
--
ALTER TABLE `t_telefono`
  MODIFY `pk_telefono` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tr_alumno_materia`
--
ALTER TABLE `tr_alumno_materia`
  ADD CONSTRAINT `tr_alumno_materia_ibfk_1` FOREIGN KEY (`fk_alumno`) REFERENCES `t_alumno` (`pk_alumno`),
  ADD CONSTRAINT `tr_alumno_materia_ibfk_2` FOREIGN KEY (`fk_materia`) REFERENCES `t_materia` (`pk_materia`);

--
-- Constraints for table `tr_docente_materia`
--
ALTER TABLE `tr_docente_materia`
  ADD CONSTRAINT `tr_docente_materia_ibfk_1` FOREIGN KEY (`fk_docente`) REFERENCES `t_docente` (`pk_docente`),
  ADD CONSTRAINT `tr_docente_materia_ibfk_2` FOREIGN KEY (`fk_materia`) REFERENCES `t_materia` (`pk_materia`);

--
-- Constraints for table `t_alumno`
--
ALTER TABLE `t_alumno`
  ADD CONSTRAINT `t_alumno_ibfk_1` FOREIGN KEY (`fk_direccion`) REFERENCES `t_direccion` (`pk_direccion`),
  ADD CONSTRAINT `t_alumno_ibfk_2` FOREIGN KEY (`fk_nombre`) REFERENCES `t_nombre` (`pk_nombre`);

--
-- Constraints for table `t_docente`
--
ALTER TABLE `t_docente`
  ADD CONSTRAINT `t_docente_ibfk_1` FOREIGN KEY (`fk_direccion`) REFERENCES `t_direccion` (`pk_direccion`),
  ADD CONSTRAINT `t_docente_ibfk_2` FOREIGN KEY (`fk_nombre`) REFERENCES `t_nombre` (`pk_nombre`);

--
-- Constraints for table `t_telefono`
--
ALTER TABLE `t_telefono`
  ADD CONSTRAINT `t_telefono_ibfk_1` FOREIGN KEY (`fk_docente`) REFERENCES `t_docente` (`pk_docente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
