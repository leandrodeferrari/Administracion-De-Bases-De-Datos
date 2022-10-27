-- Laboratorio Join

/*

	1) Mostrar los empleados que también son vendedores
	SQL tablas: HumanResources.Employee, Sales.SalesPerson
	MySQL tablas: Employee, SalesPerson
	SQL campos: BusinessEntityID
	MySQL campos: salespersonid , employeeid

*/

USE AdventureWorks2019
GO

SELECT * FROM HumanResources.Employee e INNER JOIN Sales.SalesPerson sp 
	ON (sp.BusinessEntityID = e.BusinessEntityID)

/*

	2) Mostrar los empleados ordenados alfabéticamente por apellido y por nombre
	SQL tablas: HumanResources.Employee, Person.Person
	MySQL tablas: employee, contact
	SQL campos: BusinessEntityID, LastName, FirstName
	MySQL campos: employeeid, contactid

*/

USE AdventureWorks2019
GO

SELECT e.BusinessEntityID, p.LastName, p.FirstName 
FROM HumanResources.Employee e INNER JOIN Person.Person p
	ON (p.BusinessEntityID = e.BusinessEntityID) ORDER BY p.LastName, p.FirstName

/*

	3) Mostrar el código de logueo, número de territorio y sueldo básico de los vendedores
	SQL tablas: HumanResources.Employee, Sales.SalesPerson
	MySQL tablas: Employee, SalesPerson
	campos: e.LoginID, TerritoryID, Bonus, BusinessEntityID

*/

USE AdventureWorks2019
GO

SELECT sp.BusinessEntityID, e.LoginID,  sp.TerritoryID, sp.Bonus 
FROM HumanResources.Employee e INNER JOIN Sales.SalesPerson sp
	ON (sp.BusinessEntityID = e.BusinessEntityID)

/*

	4) Mostrar los productos que sean ruedas
	SQL tablas: Production.Product, Production.ProductSubcategory
	MySQL tablas: Product, ProductSubcategory
	campos: Name, ProductSubcategoryID

*/

USE AdventureWorks2019
GO

SELECT * FROM Production.Product p INNER JOIN Production.ProductSubcategory psc
	ON (psc.ProductSubcategoryID = p.ProductSubcategoryID) WHERE psc.Name LIKE '%wheel%'

/*

	5)Mostrar los nombres de los productos que no son bicicletas
	SQL tablas: Production.Product, Production.ProductSubcategory
	MySQL tablas: Product, ProductSubcategory
	campos: Name, ProductSubcategoryID

*/

USE AdventureWorks2019
GO

SELECT DISTINCT psc.Name FROM Production.Product p INNER JOIN Production.ProductSubcategory psc 
	ON (psc.ProductSubcategoryID = p.ProductSubcategoryID) WHERE psc.Name NOT LIKE '&wheel&'

/*

	6) Mostrar los precios de venta de aquellos productos donde el precio de venta sea
	inferior al precio de lista recomendado para ese producto ordenados por nombre de
	producto.
	SQL tablas: Sales.SalesOrderDetail, Production.Product
	MySQL tablas: SalesOrderDetail, Product
	campos: ProductID, Name, ListPrice, UnitPrice

*/

USE AdventureWorks2019
GO

SELECT DISTINCT p.productID, p.Name, p.ListPrice, sod.UnitPrice 
FROM Production.Product p INNER JOIN Sales.SalesOrderDetail sod
	ON (sod.ProductID = p.ProductID) WHERE sod.UnitPrice < p.ListPrice ORDER BY p.Name

/*

	7) Mostrar el nombre de los productos y de los proveedores cuya subcategoría es 13
	ordenados por nombre de proveedor
	SQL tablas: Production.Product, Purchasing.ProductVendor, Purchasing.Vendor
	MySQL tablas: Product, ProductVendor, Vendor
	campos: Name ,ProductID, BusinessEntityID, ProductSubcategoryID

*/

USE AdventureWorks2019
GO

