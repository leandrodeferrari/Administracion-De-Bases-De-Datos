-- Para todos los ejercicios se debe preguntar si existen los objetos.
-- Crear una base de datos llamada Laboratorio.

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'Laboratorio')
	BEGIN
    CREATE DATABASE Laboratorio
	END

/*

	1) Crear la tabla llamada prueba, dentro de la Base de datos Laborario
	Campos:
	idCodido alfanumerico de longitud fija de 4 caracteres que no admite nulos
	nombre alfanumerico de longitud variable de 30 caracteres que no admite nulos
	precio decimal con dos decimales que no admite nulos
	edad numero que no adminte nulos.
	
*/

USE Laboratorio
GO

CREATE SCHEMA test
GO

IF OBJECT_ID('prueba', 'U') IS NULL
BEGIN
  CREATE TABLE test.prueba(
	idCodigo CHAR(4) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    edad TINYINT NOT NULL)
END

/*

	2) Crear una tabla llamado operador que contenga los siguientes campos:
	codigo_operador alfanumerico de longitud fija de 10 caracteres no admite nulos
	nombre alfanumerico de longitud variable de 40 caracteres no admite nulos
	fecha_ingreso de tipo fecha no admite nulos
	edad numero no admite nulos
	Luego de creada, añadir una columna llamada telefono alfanumerico de longitud
	variable de 20 caracteres.

*/

USE Laboratorio
GO

IF OBJECT_ID('operador', 'U') IS NULL
BEGIN
  CREATE TABLE operador(
	codigo_operador CHAR(10) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    edad TINYINT NOT NULL)
END

ALTER TABLE Laboratorio.dbo.operador
ADD telefono VARCHAR(20);

/*

	3) Crear la tabla facturas dentro de la base de datos con el siguiente detalle:
	letra alfanumerico de longitud fija 1 caracter y PK
	numero numérico entero y PK
	cliente_id numérico entero que no admite nulos
	articulo_id numérico entero que no admite nulos
	fecha_factura de tipo fecha no admite nulos
	monto decimal de dos caracteres que no admite nulos
	PK significa Primary Key observar que se está declarando una clave primaria compuesta
	es decir (letra, código)
	Cada campo por sí solo no es clave, ni tampoco identifica al registro pero la suma de los
	dos forman la clave.
    
*/

USE Laboratorio
GO

IF OBJECT_ID('facturas', 'U') IS NULL
BEGIN
  CREATE TABLE facturas(
	letra CHAR(1),
    numero INT,
    cliente_id INT NOT NULL,
    articulo_id INT NOT NULL,
    fecha_factura DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_facturas_letra_numero PRIMARY KEY (letra,numero))
END

/*

	4) Crear la tabla articulos dentro de la base de datos con el siguiente detalle:
	articulo_id numérico entero y PK auto incrementeal que comience en 1
	nombre alfanumerico de longitud variable de 50 caracteres que no admite nulos
	precio decimal no admite nulos
	stock numérico entero que no admite nulos.
    
*/

USE Laboratorio
GO

IF OBJECT_ID('articulos', 'U') IS NULL
BEGIN
  CREATE TABLE articulos(
	articulo_id INT IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    CONSTRAINT PK_articulos_articulo_id PRIMARY KEY (articulo_id))
END

/*
	5) Crear la tabla clientes dentro de la base de datos con el siguiente detalle
	cliente_id tipo de dato entero y PK auto incrementeal que comience en 1
	nombre alfanumerico de longitud variable de 25 caracteres no admite nulos
	apellido alfanumerico de longitud variable de 25 caracteres no admite nulos
	cuit alfanumerico de longitud fija de 16 caracteres no adminte nulos
	direccion alfanumerico de longitud variable de 50 caracteres admite nulos
	comentarios alfanumerico de longitud variable de 50 caracteres admite nulos
    
*/

USE Laboratorio
GO

IF OBJECT_ID('clientes', 'U') IS NULL
BEGIN
  CREATE TABLE clientes(
	cliente_id INT IDENTITY(1,1),
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    cuit CHAR(16) NOT NULL,
    direccion VARCHAR(50),
    comentarios VARCHAR(50),
    CONSTRAINT PK_clientes_cliente_id PRIMARY KEY (cliente_id))
END

/*

	6) A la tabla facturas:
	6.1) Agregar un campo observacion alfanumerico de longitud variable de 100 caracteres
	que admite nulos.
	6.2) Modificar el tipo de dato a alfanumerico de longitud variable de 200 caracteres que
	no admite nulos.
	6.3) Eliminar el campo observacion.
    
*/

ALTER TABLE Laboratorio.dbo.facturas
ADD observacion VARCHAR(100);

ALTER TABLE Laboratorio.dbo.facturas
ALTER COLUMN observacion VARCHAR(200) NOT NULL;

ALTER TABLE Laboratorio.dbo.facturas
DROP COLUMN observacion;
	
