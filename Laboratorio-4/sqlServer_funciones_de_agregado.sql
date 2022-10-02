-- Laboratorio Funciones de Agregado

-- Funciones de agregado

/*

	1) Mostrar la fecha más reciente de venta
	SQL Tabla: Sales.SalesOrderHeader
	MySQL Tabla: SalesOrderHeader
	Campos: OrderDate

*/

USE AdventureWorks2019
GO

SELECT MAX(OrderDate) AS MaxOrderDate FROM Sales.SalesOrderHeader

/*

	2) Mostrar el precio más barato de todas las bicicletas
	SQL Tabla: Production.Product
	MySQL Tabla: Product
	Campos: ListPrice, Name

*/

USE AdventureWorks2019
GO

SELECT MIN(ListPrice) AS MinListPrice FROM Production.Product WHERE name LIKE '%Bike%'

/*

	3) Mostrar la fecha de nacimiento del empleado más joven
	SQL Tabla: HumanResources.Employee
	MySQL Tabla: Employee
	Campos: BirthDate

*/

USE AdventureWorks2019
GO

SELECT MAX(BirthDate) AS MinBirthDate FROM HumanResources.Employee

/*

	4) Mostrar el promedio del listado de precios de productos
	SQL Tabla: Production.Product
	MySQL Tabla: Product
	Campos: ListPrice

*/

USE AdventureWorks2019
GO

SELECT AVG(ListPrice) AS AverageListPrice FROM Production.Product

/*

	5) Mostrar la cantidad y el total vendido por productos
	SQL Tabla: Sales.SalesOrderDetail
	MySQL Tabla: SalesOrderDetail
	Campos: LineTotal, OrderQty

*/

USE AdventureWorks2019
GO

SELECT SUM(LineTotal) AS AdditionLineTotal, SUM(OrderQty) AS AmountOrderQty FROM Sales.SalesOrderDetail

-- Agrupamiento

/*

	6) Mostrar el código de subcategoría y el precio del producto más barato de cada una
	de ellas
	SQL Tabla: Production.Product
	MySQL Tabla: Product
	Campos: ProductSubcategoryID, ListPrice

*/

USE AdventureWorks2019
GO

SELECT ProductSubcategoryID, MIN(ListPrice) AS MinListPrice FROM Production.Product 
WHERE ProductSubcategoryID IS NOT NULL GROUP BY ProductSubcategoryID

/*

	7) Mostrar los productos y la cantidad total vendida de cada uno de ellos
    SQL Tabla: Sales.SalesOrderDetail
	MySQL Tabla: SalesOrderDetail
	Campos: ProductID, OrderQty

*/

USE AdventureWorks2019
GO

SELECT ProductID, SUM(OrderQty) AS AmountOrderQty FROM Sales.SalesOrderDetail GROUP BY ProductID

/*

	8) Mostrar los productos y el total vendido de cada uno de ellos, ordenarlos por el total
	vendido
	SQL Tabla: Sales.SalesOrderDetail
	MySQL Tabla: SalesOrderDetail
	Campos: ProductID, LineTotal

*/

USE AdventureWorks2019
GO

SELECT ProductID, SUM(LineTotal) AS AdditionLineTotal FROM Sales.SalesOrderDetail 
GROUP BY ProductID ORDER BY AdditionLineTotal

/*

	9) Mostrar el promedio vendido por factura.
	SQL Tabla: Sales.SalesOrderDetail
	MySQL Tabla: SalesOrderDetail
	Campos: SalesOrderID, LineTotal

*/

USE AdventureWorks2019
GO

SELECT SalesOrderID, AVG(LineTotal) AS AverageLineTotal FROM Sales.SalesOrderDetail GROUP BY SalesOrderID

/*

	10) Trabajamos con la tabla "libros" de una librería
	Creamos la tabla:
	create table libros(
	codigo int identity,
	titulo varchar(40),
	autor varchar(30),
	editorial varchar(15),
	precio decimal(5,2),
	cantidad tinyint,
	primary key(codigo)
	);
	Ingresamos algunos registros:
	insert into libros values('El aleph','Borges','Planeta',15,null);
	insert into libros values('Martin Fierro','Jose Hernandez','Emece',22.20,200);
	insert into libros values('Antologia poetica','J.L. Borges','Planeta',null,150);
	insert into libros values('Aprenda PHP','Mario Molina','Emece',18.20,null);
	insert into libros values('Cervantes y el quijote','Bioy Casares- J.L.
	Borges','Paidos',null,100);
    insert into libros values('Manual de PHP', 'J.C. Paez', 'Siglo XXI',31.80,120);
	insert into libros values('Harry Potter y la piedra filosofal','J.K.
	Rowling',default,45.00,90);
	insert into libros values('Harry Potter y la camara secreta','J.K.
	Rowling','Emece',null,100);
	insert into libros values('Alicia en el pais de las maravillas','Lewis
	Carroll','Paidos',22.50,200);
	insert into libros values('PHP de la A a la Z',null,null,null,0);
    
	5.1) Obtener la cantidad de libros de cada editorial
	5.2) Conocer el total en dinero de los libros agrupados por editorial
	5.3) Obtenemos el máximo y mínimo valor de los libros agrupados por editorial
	5.4) Calcular el promedio del valor de los libros agrupados por editorial
	5.5) Contar y agrupar por editorial considerando solamente los libros cuyo precio es
	menor a 30 pesos

*/

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'laboratorio_funciones_agregado')
BEGIN
CREATE DATABASE laboratorio_funciones_agregado
END