SELECT p.ProductID, p.Name AS nameProduct, p.ProductSubcategoryID, v.Name AS nameVendor 
FROM Production.Product AS p INNER JOIN Purchasing.ProductVendor AS pv 
	ON (pv.ProductID = p.ProductID) 
    INNER JOIN Purchasing.Vendor AS v 
    ON (v.BusinessEntityID = pv.BusinessEntityID)
WHERE ProductSubcategoryID = 13 ORDER BY v.Name

/*

	8) Mostrar todas las personas (nombre y apellido) y en el caso que sean empleados
	mostrar también el login id, sino mostrar null
	SQL tablas: Person.Person, HumanResources.Employee
	MySQL tablas: contact, Employee
	campos: FirstName, LastName, LoginID, BusinessEntityID

*/

USE AdventureWorks2019
GO

SELECT p.FirstName, p.LastName, e.LoginID 
FROM Person.Person p LEFT JOIN HumanResources.Employee e
ON (e.BusinessEntityID = p.BusinessEntityID)

/*

	9) Una librería almacena la información de sus libros para la venta en dos tablas,
	"libros" y "editoriales".
    
	Creamos las tablas:
    
	create table libros(
	codigo int identity,
	titulo varchar(40),
	autor varchar(30) default 'Desconocido',
	codigoeditorial tinyint not null,
	precio decimal(5,2)
	);
    
	create table editoriales(
	codigo tinyint identity,
	nombre varchar(20),
	primary key (codigo)
	);

	Ingresamos algunos registros en ambas tablas:
    
	insert into editoriales values('Planeta');
	insert into editoriales values('Emece');
	insert into editoriales values('Siglo XXI');
	insert into libros values('El aleph','Borges',2,20);
	insert into libros values('Martin Fierro','Jose Hernandez',1,30);
	insert into libros values('Aprenda PHP','Mario Molina',3,50);
	insert into libros values('Java en 10 minutos',default,3,45);
    
	9.1) Realizar un join para obtener datos de ambas tablas (titulo, autor y nombre de la
	editorial)
	9.2) Mostrar el código del libro, título, autor, nombre de la editorial y el precio
	realizando un join y empleando alias-
	9.3) Realizar la misma consulta anterior pero solamente para obtener los libros de la
	editorial "Siglo XXI"
	9.4) Obtener título, autor y nombre de la editorial, ordenados por título

*/

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'laboratorio_join')
BEGIN
CREATE DATABASE laboratorio_join
END

USE laboratorio_join
GO

IF OBJECT_ID('libros', 'U') IS NULL
BEGIN
CREATE TABLE libros(
	codigo INT IDENTITY(1,1) NOT NULL,
	titulo VARCHAR(40),
	autor VARCHAR(30) DEFAULT 'Desconocido',
	codigoeditorial TINYINT NOT NULL,
	precio DECIMAL(5,2),
    PRIMARY KEY (codigo)
)
END

IF OBJECT_ID('editoriales', 'U') IS NULL
BEGIN
CREATE TABLE editoriales(
	codigo TINYINT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(20),
	PRIMARY KEY (codigo)
)
END

INSERT INTO editoriales (nombre) VALUES ('Planeta')
INSERT INTO editoriales (nombre) VALUES ('Emece')
INSERT INTO editoriales (nombre) VALUES ('Siglo XXI')
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('El aleph','Borges',2,20)
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Martin Fierro','Jose Hernandez',1,30)
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Aprenda PHP','Mario Molina',3,50)
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Java en 10 minutos',default,3,45)

-- 9.1) Realizar un join para obtener datos de ambas tablas (titulo, autor y nombre de la editorial).

SELECT l.titulo, l.autor, e.nombre AS nombre_editorial FROM libros l INNER JOIN editoriales e 
	ON (e.codigo = l.codigoeditorial)

-- 9.2) Mostrar el código del libro, título, autor, nombre de la editorial y el precio realizando un join y empleando alias.

SELECT l.codigo AS cod_libro, l.titulo AS titulo_libro, l.autor AS autor_libro, l.precio AS precio_libro, e.nombre AS nombre_editorial
 FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial)

-- 9.3) Realizar la misma consulta anterior pero solamente para obtener los libros de la editorial "Siglo XXI".

