-- Laboratorio Subconsultas

/*

	1) Listar todos los productos cuyo precio sea inferior al precio promedio de todos los
	productos
	SQL tabla: Production.Product
    MySQL tabla: Product
	campos: Name, ListPrice

*/

USE AdventureWorks2019
GO

SELECT * FROM Production.Product 
WHERE ListPrice < (SELECT AVG(ListPrice) FROM Production.Product)

/*

	2) Listar el nombre, precio de lista, precio promedio y diferencia de precios entre cada
	producto y el valor promedio general
	SQL tabla: Production.Product
    MySQL tabla: Product
	campos: Name, ListPrice

*/

USE AdventureWorks2019
GO

SELECT Name, ListPrice, 
	ROUND((SELECT AVG(ListPrice) FROM Production.Product), 2) AS promedio, 
	ROUND((ListPrice - (SELECT AVG(ListPrice) FROM Production.Product)), 2) AS diferencia
FROM Production.Product WHERE ListPrice > 0
    
/*

	3) Mostrar el o los códigos del producto mas caro
	SQL tabla: Production.Product
    MySQL tabla: Product
	campos: ProductID,ListPrice

*/

USE AdventureWorks2019
GO

SELECT ProductID, ListPrice, Name FROM Production.Product 
WHERE ListPrice = (SELECT MAX(ListPrice) FROM Production.Product)

/*

	4) Mostrar el producto más barato de cada subcategoría. mostrar subcategoría, código
	de producto y el precio de lista más barato ordenado por subcategoría
	SQL tabla: Production.Product
    MySQL tabla: Product
	campos: ProductSubcategoryID, ProductID, ListPrice

*/

USE AdventureWorks2019
GO

SELECT ProductID, ListPrice, Name, ProductSubcategoryID 
FROM Production.Product p
WHERE ListPrice = (SELECT MIN(ListPrice) 
					FROM Production.Product pd 
					WHERE pd.ProductSubcategoryID = p.ProductSubcategoryID)
ORDER BY p.ProductSubcategoryID

-- EXISTS Y NOT EXISTS

/*

	5) Mostrar los nombres de todos los productos presentes en la subcategoría de
	ruedas
	SQL tablas:Production.Product, Production.ProductSubcategory
	MySQL tablas: Product, ProductSubcategory
	campos: ProductSubcategoryID, Name

*/

USE AdventureWorks2019
GO

SELECT * FROM Production.Product p 
WHERE EXISTS (SELECT * FROM Production.ProductSubcategory psc
		WHERE psc.ProductSubcategoryID = p.ProductSubcategoryID AND psc.Name like '%Wheels%')

/*

	6) Mostrar todos los productos que no fueron vendidos
	SQL tablas:Production.Product, Sales.SalesOrderDetail
	MySQL tablas: Product, SalesOrderDetail
	campos: Name, ProductID

*/

USE AdventureWorks2019
GO

SELECT * FROM Production.Product p 
WHERE NOT EXISTS (SELECT 1 FROM Sales.SalesOrderDetail sod
	WHERE sod.ProductID = p.ProductID)

/*

	7) Mostrar la cantidad de personas que no son vendedores
	SQL tablas: Person.Person, Sales.SalesPerson
	MySQL tablas: contact, SalesPerson
	campos: BusinessEntityID

*/

USE AdventureWorks2019
GO

SELECT * FROM Person.Person P WHERE NOT EXISTS (SELECT 1 FROM Sales.SalesPerson sp
	WHERE sp.BusinessEntityID = P.BusinessEntityID)

/*
    
    8) Mostrar todos los vendedores (nombre y apellido) que no tengan asignado un
	territorio de ventas
	SQL tablas: Person.Person, Sales.SalesPerson
	MySQL tablas: contact, SalesPerson
	campos: BusinessEntityID, TerritoryID, LastName, FirstName
    
*/

USE AdventureWorks2019
GO

SELECT * FROM Person.Person P WHERE EXISTS (SELECT 1 FROM Sales.SalesPerson sp
	WHERE sp.BusinessEntityID = P.BusinessEntityID AND sp.TerritoryID IS NULL)
	
-- IN Y NOT IN

/*
    
	9) Mostrar las órdenes de venta que se hayan facturado en territorio de estado
	unidos únicamente 'us'
	SQL tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
    MySQL tablas: SalesOrderHeader, SalesTerritory
	campos: CountryRegionCode, TerritoryID
    
*/

USE AdventureWorks2019
GO

SELECT * FROM Sales.SalesOrderHeader WHERE TerritoryID 
	IN (SELECT TerritoryID FROM Sales.SalesTerritory WHERE CountryRegionCode = 'US')

/*
    
	10) Al ejercicio anterior agregar ordenes de Francia e Inglaterra
	SQL tablas: Sales.SalesOrderHeader, Sales.SalesTerritory
	MySQL tablas: SalesOrderHeader, SalesTerritory
	campos: CountryRegionCode, TerritoryID
    
*/

USE AdventureWorks2019
GO

