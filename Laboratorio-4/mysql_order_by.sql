-- Laboratorio Order by

/*

	1) Mostrar las personas ordenadas primero por su apellido y luego por su nombre
	SQL Tabla: Person.Person
	MySQL Tabla: contact
	Campos: Firstname, Lastname

*/

USE adventureworks;

SELECT * FROM contact ORDER BY Lastname, Firstname;

/*

	2) Mostrar cinco productos más caros y su nombre ordenado en forma alfabética
	SQL Tabla: Production.Product
	MySQL Tabla: Product
	Campos: Name, ListPrice

*/

USE adventureworks;

SELECT Name, ListPrice FROM Product ORDER BY ListPrice DESC, Name ASC LIMIT 5;

/*

	3) Trabajamos con la tabla "libros" de una librería.
	Eliminamos la tabla si existe
	Creamos la tabla:
	create table libros(
	codigo int identity,
	titulo varchar(40) not null,
	autor varchar(20) default 'Desconocido',
	editorial varchar(20),
	precio decimal(6,2),
	primary key (codigo)
	);
	Ingresamos algunos registros:
	insert into libros (titulo,autor,editorial,precio) values('El aleph','Borges','Emece',25.33);
	insert into libros (titulo,autor,editorial,precio) values('Java en 10 minutos','Mario Molina','Siglo XXI',50.65);
	insert into libros (titulo,autor,editorial,precio) values('Alicia en el pais de las
	maravillas','Lewis Carroll','Emece',19.95);
	insert into libros (titulo,autor,editorial,precio) values('Alicia en el pais de las
	maravillas','Lewis Carroll','Planeta',15)
    
    3.1) Recuperamos los registros ordenados por el título.
    3.2) Ordenamos los registros por el campo precio.
	3.3) Los ordenamos por "editorial", de mayor a menor empleando.
	3.4) Ordenamos por dos campos, titulo en forma alfabetica y editorial en forma descendente.

*/

CREATE SCHEMA IF NOT EXISTS laboratorio_order_by;

USE laboratorio_order_by;

DROP TABLE IF EXISTS libros;

CREATE TABLE IF NOT EXISTS libros(
	codigo INT AUTO_INCREMENT,
	titulo VARCHAR(40) NOT NULL,
	autor VARCHAR(20) DEFAULT 'Desconocido',
	editorial VARCHAR(20),
	precio DECIMAL(6,2),
	PRIMARY KEY (codigo)
    );
    
    INSERT INTO libros (titulo,autor,editorial,precio) VALUES ('El aleph','Borges','Emece',25.33);
	INSERT INTO libros (titulo,autor,editorial,precio) values('Java en 10 minutos','Mario Molina','Siglo XXI',50.65);
	INSERT INTO libros (titulo,autor,editorial,precio) VALUES ('Alicia en el pais de las
	maravillas','Lewis Carroll','Emece',19.95);
	INSERT INTO libros (titulo,autor,editorial,precio) VALUES ('Alicia en el pais de las
	maravillas','Lewis Carroll','Planeta',15);

-- 3.1) Recuperamos los registros ordenados por el título.

SELECT * FROM libros ORDER BY titulo;

-- 3.2) Ordenamos los registros por el campo precio.

SELECT * FROM libros ORDER BY precio;

-- 3.3) Los ordenamos por "editorial", de mayor a menor empleando.

SELECT * FROM libros ORDER BY editorial DESC;

-- 3.4) Ordenamos por dos campos, titulo en forma alfabetica y editorial en forma descendente.

SELECT * FROM libros ORDER BY titulo ASC, editorial DESC;
