# Para todos los ejercicios se debe preguntar si existen los objetos.
# Crear una base de datos llamada Laboratorio.

/*

	1) Crear la tabla llamada prueba, dentro de la Base de datos Laborario
	Campos:
	idCodido alfanumerico de longitud fija de 4 caracteres que no admite nulos
	nombre alfanumerico de longitud variable de 30 caracteres que no admite nulos
	precio decimal con dos decimales que no admite nulos
	edad numero que no adminte nulos

*/

CREATE DATABASE IF NOT EXISTS laboratorio;

USE laboratorio;

CREATE TABLE IF NOT EXISTS prueba(
	idCodigo CHAR(4) NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    edad TINYINT UNSIGNED NOT NULL
);

/*

	2) Crear una tabla llamado operador que contenga los siguientes campos:
	codigo_operador alfanumerico de longitud fija de 10 caracteres no admite nulos
	nombre alfanumerico de longitud variable de 40 caracteres no admite nulos
	fecha_ingreso de tipo fecha no admite nulos
	edad numero no admite nulos
	Luego de creada, añadir una columna llamada telefono alfanumerico de longitud
	variable de 20 caracteres.

*/

USE laboratorio;

CREATE TABLE IF NOT EXISTS operador(
	codigo_operador CHAR(10) NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    edad TINYINT UNSIGNED NOT NULL
);

ALTER TABLE laboratorio.operador
ADD COLUMN telefono VARCHAR(20);

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

USE laboratorio;

CREATE TABLE IF NOT EXISTS facturas(
	letra CHAR(1),
    numero INT,
    cliente_id INT NOT NULL,
    articulo_id INT NOT NULL,
    fecha_factura DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_facturas_letra_numero PRIMARY KEY (letra,numero)
);

/*

	4) Crear la tabla articulos dentro de la base de datos con el siguiente detalle:
	articulo_id numérico entero y PK auto incrementeal que comience en 1
	nombre alfanumerico de longitud variable de 50 caracteres que no admite nulos
	precio decimal no admite nulos
	stock numérico entero que no admite nulos.
    
*/

USE laboratorio;

CREATE TABLE IF NOT EXISTS articulos(
	articulo_id INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    CONSTRAINT PK_articulos_articulo_id PRIMARY KEY (articulo_id)
);

/*

	5) Crear la tabla clientes dentro de la base de datos con el siguiente detalle
	cliente_id tipo de dato entero y PK auto incrementeal que comience en 1
	nombre alfanumerico de longitud variable de 25 caracteres no admite nulos
	apellido alfanumerico de longitud variable de 25 caracteres no admite nulos
	cuit alfanumerico de longitud fija de 16 caracteres no adminte nulos
	direccion alfanumerico de longitud variable de 50 caracteres admite nulos
	comentarios alfanumerico de longitud variable de 50 caracteres admite nulos
    
*/

USE laboratorio;

CREATE TABLE IF NOT EXISTS clientes(
	cliente_id INT AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    cuit CHAR(16) NOT NULL,
    direccion VARCHAR(50),
    comentarios VARCHAR(50),
    CONSTRAINT PK_clientes_cliente_id PRIMARY KEY (cliente_id)
);

/*

	6) A la tabla facturas:
	6.1) Agregar un campo observacion alfanumerico de longitud variable de 100 caracteres
	que admite nulos.
	6.2) Modificar el tipo de dato a alfanumerico de longitud variable de 200 caracteres que
	no admite nulos.
	6.3) Eliminar el campo observacion.
    
*/

ALTER TABLE laboratorio.facturas
ADD COLUMN observacion VARCHAR(100);

ALTER TABLE laboratorio.facturas
MODIFY COLUMN observacion VARCHAR(200) NOT NULL;

ALTER TABLE laboratorio.facturas
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

USE laboratorio;

CREATE TABLE IF NOT EXISTS empleados(
	idempleado INT NOT NULL,
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
	nroDocumento VARCHAR(11) NOT NULL,
	fechaCreacion DATETIME NOT NULL,
	edad TINYINT NOT NULL
);

ALTER TABLE laboratorio.empleados
ADD CONSTRAINT PK_empleados_idempleado PRIMARY KEY (idempleado);

ALTER TABLE laboratorio.empleados
ADD CONSTRAINT UQ_empleados_nroDocumento UNIQUE (nroDocumento);

ALTER TABLE laboratorio.empleados
ADD CONSTRAINT CK_empleados_edad CHECK (edad >= 0);

ALTER TABLE laboratorio.empleados
ALTER fechaCreacion SET DEFAULT (CURRENT_TIMESTAMP());

ALTER TABLE laboratorio.empleados
DROP CONSTRAINT CK_empleados_edad;

/*

	8) A la tabla de facturas crear las restriccion FK para los campos cliente_id y articulo_id.
    
*/

USE laboratorio;

ALTER TABLE facturas
ADD CONSTRAINT FK_facturas_cliente_id FOREIGN KEY (cliente_id) REFERENCES laboratorio.clientes(cliente_id);

ALTER TABLE facturas
ADD CONSTRAINT FK_facturas_articulo_id FOREIGN KEY (articulo_id) REFERENCES laboratorio.articulos(articulo_id);

/*

	9) Crear la tabla usuarios que contengá los siguientes campos:
	- clave: alfanumerico de 10 caracteres de longitud variable.
	- nombre: alfanumerico de 30 caracteres de longitud variable,
	Definir el campo "nombre" como clave primaria.
    
*/

USE laboratorio;

CREATE TABLE IF NOT EXISTS usuarios(
	clave VARCHAR(10),
    nombre VARCHAR(30),
    CONSTRAINT PK_usuarios_nombre PRIMARY KEY (nombre)
);

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

USE laboratorio;

CREATE TABLE IF NOT EXISTS libros(
	codigo INT UNSIGNED AUTO_INCREMENT NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    autor VARCHAR(30) NOT NULL,
    editorial VARCHAR(20) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_libros_codigo PRIMARY KEY (codigo)
);

ALTER TABLE laboratorio.libros
ALTER autor SET DEFAULT 'Desconocido';

ALTER TABLE laboratorio.libros
ADD CONSTRAINT CK_libros_precio CHECK (precio >= 0);

ALTER TABLE laboratorio.libros
DROP CONSTRAINT CK_libros_precio;

/*

	11) Escribir la sintaxis para eliminar las tablas creadas.

*/

ALTER TABLE laboratorio.facturas
DROP CONSTRAINT FK_facturas_articulo_id;

ALTER TABLE laboratorio.facturas
DROP CONSTRAINT FK_facturas_cliente_id;

USE laboratorio;

DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS prueba;
DROP TABLE IF EXISTS operador;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS facturas;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS articulos;

/*

	12) Escribir la sintaxis para eliminar la base de dato.

*/

USE laboratorio;

DROP DATABASE laboratorio;