USE laboratorio_funciones_agregado
GO

IF OBJECT_ID('libros', 'U') IS NULL
BEGIN
CREATE TABLE libros(
	codigo INT IDENTITY,
	titulo VARCHAR(40),
	autor VARCHAR(30),
	editorial VARCHAR(15),
	precio DECIMAL(5,2),
	cantidad TINYINT,
 	PRIMARY KEY(codigo)
	)
END

	INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('El aleph' ,'Borges' ,'Planeta', 15, NULL)
	INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('Martin Fierro','Jose Hernandez','Emece',22.20,100)
	INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('Antologia poetica','J.L. Borges','Planeta',NULL,100)
	INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('Aprenda PHP','Mario Molina','Emece',18.20,NULL)
	INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('Cervantes y el quijote','Bioy Casares- J.L.
	Borges','Paidos',NULL,100)
    INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('Manual de PHP', 'J.C. Paez', 'Siglo XXI',31.80,120)
	INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('Harry Potter y la piedra filosofal','J.K.
	Rowling',DEFAULT,45.00,90)
	INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('Harry Potter y la camara secreta','J.K.
	Rowling','Emece',NULL,100)
	INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('Alicia en el pais de las maravillas','Lewis
	Carroll','Paidos',22.50,100)
	INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES('PHP de la A a la Z',NULL,NULL,NULL,0)

-- 5.1) Obtener la cantidad de libros de cada editorial

SELECT ISNULL(editorial,'Anónima') editorial, COUNT(1) AS Cantidad_De_Libros FROM libros GROUP BY editorial

-- 5.2) Conocer el total en dinero de los libros agrupados por editorial

SELECT ISNULL(editorial,'Anónima') editorial, SUM(precio) AS Total_Dinero FROM libros GROUP BY editorial

-- 5.3) Obtenemos el máximo y mínimo valor de los libros agrupados por editorial

SELECT ISNULL(editorial,'Anónima') editorial, MIN(precio) AS Minimo, MAX(precio) AS Maximo FROM libros GROUP BY editorial

-- 5.4) Calcular el promedio del valor de los libros agrupados por editorial

SELECT ISNULL(editorial,'Anónima') editorial, AVG(precio) AS Precio_Promedio FROM libros GROUP BY editorial

-- 5.5) Contar y agrupar por editorial considerando solamente los libros cuyo precio es menor a 30 pesos

SELECT ISNULL(editorial,'Anónima') editorial, COUNT(1) AS Cantidad FROM libros WHERE precio < 30 GROUP BY editorial

-- Having

/*

	11) Mostrar todas las facturas realizadas y el total facturado de cada una de ellas
	ordenado por número de factura pero sólo de aquellas órdenes superen un total de
	$10.000
	SQL Tabla: Sales.SalesOrderDetail
	MySQL Tabla: SalesOrderDetail
	Campos: SalesOrderID, LineTotal

*/

USE AdventureWorks2019
GO

SELECT SalesOrderID, SUM(LineTotal) AS AdditionLineTotal FROM Sales.SalesOrderDetail GROUP BY SalesOrderID HAVING SUM(LineTotal) > 10000

/*

	12) Mostrar la cantidad de facturas que vendieron más de 20 unidades
	SQL Tabla: Sales.SalesOrderDetail
	MySQL Tabla: SalesOrderDetail
	Campos: SalesOrderID, OrderQty

*/

USE AdventureWorks2019
GO

SELECT SalesOrderID, SUM(OrderQty) AS AmountOrderQty FROM Sales.SalesOrderDetail GROUP BY SalesOrderID HAVING SUM(OrderQty) > 20

/*

	13) Mostrar las subcategorías de los productos que tienen dos o más productos que
	cuestan menos de $150
	SQL Tabla: Production.Product
	MySQL Tabla: Product
	Campos: ProductSubcategoryID, ListPrice

*/

USE AdventureWorks2019
GO

SELECT ProductSubcategoryID, COUNT(ListPrice) AS AcountListPrice FROM Production.Product 
WHERE ListPrice < 150 AND ProductSubcategoryID IS NOT NULL 
GROUP BY ProductSubcategoryID HAVING COUNT(ListPrice) >= 2 ORDER BY ProductSubcategoryID

/*

	14) Mostrar todos los códigos de categorías existentes junto con la cantidad de
	productos y el precio de lista promedio por cada uno de aquellos productos que
	cuestan más de $ 70 y el precio promedio es mayor a $ 300.
	SQL Tabla: Production.Product
	MySQL Tabla: Product
	Campos: ProductSubcategoryID, ListPrice

*/

USE AdventureWorks2019
GO

SELECT ProductSubcategoryID, COUNT(1) AS AcountProductSubcategory, AVG(ListPrice) AS AverageListPrice FROM Production.Product 
WHERE ProductSubcategoryID IS NOT NULL AND ListPrice > 70 GROUP BY ProductSubcategoryID HAVING AVG(ListPrice) > 300 ORDER BY ProductSubcategoryID
