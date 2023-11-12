DROP TABLE IF EXISTS tr_docente_materia;
DROP TABLE IF EXISTS tr_alumno_materia;
DROP TABLE IF EXISTS t_telefono;
DROP TABLE IF EXISTS t_docente;
DROP TABLE IF EXISTS t_alumno;
DROP TABLE IF EXISTS t_materia;
DROP TABLE IF EXISTS t_nombre;
DROP TABLE IF EXISTS t_direccion;


CREATE TABLE t_materia(
	pk_materia	INT NOT NULL AUTO_INCREMENT,
    clave		VARCHAR(10) NOT NULL UNIQUE,
    nombre		VARCHAR(50) NOT NULL UNIQUE,
    creditos	INT NOT NULL,
    
    PRIMARY KEY(pk_materia)
);


CREATE TABLE t_nombre(
	pk_nombre			INT NOT NULL  AUTO_INCREMENT,
    primer_nombre		VARCHAR(50) NOT NULL,
    segundo_nombre		VARCHAR(50) NOT NULL,
    apellido_paterno	VARCHAR(50) NOT NULL,
    apellido_materno	VARCHAR(50) NOT NULL,
    
    PRIMARY KEY(pk_nombre)
);


CREATE TABLE t_direccion(
	pk_direccion	INT NOT NULL AUTO_INCREMENT,
    calle			VARCHAR(50),
    numero			VARCHAR(5),
    colonia			VARCHAR(50),
    
    PRIMARY KEY(pk_direccion)
);


CREATE TABLE t_docente(
	pk_docente		INT NOT NULL AUTO_INCREMENT,
    fk_direccion	INT NOT NULL,
    fk_nombre		INT NOT NULL,
    clave			VARCHAR(10) NOT NULL,
    contrato		VARCHAR(50),
    
    PRIMARY KEY(pk_docente),
    FOREIGN KEY (fk_direccion) REFERENCES t_direccion(pk_direccion),
    FOREIGN KEY (fk_nombre) REFERENCES t_nombre(pk_nombre)
);

CREATE TABLE t_telefono(
	pk_telefono INT NOT NULL AUTO_INCREMENT,
    fk_docente	INT NOT NULL,
    telfono		VARCHAR(10) NOT NULL,
    
    PRIMARY KEY(pk_telefono),
    FOREIGN KEY(fk_docente) REFERENCES t_docente(pk_docente)
);

CREATE TABLE t_alumno(
	pk_alumno 		INT NOT NULL AUTO_INCREMENT,
    fk_direccion	INT NOT NULL,
    fk_nombre		INT NOT NULL,
    
    PRIMARY KEY(pk_alumno),
    FOREIGN KEY(fk_direccion) REFERENCES t_direccion(pk_direccion),
    FOREIGN KEY(fk_nombre) REFERENCES t_nombre(pk_nombre)
);

CREATE TABLE tr_docente_materia(
	pk_docente_materia	INT NOT NULL AUTO_INCREMENT,
    fk_docente			INT NOT NULL,
    fk_materia			INT NOT NULL,
    
    PRIMARY KEY(pk_docente_materia),
    FOREIGN KEY(fk_docente) REFERENCES t_docente(pk_docente),
    FOREIGN KEY(fk_materia) REFERENCES t_materia(pk_materia)
);

CREATE TABLE tr_alumno_materia(
	pk_alumno_materia 	INT NOT NULL AUTO_INCREMENT,
    fk_alumno			INT NOT NULL,
    fk_materia			INT NOT NULL,
    
    PRIMARY KEY(pk_alumno_materia),
    FOREIGN KEY(fk_alumno) REFERENCES t_alumno(pk_alumno),
    FOREIGN KEY(fk_materia) REFERENCES t_materia(pk_materia)
);