SELECT l.codigo AS cod_libro, l.titulo AS titulo_libro, l.autor AS autor_libro, l.precio AS precio_libro, e.nombre AS nombre_editorial
 FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial) WHERE e.nombre = 'Siglo XXI'

-- 9.4) Obtener título, autor y nombre de la editorial, ordenados por título.

SELECT l.titulo, l.autor, e.nombre AS nombre_editorial FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial) ORDER BY l.titulo ASC

/*

	10) Una librería almacena la información de sus libros para la venta en dos tablas,
	"libros" y "editoriales".
    
    Creamos las tablas:
    
	create table libros(
	codigo int identity,
	titulo varchar(40),
	autor varchar(30),
	codigoeditorial tinyint not null,
	precio decimal(5,2)
	);
    
	create table editoriales(
	codigo tinyint identity,
	nombre varchar(20),
	primary key (codigo)
	);
    
	insert into editoriales values('Planeta');
	insert into editoriales values('Emece');
	insert into editoriales values('Siglo XXI');
	insert into libros values('El aleph','Borges',1,20);
	insert into libros values('Martin Fierro','Jose Hernandez',1,30);
	insert into libros values('Aprenda PHP','Mario Molina',3,50);
	insert into libros values('Uno','Richard Bach',3,15);
	insert into libros values('Java en 10 minutos',default,4,45);
    
    10.1) Contar la cantidad de libros de cada editorial consultando ambas tablas
	10.2) Obtener el libro más costoso de cada editorial

*/

USE laboratorio_join
GO

DROP TABLE IF EXISTS libros
DROP TABLE IF EXISTS editoriales

IF OBJECT_ID('libros', 'U') IS NULL
BEGIN
CREATE TABLE libros(
	codigo INT IDENTITY(1,1) NOT NULL,
	titulo VARCHAR(40),
	autor VARCHAR(30),
	codigoeditorial TINYINT NOT NULL,
	precio DECIMAL(5,2),
    PRIMARY KEY (codigo)
)
END
   
IF OBJECT_ID('editoriales', 'U') IS NULL
BEGIN
CREATE TABLE editoriales(
	codigo TINYINT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(20),
	PRIMARY KEY (codigo)
)
END
   
INSERT INTO editoriales (nombre) VALUES ('Planeta')
INSERT INTO editoriales (nombre) VALUES ('Emece')
INSERT INTO editoriales (nombre) VALUES ('Siglo XXI')
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('El aleph','Borges',1,20)
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Martin Fierro','Jose Hernandez',1,30)
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Aprenda PHP','Mario Molina',3,50)
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Uno','Richard Bach',3,15)
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Java en 10 minutos',DEFAULT,4,45)

-- 10.1) Contar la cantidad de libros de cada editorial consultando ambas tablas.

SELECT e.nombre AS nombre_editorial, COUNT(1) AS cantidad_libros 
FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial) GROUP BY e.nombre

-- 10.2) Obtener el libro más costoso de cada editorial.

SELECT e.nombre AS nombre_editorial, MAX(l.precio) AS libro_mas_caro 
FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial) GROUP BY e.nombre

-- Laboratorio Tablas temporales

/*

	11) Clonar estructura y datos de los campos nombre, color y precio de lista de la
	tabla production.product en una tabla llamada #Productos
	SQL tablas:Production.Product
	MySQL Product
	campos: Name, ListPrice, Color

*/

USE AdventureWorks2019
GO

SELECT Name, ListPrice, Color
INTO #productos
FROM Production.Product

/*

	12) Clonar solo estructura de los campos identificador, nombre y apellido de la tabla
	person.person en una tabla llamada #Personas
	SQL tablas: Person.Person
	MySQL tablas: contact
	campos: BusinessEntityID, FirstName, LastName

*/

USE AdventureWorks2019
GO

SELECT BusinessEntityID, FirstName, LastName
INTO #personas
FROM Person.Person WHERE 1 = 2

/*

	13) Eliminar si existe la tabla #Productos
	tablas: Productos

*/

USE AdventureWorks2019
GO

DROP TABLE IF EXISTS #productos