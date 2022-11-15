-- Laboratorio Subconsultas

/*

	1) Listar todos los productos cuyo precio sea inferior al precio promedio de todos los
	productos
	SQL tabla: Production.Product
    MySQL tabla: Product
	campos: Name, ListPrice

*/

USE adventureworks;

SELECT * FROM Product WHERE ListPrice < (SELECT AVG(ListPrice) FROM Product);

/*

	2) Listar el nombre, precio de lista, precio promedio y diferencia de precios entre cada
	producto y el valor promedio general
	SQL tabla: Production.Product
    MySQL tabla: Product
	campos: Name, ListPrice

*/

USE adventureworks;

SELECT Name, ListPrice, 
	ROUND((SELECT AVG(ListPrice) FROM Product), 2) AS promedio, 
	ROUND((ListPrice - (SELECT AVG(ListPrice) FROM Product)), 2) AS diferencia
FROM product WHERE ListPrice > 0;

    /*

	3) Mostrar el o los códigos del producto mas caro
	SQL tabla: Production.Product
    MySQL tabla: Product
	campos: ProductID,ListPrice

*/

USE adventureworks;

SELECT ProductID, ListPrice, Name FROM Product 
WHERE ListPrice = (SELECT MAX(ListPrice) FROM Product);

/*

	4) Mostrar el producto más barato de cada subcategoría. mostrar subcategoría, código
	de producto y el precio de lista más barato ordenado por subcategoría
	SQL tabla: Production.Product
    MySQL tabla: Product
	campos: ProductSubcategoryID, ProductID, ListPrice

*/

USE adventureworks;

SELECT ProductID, ListPrice, Name, ProductSubcategoryID 
FROM Product p
WHERE ListPrice = (SELECT MIN(ListPrice) 
					FROM Product pd 
					WHERE pd.ProductSubcategoryID = p.ProductSubcategoryID)
ORDER BY p.ProductSubcategoryID;

-- EXISTS Y NOT EXISTS

/*

	5) Mostrar los nombres de todos los productos presentes en la subcategoría de
	ruedas
	SQL tablas:Production.Product, Production.ProductSubcategory
	MySQL tablas: Product, ProductSubcategory
	campos: ProductSubcategoryID, Name

*/

USE adventureworks;

SELECT * FROM Product p WHERE EXISTS (SELECT * FROM ProductSubcategory psc
	WHERE psc.ProductSubcategoryID = p.ProductSubcategoryID AND psc.Name like '%Wheels%');

/*

	6) Mostrar todos los productos que no fueron vendidos
	SQL tablas:Production.Product, Sales.SalesOrderDetail
	MySQL tablas: Product, SalesOrderDetail
	campos: Name, ProductID

*/

USE adventureworks;

SELECT * FROM Product p WHERE NOT EXISTS (SELECT 1 FROM SalesOrderDetail sod
	WHERE sod.ProductID = p.ProductID);
    
/*

	7) Mostrar la cantidad de personas que no son vendedores
	SQL tablas: Person.Person, Sales.SalesPerson
	MySQL tablas: contact, SalesPerson
	campos: BusinessEntityID

*/

USE adventureworks;

SELECT * FROM Contact c WHERE NOT EXISTS (SELECT 1 FROM SalesPerson sp
	WHERE sp.SalesPersonID = c.ContactID);
    
/*
    
    8) Mostrar todos los vendedores (nombre y apellido) que no tengan asignado un
	territorio de ventas
	SQL tablas: Person.Person, Sales.SalesPerson
	MySQL tablas: contact, SalesPerson
	campos: BusinessEntityID, TerritoryID, LastName, FirstName
    
*/

USE adventureworks;

SELECT * FROM Contact c WHERE EXISTS (SELECT 1 FROM SalesPerson sp
	WHERE sp.SalesPersonID = c.ContactID AND TerritoryID IS NULL);

-- IN Y NOT IN

/*
    
	9) Mostrar las órdenes de venta que se hayan facturado en territorio de estado
	unidos únicamente 'us'
	SQL tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
    MySQL tablas: SalesOrderHeader, SalesTerritory
	campos: CountryRegionCode, TerritoryID
    
*/

USE adventureworks;

