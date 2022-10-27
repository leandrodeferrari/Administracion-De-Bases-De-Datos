-- Laboratorio Join

/*

	1) Mostrar los empleados que también son vendedores
	SQL tablas: HumanResources.Employee, Sales.SalesPerson
	MySQL tablas: Employee, SalesPerson
	SQL campos: BusinessEntityID
	MySQL campos: salespersonid , employeeid

*/

USE adventureworks;

SELECT * FROM employee e INNER JOIN salesperson sp 
	ON (sp.SalesPersonID = e.EmployeeID);

/*

	2) Mostrar los empleados ordenados alfabéticamente por apellido y por nombre
	SQL tablas: HumanResources.Employee, Person.Person
	MySQL tablas: employee, contact
	SQL campos: BusinessEntityID, LastName, FirstName
	MySQL campos: employeeid, contactid

*/

USE adventureworks;

SELECT e.EmployeeID, c.LastName, c.FirstName 
FROM employee e INNER JOIN contact c 
	ON (c.ContactID = e.EmployeeID) ORDER BY c.LastName, c.FirstName;

/*

	3) Mostrar el código de logueo, número de territorio y sueldo básico de los vendedores
	SQL tablas: HumanResources.Employee, Sales.SalesPerson
	MySQL tablas: Employee, SalesPerson
	campos: e.LoginID, TerritoryID, Bonus, BusinessEntityID

*/

USE adventureworks;

SELECT sp.SalesPersonID, e.LoginID,  sp.TerritoryID, sp.Bonus 
FROM employee e INNER JOIN salesperson sp
	ON (sp.SalesPersonID = e.EmployeeID);

/*

	4) Mostrar los productos que sean ruedas
	SQL tablas: Production.Product, Production.ProductSubcategory
	MySQL tablas: Product, ProductSubcategory
	campos: Name, ProductSubcategoryID

*/

USE adventureworks;

SELECT * FROM product p INNER JOIN productsubcategory psc
	ON (psc.ProductSubcategoryID = p.ProductSubcategoryID) WHERE psc.Name LIKE '%wheel%';

/*

	5)Mostrar los nombres de los productos que no son bicicletas
	SQL tablas: Production.Product, Production.ProductSubcategory
	MySQL tablas: Product, ProductSubcategory
	campos: Name, ProductSubcategoryID

*/

USE adventureworks;

SELECT DISTINCT psc.Name FROM product p INNER JOIN productsubcategory psc 
	ON (psc.ProductSubcategoryID = p.ProductSubcategoryID) WHERE psc.Name NOT LIKE '&wheel&';

/*

	6) Mostrar los precios de venta de aquellos productos donde el precio de venta sea
	inferior al precio de lista recomendado para ese producto ordenados por nombre de
	producto.
	SQL tablas: Sales.SalesOrderDetail, Production.Product
	MySQL tablas: SalesOrderDetail, Product
	campos: ProductID, Name, ListPrice, UnitPrice

*/

USE adventureworks;

SELECT DISTINCT p.productID, p.Name, p.ListPrice, sod.UnitPrice 
FROM Product p INNER JOIN salesorderdetail sod
	ON (sod.ProductID = p.ProductID) WHERE sod.UnitPrice < p.ListPrice ORDER BY p.Name;

/*

	7) Mostrar el nombre de los productos y de los proveedores cuya subcategoría es 13
	ordenados por nombre de proveedor
	SQL tablas: Production.Product, Purchasing.ProductVendor, Purchasing.Vendor
	MySQL tablas: Product, ProductVendor, Vendor
	campos: Name ,ProductID, BusinessEntityID, ProductSubcategoryID

*/

USE adventureworks;

SELECT p.ProductID, p.Name AS nameProduct, p.ProductSubcategoryID, v.Name AS nameVendor 
FROM product AS p INNER JOIN ProductVendor AS pv 
	ON (pv.ProductID = p.ProductID) 
    INNER JOIN Vendor AS v 
    ON (v.VendorID = pv.VendorID)
WHERE ProductSubcategoryID = 13 ORDER BY v.Name;

/*

	8) Mostrar todas las personas (nombre y apellido) y en el caso que sean empleados
	mostrar también el login id, sino mostrar null
	SQL tablas: Person.Person, HumanResources.Employee
	MySQL tablas: contact, Employee
	campos: FirstName, LastName, LoginID, BusinessEntityID

*/

USE adventureworks;

SELECT c.FirstName, c.LastName, e.LoginID 
FROM contact c LEFT JOIN Employee e
ON (e.ContactID = c.ContactID);

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

CREATE SCHEMA IF NOT EXISTS laboratorio_join;

USE laboratorio_join;

