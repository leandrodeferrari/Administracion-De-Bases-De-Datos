-- Laboratorio Operadores

/*

	1) Mostrar los empleados que tienen m�s de 90 horas de vacaciones.
	SQL tabla: HumanResources.Employee
	MySQL tabla: Employee
	campos: VacationHours

*/

USE AdventureWorks2019
GO

SELECT * FROM HumanResources.Employee WHERE VacationHours > 90

/*

	2) Mostrar el nombre, precio y precio con iva de los productos con precio distinto de
	cero.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: Name, ListPrice

*/

USE AdventureWorks2019
GO

SELECT Name, ListPrice, (ListPrice * 1.21) AS ListPricePlusIva FROM Production.Product WHERE ListPrice <> 0

/*

	3) Mostrar precio y nombre de los productos 776, 777, 778.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: ProductID, Name, ListPrice

*/

USE AdventureWorks2019
GO

SELECT Name, ListPrice FROM Production.Product WHERE ProductID IN(776, 777, 778)

/*

	4) Mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea
	johnson.
	SQL tabla: Person.Person
	MySQL tabla: contact
	campos: FirstName, LastName

*/

USE AdventureWorks2019
GO

SELECT CONCAT_WS(' ', FirstName, LastName) AS FirstNameLastName FROM Person.Person WHERE LastName = 'Johnson'

/*

	5) Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo
	precio sea mayor a 500$ de color negro.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: ListPrice, Color

*/

USE AdventureWorks2019
GO

SELECT * FROM Production.Product WHERE (ListPrice < 150 AND Color = 'Red') OR (ListPrice > 500 AND Color = 'Black')

/*

	6) Mostrar el c�digo, fecha de ingreso y horas de vacaciones de los empleados
	ingresaron a partir del a�o 2000.
	SQL tabla: HumanResources.Employee
	MySQL tabla: Employee
	campos: BusinessEntityID, HireDate, VacationHours

*/

USE AdventureWorks2019
GO

SELECT BusinessEntityID, HireDate, VacationHours FROM HumanResources.Employee WHERE YEAR(HireDate) >= 2000

/*

	7) Mostrar el nombre, n�mero de producto, precio de lista y el precio de lista
	incrementado en un 10% de los productos cuya fecha de fin de venta sea anterior al d�a
	de hoy.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: Name, ProductNumber, ListPrice, SellStartDate
	campos: Weight

*/

USE AdventureWorks2019
GO

SELECT Name, ProductNumber, ListPrice, (ListPrice * 1.10) AS ListPricePlus10Percentage, SellStartDate FROM Production.Product 
WHERE SellStartDate < GETDATE()