SELECT * FROM SalesOrderHeader WHERE TerritoryID 
	IN (SELECT TerritoryID FROM SalesTerritory WHERE CountryRegionCode = 'US');

/*
    
	10) Al ejercicio anterior agregar ordenes de Francia e Inglaterra
	SQL tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
	MySQL tablas: SalesOrderHeader, SalesTerritory
	campos: CountryRegionCode, TerritoryID
    
*/

USE adventureworks;

SELECT * FROM SalesOrderHeader WHERE TerritoryID 
	IN (SELECT TerritoryID FROM SalesTerritory 
		WHERE CountryRegionCode IN ('US', 'FR', 'GB'));

/*
    
	11) Mostrar los nombres de los diez productos más caros
	SQL tablas:Production.Product
    MySQL tablas: Product
	campos: ListPrice
    
*/

-- Tengo que usar una tabla temporal, debido a la versión de MySQL, que no soporta LIMIT en la subconsulta.

USE adventureworks;

CREATE TEMPORARY TABLE precios_maximos 
	SELECT DISTINCT ListPrice FROM Product ORDER BY ListPrice DESC LIMIT 10;

SELECT * FROM Product WHERE ListPrice IN 
	(SELECT ListPrice FROM precios_maximos);
    
DROP TABLE IF EXISTS precios_maximos;

/*
    
	12) Mostrar aquellos productos cuya cantidad de pedidos de venta sea igual o
	superior a 20
	SQL tablas: Production.Product, Sales.SalesOrderDetail
	MySQL tablas: Product, SalesOrderDetail
	campos: Name, ProductID , OrderQty
    
*/

USE adventureworks;

SELECT * FROM Product WHERE ProductID IN 
	(SELECT ProductID FROM SalesOrderDetail WHERE OrderQty >= 20);

-- INSERT, UPDATE Y DELETE

/*

	13) Clonar estructura y datos de los campos id, nombre, color y precio de lista de la tabla
	production.product en una tabla llamada Productos
	SQL tablas: Production.Product
    MySQL tablas: Product
	campos: Name, Color, ListPrice

*/

CREATE TABLE IF NOT EXISTS productos SELECT ProductID, Name, Color, ListPrice FROM product;

-- En MySQL me clona la tabla, pero no las restricciones que tiene la original.

/*

	14) Aumentar un 20% el precio de lista de todos los productos
	tablas: Produccion
	campos: ListPrice

*/

-- Debo cambiar la configuración, con la instrucción de abajo, 
-- debido a que MySQL no permite (por defecto) hacer el update de toda la columna.

SET SQL_SAFE_UPDATES = 0;

UPDATE productos
SET ListPrice = ROUND((ListPrice * 1.20), 2);

/*

	15) Aumentar un 20% el precio de lista de los productos del proveedor 1594 (53 en MySQL)
	SQL tablas: Productos, Purchasing.ProductVendor
	MySQL tablas: Productos, ProductVendor
	campos: ProductID, ListPrice, BusinessEntityID

*/

USE adventureworks;

UPDATE productos
INNER JOIN ProductVendor
ON (productvendor.ProductID = productos.ProductID)
SET productos.ListPrice = ROUND((productos.ListPrice * 1.20),2) WHERE productvendor.VendorID = 53;

/*

	16) Eliminar los productos cuyo precio es igual a cero
	tablas: Productos
	campos: ListPrice

*/

USE adventureworks;

DELETE FROM productos WHERE ListPrice = 0;

/*

	Nota: Una manera de borrar registros, con JOIN

	DELETE p
	FROM productos p INNER JOIN ProductVendor pv
		ON (pv.ProductID = p.ProductID) WHERE pv.VendorID = 53;
    
*/

/*

	17) Insertar un producto dentro de la tabla productos.
	tener en cuenta los siguientes datos.
	el color de producto debe ser rojo, el nombre debe ser "bicicleta mountain bike"
	y el precio de lista debe ser de 4000 pesos.
	tablas:productos
	campos: Color,Name, ListPrice

*/

USE adventureworks;

INSERT INTO productos (Color, Name, ListPrice) VALUES ('Rojo', 'bicicleta mountain bike', 4000);

/*

	18) Aumentar en un 15% el precio de los pedales de bicicleta
	tablas: productos
	campos: Name, ListPrice

*/