CREATE TABLE libros(
	codigo INT AUTO_INCREMENT NOT NULL,
	titulo VARCHAR(40),
	autor VARCHAR(30) DEFAULT 'Desconocido',
	codigoeditorial TINYINT UNSIGNED NOT NULL,
	precio DECIMAL(5,2),
    PRIMARY KEY (codigo)
);
    
CREATE TABLE editoriales(
	codigo TINYINT UNSIGNED AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(20),
	PRIMARY KEY (codigo)
);

INSERT INTO editoriales (nombre) VALUES ('Planeta');
INSERT INTO editoriales (nombre) VALUES ('Emece');
INSERT INTO editoriales (nombre) VALUES ('Siglo XXI');
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('El aleph','Borges',2,20);
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Martin Fierro','Jose Hernandez',1,30);
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Aprenda PHP','Mario Molina',3,50);
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Java en 10 minutos',default,3,45);

-- 9.1) Realizar un join para obtener datos de ambas tablas (titulo, autor y nombre de la editorial).

SELECT l.titulo, l.autor, e.nombre AS nombre_editorial FROM libros l INNER JOIN editoriales e 
	ON (e.codigo = l.codigoeditorial);

-- 9.2) Mostrar el código del libro, título, autor, nombre de la editorial y el precio realizando un join y empleando alias.

SELECT l.codigo AS cod_libro, l.titulo AS titulo_libro, l.autor AS autor_libro, l.precio AS precio_libro, e.nombre AS nombre_editorial
 FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial);

-- 9.3) Realizar la misma consulta anterior pero solamente para obtener los libros de la editorial "Siglo XXI".

SELECT l.codigo AS cod_libro, l.titulo AS titulo_libro, l.autor AS autor_libro, l.precio AS precio_libro, e.nombre AS nombre_editorial
 FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial) WHERE e.nombre = 'Siglo XXI';

-- 9.4) Obtener título, autor y nombre de la editorial, ordenados por título.

SELECT l.titulo, l.autor, e.nombre AS nombre_editorial FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial) ORDER BY l.titulo ASC;

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

USE adventureworks;

DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS editoriales;

CREATE TABLE libros(
	codigo INT AUTO_INCREMENT NOT NULL,
	titulo VARCHAR(40),
	autor VARCHAR(30),
	codigoeditorial TINYINT UNSIGNED NOT NULL,
	precio DECIMAL(5,2),
    PRIMARY KEY (codigo)
);
    
CREATE TABLE editoriales(
	codigo TINYINT AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(20),
	PRIMARY KEY (codigo)
);

INSERT INTO editoriales (nombre) VALUES ('Planeta');
INSERT INTO editoriales (nombre) VALUES ('Emece');
INSERT INTO editoriales (nombre) VALUES ('Siglo XXI');
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('El aleph','Borges',1,20);
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Martin Fierro','Jose Hernandez',1,30);
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Aprenda PHP','Mario Molina',3,50);
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Uno','Richard Bach',3,15);
INSERT INTO libros (titulo, autor, codigoeditorial, precio) VALUES ('Java en 10 minutos',DEFAULT,4,45);

-- 10.1) Contar la cantidad de libros de cada editorial consultando ambas tablas.

SELECT e.nombre AS nombre_editorial, COUNT(1) AS cantidad_libros 
FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial) GROUP BY e.nombre;

-- 10.2) Obtener el libro más costoso de cada editorial.

SELECT e.nombre AS nombre_editorial, MAX(l.precio) AS libro_mas_caro FROM libros l INNER JOIN editoriales e
	ON (e.codigo = l.codigoeditorial) GROUP BY e.nombre;

-- Laboratorio Tablas temporales

/*

	11) Clonar estructura y datos de los campos nombre, color y precio de lista de la
	tabla production.product en una tabla llamada #Productos
	SQL tablas:Production.Product
	MySQL Product
	campos: Name, ListPrice, Color

*/

USE adventureworks;

CREATE TEMPORARY TABLE IF NOT EXISTS productos SELECT Name, ListPrice, Color FROM Product;

/*

	12) Clonar solo estructura de los campos identificador, nombre y apellido de la tabla
	person.person en una tabla llamada #Personas
	SQL tablas: Person.Person
	MySQL tablas: contact
	campos: BusinessEntityID, FirstName, LastName

*/

USE adventureworks;

CREATE TEMPORARY TABLE IF NOT EXISTS personas SELECT ContactID, FirstName, LastName FROM contact WHERE 1 = 2;

/*

	13) Eliminar si existe la tabla #Productos
	tablas: Productos

*/

USE adventureworks;

DROP TABLE IF EXISTS productos;
