-- Laboratorio Operadores

/*

	1) Mostrar los empleados que tienen más de 90 horas de vacaciones.
	SQL tabla: HumanResources.Employee
	MySQL tabla: Employee
	campos: VacationHours

*/

USE adventureworks;

SELECT * FROM Employee WHERE VacationHours > 90;

/*

	2) Mostrar el nombre, precio y precio con iva de los productos con precio distinto de
	cero.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: Name, ListPrice

*/

USE adventureworks;

SELECT Name, ListPrice, (ListPrice * 1.21) AS ListPricePlusIva FROM Product WHERE ListPrice <> 0;

/*

	3) Mostrar precio y nombre de los productos 776, 777, 778.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: ProductID, Name, ListPrice

*/

USE adventureworks;

SELECT Name, ListPrice FROM Product WHERE ProductID IN(776, 777, 778);

/*

	4) Mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea
	johnson.
	SQL tabla: Person.Person
	MySQL tabla: contact
	campos: FirstName, LastName

*/

USE adventureworks;

SELECT CONCAT_WS(' ', FirstName, LastName) AS FirstNameLastName FROM contact WHERE LastName = 'Johnson';

/*

	5) Mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo
	precio sea mayor a 500$ de color negro.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: ListPrice, Color

*/

USE adventureworks;

SELECT * FROM Product WHERE (ListPrice < 150 AND Color = 'Red') OR (ListPrice > 500 AND Color = 'Black');

/*

	6) Mostrar el código, fecha de ingreso y horas de vacaciones de los empleados
	ingresaron a partir del año 2000.
	SQL tabla: HumanResources.Employee
	MySQL tabla: Employee
	campos: BusinessEntityID, HireDate, VacationHours

*/

USE adventureworks;

SELECT EmployeeID, HireDate, VacationHours FROM Employee WHERE YEAR(HireDate) >= 2000;

/*

	7) Mostrar el nombre, número de producto, precio de lista y el precio de lista
	incrementado en un 10% de los productos cuya fecha de fin de venta sea anterior al día
	de hoy.
	SQL tabla: Production.Product
	MySQL tabla: product
	campos: Name, ProductNumber, ListPrice, SellStartDate

*/

USE adventureworks;

SELECT Name, ProductNumber, ListPrice, (ListPrice * 1.10) AS ListPricePlus10Percentage, SellStartDate FROM Product 
WHERE SellStartDate < CURRENT_TIMESTAMP();
