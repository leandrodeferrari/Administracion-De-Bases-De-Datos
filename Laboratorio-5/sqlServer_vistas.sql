-- Laboratorio Vistas

/*

	Una empresa almacena la información de sus empleados en dos tablas llamadas
	"empleados" y "secciones". Eliminamos las tablas, si existen:
    
	CREATE DATABASE PRUEBA
	GO
    
	USE PRUEBA
	GO
    
	IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleadosIF OBJECT_ID('secciones') IS NOT NULL
	DROP TABLE secciones;
    
    Creamos las tablas
    
	CREATE TABLE secciones (
	codigo TINYINT IDENTITY,
	nombre VARCHAR(20),
	sueldo DECIMAL(5,2) CONSTRAINT CK_secciones_sueldo CHECK (sueldo>=0),
	CONSTRAINT PK_secciones PRIMARY KEY (codigo)
	)
    
	CREATE TABLE empleados(
	legajo INT IDENTITY,
	documento CHAR(8)CONSTRAINT CK_empleados_documento CHECK (documento
	LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	sexo CHAR(1) CONSTRAINT CK_empleados_sexo CHECK (sexo in ('f','m')),
	apellido VARCHAR(20),
	nombre VARCHAR(20),
	domicilio VARCHAR(30),
	seccion TINYINT NOT NULL,
	cantidadhijos TINYINT CONSTRAINT CK_empleados_hijos CHECK
	(cantidadhijos>=0),
	estadocivil CHAR(10) CONSTRAINT CK_empleados_estadocivil CHECK (estadocivil
	in ('casado','divorciado','soltero','viudo')),
	fechaingreso DATETIME,
	CONSTRAINT PK_empleados PRIMARY KEY (legajo),
	sueldo DECIMAL(6,2),
	CONSTRAINT FK_empleados_seccion
	FOREIGN KEY (seccion)
	REFERENCES secciones(codigo),
	CONSTRAINT UQ_empleados_documento UNIQUE(documento)
	);
    
	Insertarmos registros en la tabla secciones
    
	insert into secciones values('Administracion',300);
	insert into secciones values('Contaduría',400);
	insert into secciones values('Sistemas',500);
    
	Insertamos registros en la tabla empleados
    
	insert into empleados values('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','1990-
	10-10',600);
	insert into empleados values('23333333','m','Lopez','Luis','Sucre
	235',1,0,'soltero','1990-02-10',650);
	insert into empleados values('24444444', 'm', 'Garcia', 'Marcos', 'Sarmiento 1234', 2, 3,
	'divorciado', '1998-07-12',800);
	insert into empleados values('25555555','m','Gomez','Pablo','Bulnes
	321',3,2,'casado','1998-10-09',900);
	insert into empleados values('26666666','f','Perez','Laura','Peru
	1254',3,3,'casado','2000-05-09',700);
    
*/

CREATE DATABASE PRUEBA
GO
    
USE PRUEBA
GO

IF OBJECT_ID('empleados') IS NOT NULL
DROP TABLE empleados

IF OBJECT_ID('secciones') IS NOT NULL
DROP TABLE secciones

CREATE TABLE secciones (
	codigo INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(20),
	sueldo DECIMAL(5,2) CONSTRAINT CK_secciones_sueldo CHECK (sueldo>=0),
	CONSTRAINT PK_secciones PRIMARY KEY (codigo)
)
    