SELECT * FROM Sales.SalesOrderHeader WHERE TerritoryID 
	IN (SELECT TerritoryID FROM Sales.SalesTerritory 
		WHERE CountryRegionCode IN ('US', 'FR', 'GB'))

/*
    
	11) Mostrar los nombres de los diez productos más caros
	SQL tablas: Production.Product
    MySQL tablas: Product
	campos: ListPrice
    
*/

USE AdventureWorks2019
GO

SELECT * FROM Production.Product WHERE ListPrice IN 
	(SELECT DISTINCT TOP 10 ListPrice FROM Production.Product ORDER BY ListPrice DESC)

/*
    
	12) Mostrar aquellos productos cuya cantidad de pedidos de venta sea igual o
	superior a 20
	SQL tablas: Production.Product, Sales.SalesOrderDetail
	MySQL tablas: Product, SalesOrderDetail
	campos: Name, ProductID , OrderQty
    
*/

USE AdventureWorks2019
GO

SELECT * FROM Production.Product WHERE ProductID IN 
	(SELECT ProductID FROM Sales.SalesOrderDetail WHERE OrderQty >= 20)

-- INSERT, UPDATE Y DELETE

/*

	13) Clonar estructura y datos de los campos id, nombre, color y precio de lista de la tabla
	production.product en una tabla llamada Productos
	SQL tablas: Production.Product
    MySQL tablas: Product
	campos: Name, Color, ListPrice

*/

USE AdventureWorks2019
GO

IF OBJECT_ID('productos', 'U') IS NULL
BEGIN
	SELECT ProductID, Name, Color, ListPrice 
	INTO productos
	FROM Production.Product
END

/*

	Nota: Una manera de poder clonar el objeto vacío.

	SELECT ProductID, Name, Color, ListPrice 
	INTO productos
	FROM Production.Product WHERE 1 = 2

*/

/*

	14) Aumentar un 20% el precio de lista de todos los productos
	tablas: Produccion
	campos: ListPrice

*/

USE AdventureWorks2019
GO

UPDATE productos
SET ListPrice = CAST(ROUND((ListPrice * 1.20), 2) AS DECIMAL(10,2))

/*

	15) Aumentar un 20% el precio de lista de los productos del proveedor 1594 (53 en MySQL)
	SQL tablas: Productos, Purchasing.ProductVendor
	MySQL tablas: Productos, ProductVendor
	campos: ProductID, ListPrice, BusinessEntityID

*/

USE AdventureWorks2019
GO

UPDATE p
SET p.ListPrice = CAST(ROUND((ListPrice * 1.20), 2) AS DECIMAL(10,2))
FROM productos p INNER JOIN Purchasing.ProductVendor pv
	ON (pv.ProductID = p.ProductID) WHERE pv.BusinessEntityID = 1594

/*

	16) Eliminar los productos cuyo precio es igual a cero
	tablas: Productos
	campos: ListPrice

*/

USE AdventureWorks2019
GO

DELETE FROM productos WHERE ListPrice = 0

/*

	Nota: Una manera de borrar registros, con JOIN

	DELETE p
	FROM productos p INNER JOIN Purchasing.ProductVendor pv
		ON (pv.ProductID = p.ProductID) WHERE pv.BusinessEntityID = 1594

*/

/*

	17) Insertar un producto dentro de la tabla productos.
	tener en cuenta los siguientes datos.
	el color de producto debe ser rojo, el nombre debe ser "bicicleta mountain bike"
	y el precio de lista debe ser de 4000 pesos.
	tablas:productos
	campos: Color,Name, ListPrice

*/

USE AdventureWorks2019
GO

INSERT INTO productos (Color, Name, ListPrice) VALUES ('Rojo','bicicleta mountain bike',4000)

/*

	18) Aumentar en un 15% el precio de los pedales de bicicleta
	tablas: productos
	campos: Name, ListPrice

*/

USE AdventureWorks2019
GO

UPDATE p
SET p.ListPrice = CAST(ROUND((ListPrice * 1.15),2) AS DECIMAL(10,2))
FROM Productos p 
WHERE Name LIKE '%pedal%'

/*

	19) Eliminar los productos cuyo nombre empiece con la letra m
	tablas: productos
	campos: Name

*/

USE AdventureWorks2019
GO

DELETE FROM Productos WHERE Name LIKE 'm%'

/*

	20) Borrar todo el contenido de la tabla productos sin utilizar la instrucción delete.
	tablas: productos

*/

USE AdventureWorks2019
GO

TRUNCATE TABLE productos

/*

	21) Eliminar tabla productos
	tablas: productos

*/

USE AdventureWorks2019
GO

DROP TABLE productos

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
	10.1) Obtener el título, precio de un libro específico y la diferencia entre su precio y el
	máximo valor
	10.2) Mostrar el título y precio del libro más costoso
	10.3) Actualizar un 20% el precio del libro con máximo valor
	10.4) Eliminamos los libros con precio menor

*/

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'laboratorio_subconsulta')
BEGIN
    CREATE DATABASE laboratorio_subconsulta
END

USE laboratorio_subconsulta
GO