/*
	7) Dada la tabla empleados:
	CREATE TABLE empleados (
	idempleado INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	nroDocumento VARCHAR(11) NOT NULL,
	fechaCreacion DATETIME NOT NULL,
	edad TINYINT NOT NULL
	)
    
	7.1) Crear una restriccion de clave primaria para el campo idempleado.
	7.2) Crear una restriccion unique al campo nroDocumento.
	7.3) Crear una restriccion check para que la edad no sea negativa.
	7.4) Crear una restriccion default para el campo fechaCreacion que sea la fecha del
	servidor (SQL → GETDATE(), MySQL →CURDATE()).
    7.5) Deshabilitar las restricciones creadas para edad.
    
*/

USE Laboratorio
GO

IF OBJECT_ID('empleados', 'U') IS NULL
BEGIN
  CREATE TABLE empleados(
	idempleado INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	nroDocumento VARCHAR(11) NOT NULL,
	fechaCreacion DATETIME NOT NULL,
	edad TINYINT NOT NULL)
END

ALTER TABLE Laboratorio.dbo.empleados
ADD CONSTRAINT PK_empleados_idempleado PRIMARY KEY (idempleado);

ALTER TABLE Laboratorio.dbo.empleados
ADD CONSTRAINT UQ_empleados_nroDocumento UNIQUE (nroDocumento);

ALTER TABLE Laboratorio.dbo.empleados
ADD CONSTRAINT CK_empleados_edad CHECK (edad >= 0);

ALTER TABLE Laboratorio.dbo.empleados
ADD CONSTRAINT DF_empleados_fechaCreacion DEFAULT (GETDATE()) FOR fechaCreacion;

ALTER TABLE Laboratorio.dbo.empleados
NOCHECK CONSTRAINT CK_empleados_edad;

/*
	8) A la tabla de facturas crear las restriccion FK para los campos cliente_id y articulo_id.
    
*/

USE Laboratorio
GO

ALTER TABLE Laboratorio.dbo.facturas
ADD CONSTRAINT FK_facturas_cliente_id FOREIGN KEY (cliente_id) REFERENCES dbo.clientes(cliente_id);

ALTER TABLE Laboratorio.dbo.facturas
ADD CONSTRAINT FK_facturas_articulo_id FOREIGN KEY (articulo_id) REFERENCES dbo.articulos(articulo_id);

/*

	9) Crear la tabla usuarios que contengá los siguientes campos:
	- clave: alfanumerico de 10 caracteres de longitud variable.
	- nombre: alfanumerico de 30 caracteres de longitud variable,
	Definir el campo "nombre" como clave primaria.
    
*/

USE Laboratorio
GO

IF OBJECT_ID('usuarios', 'U') IS NULL
BEGIN
  CREATE TABLE usuarios(
	clave VARCHAR(10),
    nombre VARCHAR(30),
    CONSTRAINT PK_usuarios_nombre PRIMARY KEY (nombre))
END

/*

	10) Crear la tabla libros con la siguiente estructura:
	Creamos la tabla especificando que el campo "codigo" genere valores secuenciales
	en 1 e incrementándose en 1 automáticamente y que sea PK.
	codigo numero,
	titulo alfanumerico de 50 caracteres no nulo,
	autor alfanumerico de 30 caracteres no nulo,
	editorial alfanumerico de 20 caracteres no nulo,
	precio decimal no nulo.
    
    10.1) Al campo autor setearle por defecto el valor “Desconocido”.
	10.2) Al campo precio setearlo una restricción check que su valor sea positivo.
	10.3) Escribir la sintaxis para deshabilitar la restricción check sobre el campo precio.

*/

USE Laboratorio;
GO

IF OBJECT_ID('libros', 'U') IS NULL
BEGIN
  CREATE TABLE libros(
	codigo INT IDENTITY(1,1) NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    autor VARCHAR(30) NOT NULL,
    editorial VARCHAR(20) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_libros_codigo PRIMARY KEY (codigo))
END

ALTER TABLE Laboratorio.dbo.libros
ADD CONSTRAINT DF_libros_autor DEFAULT 'Desconocido' FOR autor

ALTER TABLE Laboratorio.dbo.libros
ADD CONSTRAINT CK_libros_precio CHECK (precio >= 0)

ALTER TABLE Laboratorio.dbo.libros
NOCHECK CONSTRAINT CK_libros_precio

/*
	11) Escribir la sintaxis para eliminar las tablas creadas.

*/

ALTER TABLE Laboratorio.dbo.facturas
DROP CONSTRAINT FK_facturas_articulo_id;

ALTER TABLE Laboratorio.dbo.facturas
DROP CONSTRAINT FK_facturas_cliente_id;

USE laboratorio;
GO

DROP TABLE IF EXISTS dbo.libros
DROP TABLE IF EXISTS dbo.usuarios
DROP TABLE IF EXISTS test.prueba
DROP TABLE IF EXISTS dbo.operador
DROP TABLE IF EXISTS dbo.empleados
DROP TABLE IF EXISTS dbo.facturas
DROP TABLE IF EXISTS dbo.clientes
DROP TABLE IF EXISTS dbo.articulos


/*

	12) Escribir la sintaxis para eliminar la base de datos.

*/

USE Laboratorio
GO

DROP DATABASE IF EXISTS Laboratorio