UPDATE productos
SET ListPrice = ROUND((ListPrice * 1.15),2) WHERE Name LIKE '%pedal%';

/*

	19) Eliminar de las productos cuyo nombre empiece con la letra m
	tablas: productos
	campos: Name

*/

USE adventureworks;

DELETE FROM Productos WHERE Name LIKE 'm%';

/*

	20) Borrar todo el contenido de la tabla productos sin utilizar la instrucción delete.
	tablas: productos

*/

USE adventureworks;

TRUNCATE productos;

/*

	21) Eliminar tabla productos
	tablas: productos

*/

USE adventureworks;

DROP TABLE productos;

/*

	22) Trabajamos con la tabla "libros" de una librería
    
	Eliminamos la tabla, si existe y la creamos:
    
	create table libros(
	codigo int identity,
	titulo varchar(40),
	autor varchar(30),
	editorial varchar(20),
	precio decimal(5,2)
	);
    
	Ingresamos los siguientes registros:
    
	insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
	insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
	insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI',40.00);
	insert into libros values('El aleph','Borges','Emece',10.00);
	insert into libros values('Ilusiones','Richard Bach','Planeta',15.00);
	insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
	insert into libros values('Martin Fierro','Jose Hernandez','Planeta',20.00);
	insert into libros values('Martin Fierro','Jose Hernandez','Emece',30.00);
	insert into libros values('Uno','Richard Bach','Planeta',10.00);
    
	22.1) Obtener el título, precio de un libro específico y la diferencia entre su precio y el
	máximo valor
	22.2) Mostrar el título y precio del libro más costoso
	22.3) Actualizar un 20% el precio del libro con máximo valor
	22.4) Eliminamos los libros con precio menor

*/

CREATE SCHEMA IF NOT EXISTS laboratorio_subconsulta;

USE laboratorio_subconsulta;

CREATE TABLE IF NOT EXISTS libros(
	codigo INT AUTO_INCREMENT NOT NULL,
	titulo VARCHAR(40),
	autor VARCHAR(30),
	editorial VARCHAR(20),
	precio DECIMAL(5,2),
    PRIMARY KEY (codigo)
);

INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Aprenda PHP','Mario Molina','Siglo XXI',40.00);
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('El aleph','Borges','Emece',10.00);
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Ilusiones','Richard Bach','Planeta',15.00);
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Martin Fierro','Jose Hernandez','Planeta',20.00);
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Martin Fierro','Jose Hernandez','Emece',30.00);
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Uno','Richard Bach','Planeta',10.00);
    
-- 22.1) Obtener el título, precio de un libro específico y la diferencia entre su precio y el máximo valor

SELECT titulo, precio, (SELECT (precio - (SELECT MAX(precio) FROM libros))) AS diferencia_con_max_precio FROM libros;

-- 22.2) Mostrar el título y precio del libro más costoso

SELECT titulo, precio FROM libros WHERE precio = (SELECT MAX(precio) FROM libros);

-- 22.3) Actualizar un 20% el precio del libro con máximo valor

USE laboratorio_subconsulta;

CREATE TEMPORARY TABLE IF NOT EXISTS maximo SELECT MAX(precio) AS precio FROM libros;

UPDATE libros
SET precio = precio * 1.20 WHERE precio = (SELECT precio FROM maximo);

DROP TABLE IF EXISTS maximo;

/*

	UPDATE libros
	SET precio = precio * 1.20 WHERE precio = (SELECT MAX(precio) FROM libros);
    
	Da error, al hacerlo con la instrucción de arriba: Error Code: 1093. You can't specify
    target table 'libros' for update in FROM clause

*/

-- 22.4) Eliminamos los libros con precio menor

USE laboratorio_subconsulta;

CREATE TEMPORARY TABLE IF NOT EXISTS maximo SELECT MAX(precio) AS precio FROM libros;

DELETE FROM libros WHERE precio < (SELECT precio FROM maximo);

DROP TABLE IF EXISTS maximo;

/*

	DELETE FROM libros WHERE precio < (SELECT MAX(precio) FROM libros);
    
	Da error, al hacerlo con la instrucción de arriba: Error Code: 1093. You can't specify 
    target table 'libros' for update in FROM clause

*/