IF OBJECT_ID('libros', 'U') IS NULL
BEGIN
CREATE TABLE libros(
	codigo INT IDENTITY(1,1) NOT NULL,
	titulo VARCHAR(40),
	autor VARCHAR(30),
	editorial VARCHAR(20),
	precio DECIMAL(5,2),
    PRIMARY KEY (codigo)
)
END

INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00)
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00)
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Aprenda PHP','Mario Molina','Siglo XXI',40.00)
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('El aleph','Borges','Emece',10.00)
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Ilusiones','Richard Bach','Planeta',15.00)
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Java en 10 minutos','Mario Molina','Siglo XXI',50.00)
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Martin Fierro','Jose Hernandez','Planeta',20.00)
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Martin Fierro','Jose Hernandez','Emece',30.00)
INSERT INTO libros (titulo, autor, editorial, precio) VALUES ('Uno','Richard Bach','Planeta',10.00)
    
-- 22.1) Obtener el título, precio de un libro específico y la diferencia entre su precio y el máximo valor

SELECT titulo, precio, 
	(SELECT (precio - (SELECT MAX(precio) FROM libros))) AS diferencia_con_max_precio 
FROM libros

-- 22.2) Mostrar el título y precio del libro más costoso

SELECT titulo, precio FROM libros WHERE precio = (SELECT MAX(precio) FROM libros)

-- 22.3) Actualizar un 20% el precio del libro con máximo valor

UPDATE libros
SET precio = precio * 1.20 WHERE precio = (SELECT MAX(precio) FROM libros)

-- 22.4) Eliminamos los libros con precio menor

DELETE FROM libros WHERE precio < (SELECT MAX(precio) FROM libros)

-- VARIABLES

/*

	23) Obtener el total de ventas del año 2014 y guardarlo en una variable llamada
	@TotalVentas, luego imprimir el resultado.
	Tablas: Sales.SalesOrderDetail
	Campos: LineTotal

*/

USE AdventureWorks2019
GO

DECLARE @TotalVentas NUMERIC(38,6) = 0

SELECT @TotalVentas = SUM(sod.LineTotal)
FROM sales.SalesOrderDetail sod
INNER JOIN sales.SalesOrderHeader soh
  ON (soh.SalesOrderID = sod.SalesOrderID)
WHERE YEAR(soh.OrderDate) = 2014

PRINT @TotalVentas

/*

	24) Obtener el promedio de ventas y guardarlo en una variable llamada @Promedio
	luego hacer un reporte de todos los productos cuyo precio de venta sea menor al
	Promedio.
	Tablas: Production.Product
	Campos: ListPrice, ProductID

*/

USE AdventureWorks2019
GO

DECLARE @Promedio MONEY = 0

SELECT @Promedio = AVG(ListPrice)
FROM Production.Product

SELECT * 
FROM Production.Product
WHERE ListPrice < @Promedio

/*

	25) Utilizando la variable @Promedio incrementar en un 10% el valor de los productos
	sean inferior al promedio.
	Tablas: Production.Product
	Campos: ListPrice

*/

USE AdventureWorks2019
GO

SELECT *
INTO #productos
FROM Production.Product

DECLARE @Promedio MONEY = 0

SELECT @Promedio = AVG(ListPrice)
FROM Production.Product

UPDATE #productos
SET ListPrice = ROUND(ListPrice * 1.10, 2)
WHERE ListPrice < @Promedio

DROP TABLE IF EXISTS #productos

/*

	26) Crear un variable de tipo tabla con las categorías y subcategoría de productos
	y reportar el resultado.
	Tablas: Production.ProductSubcategory, Production.ProductCategory
	Campos: Name

*/

USE AdventureWorks2019
GO

DECLARE @categoria_subcategoria TABLE 
			(
			ProductCategoryID		INT NULL,
			nombre_categoria		VARCHAR(100) NULL,
			ProductSubcategoryID	INT NULL,
			nombre_subcategoria		VARCHAR(100) NULL
			)
INSERT INTO @categoria_subcategoria (
									ProductCategoryID,
									nombre_categoria,
									ProductSubcategoryID,
									nombre_subcategoria
									)
SELECT	pc.ProductCategoryID, 
		pc.Name AS 'nombre_categoria',
		ps.ProductSubcategoryID,
		ps.Name AS 'nombre_subcategoria'
from Production.ProductSubcategory ps
INNER JOIN Production.ProductCategory pc
	ON (pc.ProductCategoryID = ps.ProductCategoryID)
SELECT * FROM @categoria_subcategoria

/*

	27) Analizar el promedio de la lista de precios de productos, si su valor es menor 500
	imprimir el mensaje el PROMEDIO BAJO de lo contrario imprimir el mensaje PROMEDIO
	ALTO

*/

USE AdventureWorks2019
GO

DECLARE @Promedio MONEY

SELECT @Promedio = AVG(ListPrice) FROM Production.Product

IF (@Promedio IS NULL)
BEGIN
	PRINT 'No existe promedio'
END 
ELSE 
	IF (@Promedio < 500)
	BEGIN
		PRINT 'Promedio bajo'
	END 
	ELSE
	BEGIN
		PRINT 'Promedio alto'
	END