CREATE TABLE empleados(
	legajo INT IDENTITY(1,1) NOT NULL,
	documento CHAR(8) CONSTRAINT CK_empleados_documento CHECK (documento
	LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	sexo CHAR(1) CONSTRAINT CK_empleados_sexo CHECK (sexo IN ('f','m')),
	apellido VARCHAR(20),
	nombre VARCHAR(20),
	domicilio VARCHAR(30),
	seccion INT NOT NULL,
	cantidadhijos TINYINT CONSTRAINT CK_empleados_hijos CHECK (cantidadhijos>=0),
	estadocivil CHAR(10) CONSTRAINT CK_empleados_estadocivil CHECK (estadocivil
	IN ('casado','divorciado','soltero','viudo')),
	fechaingreso DATETIME,
	CONSTRAINT PK_empleados PRIMARY KEY (legajo),
	sueldo DECIMAL(6,2),
	CONSTRAINT FK_empleados_seccion
	FOREIGN KEY (seccion)
	REFERENCES secciones(codigo),
	CONSTRAINT UQ_empleados_documento UNIQUE(documento)
)

INSERT INTO secciones (nombre, sueldo) VALUES ('Administracion',300)
INSERT INTO secciones (nombre, sueldo) VALUES ('Contaduría',400)
INSERT INTO secciones (nombre, sueldo) VALUES ('Sistemas',500)

INSERT INTO empleados (documento, sexo, apellido, nombre, domicilio, seccion, cantidadhijos, estadocivil, fechaingreso, sueldo) VALUES ('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','1990-10-10',600)
INSERT INTO empleados (documento, sexo, apellido, nombre, domicilio, seccion, cantidadhijos, estadocivil, fechaingreso, sueldo) VALUES ('23333333','m','Lopez','Luis','Sucre235',1,0,'soltero','1990-02-10',650)
INSERT INTO empleados (documento, sexo, apellido, nombre, domicilio, seccion, cantidadhijos, estadocivil, fechaingreso, sueldo) VALUES ('24444444', 'm', 'Garcia', 'Marcos', 'Sarmiento 1234', 2, 3,'divorciado', '1998-07-12',800)
INSERT INTO empleados (documento, sexo, apellido, nombre, domicilio, seccion, cantidadhijos, estadocivil, fechaingreso, sueldo) VALUES ('25555555','m','Gomez','Pablo','Bulnes321',3,2,'casado','1998-10-09',900)
INSERT INTO empleados (documento, sexo, apellido, nombre, domicilio, seccion, cantidadhijos, estadocivil, fechaingreso, sueldo) VALUES ('26666666','f','Perez','Laura','Peru1254',3,3,'casado','2000-05-09',700)

/*
    
	1) Eliminar la vista "vista_empleados" si existe
    
*/
    
USE PRUEBA
GO

DROP VIEW IF EXISTS vista_empleados

/*
    
	2) Crear la vista "vista_empleados", que es resultado de una combinación en la cual se
	muestran 4 campos:
	APELLIDO Y NOMBRE contatenando
	sexo
	seccion
	cantidad de hijos
    
*/
    
USE PRUEBA

CREATE VIEW vista_empleados (nombreApellido, sexo, seccion, cantidad_de_hijos)
AS (SELECT CONCAT(nombre, apellido) AS nombreApellido, sexo, seccion, cantidadhijos FROM empleados)

/*
    
	3) Consular la información contenida en la vista
    
*/
    
USE PRUEBA
GO

SELECT * FROM vista_empleados

/*
    
	4) Eliminamos la vista "vista_empleados2" si existe
    
*/
    
USE PRUEBA
GO

DROP VIEW IF EXISTS vista_empleados2

/*
    
	5) Crear otra vista de "empleados" denominada "vista_empleados2" que consulta
	solamente la tabla "empleados"
    
*/
    
USE PRUEBA;

CREATE VIEW vista_empleados2 AS (SELECT * FROM empleados)

/*
    
	6) Consultar la informacion de la vista empleados2
    
*/
    
USE PRUEBA
GO

SELECT * FROM vista_empleados2

/*
    
	7) Ingresamos un registro en la vista "vista_empleados" (se puede hacer, que pasa)
    
*/

USE PRUEBA
GO

INSERT INTO vista_empleados (nombreApellido, sexo, seccion, cantidad_de_hijos) VALUES ('Leandro Deferrari', 'M', 1, 0)

-- No me deja porque tiene un campo concatenado (nombreApellido)
-- También hay que tener cuidado cuando hay relaciones, en nuestra tabla original

INSERT INTO vista_empleados2 (documento, sexo, apellido, nombre, domicilio, seccion, cantidadhijos, estadocivil, fechaingreso, sueldo) 
	VALUES ('26646566','m','Perez','Laura','Peru1254',3,3,'casado','2000-05-09',700)

-- Acá sí me dejo ingresar un registro, correctamente

/*
    
	8) Actualizar el nombre de un registro de la vista "vista_empleados2", Verifique que se
	actualizó la tabla
    
*/
    
USE PRUEBA
GO

UPDATE vista_empleados2
SET nombre = 'Leandro' WHERE legajo = 1

-- Se actualizó correctamente

/*
    
	9) Eliminar un registro de la vista "vista_empleados2" y uno de la vista
	"vista_empleados1". Que ocurre?
    
*/
    
USE PRUEBA
GO
 
DELETE FROM vista_empleados2 WHERE legajo = 2
 
DELETE FROM vista_empleados WHERE seccion = 1
 
 -- Me borró correctamente, en ambos casos