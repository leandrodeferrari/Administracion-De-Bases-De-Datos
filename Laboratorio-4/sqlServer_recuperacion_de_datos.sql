-- Laboratorio Recuperacion de datos

-- Distinct

/*

	1) Mostrar los diferentes productos vendidos
	SQL Tabla: Sales.SalesOrderDetail
	MySQL Tabla: SalesOrderDetail
	Campos: ProductID

*/

USE AdventureWorks2019
GO

SELECT DISTINCT ProductID FROM Sales.SalesOrderDetail

-- Union

/*

	2) Mostrar todos los productos vendidos y ordenados
	SQL Tablas: Sales.SalesOrderDetail, Production.WorkOrder
	MySQL Tablas: SalesOrderDetail, WorkOrder
	Campos: ProductID

*/

USE AdventureWorks2019
GO

SELECT ProductID FROM Sales.SalesOrderDetail
UNION ALL
SELECT ProductID FROM  Production.WorkOrder ORDER BY ProductID

/*

	3) Mostrar los diferentes productos vendidos y ordenados
	SQL Tablas: Sales.SalesOrderDetail, Production.WorkOrder
	MySQL Tablas: SalesOrderDetail, WorkOrder
	Campos: ProductID

*/

USE AdventureWorks2019
GO

SELECT ProductID FROM Sales.SalesOrderDetail
UNION
SELECT ProductID FROM  Production.WorkOrder ORDER BY ProductID

-- Case

/*

	4) Obtener el id y una columna denominada sexo cuyo valores disponibles sean
	�Masculino� y �Femenino�
	SQL Tabla: HumanResources.Employee
	MySQL Tabla: Employee
	Campos: BusinessEntityID, Gender

*/

USE AdventureWorks2019
GO

SELECT BusinessEntityID, 
CASE Gender 
	WHEN 'F' THEN 'Femenino' 
	WHEN 'M' THEN 'Masculino' 
	END AS sexo 
FROM HumanResources.Employee

/*

	5) Mostrar el id de los empleados si tiene salario deber� mostrarse descendente de
	lo contrario ascendente
	SQL Tabla: HumanResources.Employee
	MySQL Tabla: Employee
	Campos: BusinessEntityID, SalariedFlag

*/

USE AdventureWorks2019
GO

SELECT BusinessEntityID, SalariedFlag FROM HumanResources.Employee 
ORDER BY 
CASE WHEN SalariedFlag = 1 THEN BusinessEntityID END DESC,
CASE WHEN SalariedFlag = 0 THEN BusinessEntityID END ASC

/*

	6) Trabajamos con la tabla "libros" de una librer�a.
	Eliminamos la tabla si existe
	Creamos la tabla:
    
    create table libros(
	codigo int identity,
	titulo varchar(40),
	autor varchar(30),
	editorial varchar(15),
	primary key(codigo)
	);
    
    Ingresamos alguos registros:
    
    insert into libros values ('El aleph','Borges','Planeta');
	insert into libros values ('Martin Fierro','Jose Hernandez','Emece');
	insert into libros values ('Martin Fierro','Jose Hernandez','Planeta');
	insert into libros values('Antologia poetica','Borges','Planeta');
	insert into libros values('Aprenda PHP','Mario Molina','Emece');
	insert into libros values('Aprenda PHP','Lopez','Emece');
	insert into libros values('Manual de PHP', 'J. Paez', null);
	insert into libros values('Cervantes y el quijote',null,'Paidos');
	insert into libros values('Harry Potter y la piedra filosofal','J.K. Rowling','Emece');
	insert into libros values('Harry Potter y la camara secreta','J.K. Rowling','Emece');
	insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos');
	insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');
	insert into libros values('PHP de la A a la Z',null,null);
	insert into libros values('Uno','Richard Bach','Planeta');
    
    6.1) obtener la lista de autores sin repetici�n
	6.2) obtener los nombres de las editoriales sin repetir
	6.3) obtener los distintos autores de la editorial "Planeta"
	6.4) Mostrar los t�tulos y editoriales de los libros sin repetir t�tulos ni editoriales,
	ordenados por titulos.

*/

USE AdventureWorks2019
GO

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'laboratorio_recuperacion_de_datos')
	BEGIN
    CREATE DATABASE laboratorio_recuperacion_de_datos
	END

USE laboratorio_recuperacion_de_datos
GO

IF OBJECT_ID('libros', 'U') IS NULL
BEGIN
CREATE TABLE libros(
	codigo INT IDENTITY,
	titulo VARCHAR(40),
	autor VARCHAR(30),
	editorial VARCHAR(15),
	PRIMARY KEY(codigo)
)
END

INSERT INTO libros (titulo, autor, editorial) VALUES ('El aleph', 'Borges', 'Planeta')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Martin Fierro', 'Jose Hernandez', 'Emece')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Martin Fierro', 'Jose Hernandez', 'Planeta')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Antologia poetica', 'Borges', 'Planeta')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Aprenda PHP', 'Mario Molina', 'Emece')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Aprenda PHP', 'Lopez', 'Emece')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Manual de PHP', 'J. Paez', NULL)
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Cervantes y el quijote', NULL, 'Paidos')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Harry Potter y la piedra filosofal', 'J.K. Rowling', 'Emece')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Harry Potter y la camara secreta', 'J.K. Rowling', 'Emece')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Alicia en el pais de las maravillas', 'Lewis Carroll', 'Paidos')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Alicia en el pais de las maravillas', 'Lewis Carroll', 'Planeta')
INSERT INTO  libros (titulo, autor, editorial) VALUES ('PHP de la A a la Z', NULL, NULL)
INSERT INTO  libros (titulo, autor, editorial) VALUES ('Uno', 'Richard Bach', 'Planeta')

-- 6.1) obtener la lista de autores sin repetici�n

SELECT DISTINCT autor FROM libros WHERE autor IS NOT NULL

-- 6.2) obtener los nombres de las editoriales sin repetir

SELECT DISTINCT editorial FROM libros WHERE editorial IS NOT NULL

-- 6.3) obtener los distintos autores de la editorial "Planeta"

SELECT DISTINCT autor FROM libros WHERE editorial = 'Planeta'

-- 6.4) Mostrar los t�tulos y editoriales de los libros sin repetir t�tulos ni editoriales, ordenados por titulos.

SELECT DISTINCT titulo, editorial FROM libros ORDER BY titulo
