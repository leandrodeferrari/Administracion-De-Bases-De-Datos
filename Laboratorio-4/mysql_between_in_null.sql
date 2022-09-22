#Laboratorio BETWEEN, IN, NULL

# Laboratorio BETWEEN

/*

	1) Mostrar todos los productos cuyo precio de lista esté entre 200 y 300.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: ListPrice

*/

USE adventureworks;

SELECT * FROM product WHERE ListPrice BETWEEN 200 AND 300;

/*

	2) Mostrar todos los empleados que nacieron entre 1970 y 1985.
	SQL tabla: HumanResources.Employee
	MySQL tabla: employee
	campos: BirthDate

*/

USE adventureworks;

SELECT *  FROM employee WHERE YEAR(BirthDate) BETWEEN 1970 AND 1985;

/*

	3) Mostrar el la fecha,numero de version y subtotal de las ventas efectuadas en los años
	2000 y 2006.
	SQL tabla:Sales.SalesOrderHeader
	MySQL tabla: SalesOrderHeader
	campos: OrderDate, AccountNumber, SubTotal

*/

USE adventureworks;

SELECT YEAR(OrderDate) AS OrderYear, AccountNumber, SubTotal FROM SalesOrderHeader WHERE YEAR(OrderDate) BETWEEN 2000 AND 2006;

/*

	4) Mostrar todos los productos cuyo precio de lista no esté entre 50 y 70.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: ListPrice

*/

USE adventureworks;

SELECT * FROM product WHERE ListPrice NOT BETWEEN 50 AND 70;

# Laboratorio IN

/*

	1) Mostrar los códigos de venta y producto, cantidad de venta y precio unitario de los
	artículos 750, 753 y 770.
	SQL tablas: Sales.SalesOrderDetail
	MySQL tabla: SalesOrderDetail
	campos: SalesOrderID, ProductID, OrderQty, UnitPrice

*/

USE adventureworks;

SELECT SalesOrderID, ProductID, OrderQty, UnitPrice FROM SalesOrderDetail WHERE ProductID IN(750, 753, 770);

/*

	2) Mostrar todos los productos cuyo color no sea verde, blanco y azul.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: Color

*/

USE adventureworks;

SELECT * FROM product WHERE Color NOT IN ('Green', 'Blue', 'White');

# Laboratorio NULL

/*

	1) Mostrar los representantes de ventas (vendedores) que no tienen definido el número
	de territorio.
	SQL tablas: Sales.SalesPerson
	MySQL tabla: SalesPerson
	campos: SalesPersonID, TerritoryID

*/

USE adventureworks;

SELECT SalesPersonID, TerritoryID FROM SalesPerson WHERE TerritoryID IS NULL;

/*

	2) Mostrar el peso de todos los artículos. si el peso no estuviese definido, reemplazar
	por cero.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: Weight

*/

USE adventureworks;

SELECT 
CASE WHEN Weight IS NULL THEN 0 
	 ELSE Weight 
	 END Weight
FROM product;
