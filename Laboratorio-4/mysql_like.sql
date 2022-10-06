-- Laboratorio Like

/* 

	1) Mostrar el nombre, precio y color de los accesorios para asientos (Seat) de las
	bicicletas cuyo precio sea mayor a 100 pesos.
	SQL tabla: Production.Product
	MySQL tabla: Product
	campos: Name, ListPrice, Color

*/

USE adventureworks;

SELECT Name, ListPrice, Color FROM Product WHERE Name LIKE '%Seat%' AND ListPrice > 100;

/* 

	2) Mostrar los nombre de los productos que tengan cualquier combinación de
	'mountain bike'.
	SQL tabla: Production.Product
	MySQL tabla: Product
	campos: Name

*/

USE adventureworks;

SELECT Name FROM Product WHERE Name LIKE '%mountain bike%';

/* 

	3) Mostrar las personas que su nombre empiece con la letra 'y'.
	SQL tabla:Person.Person
	MySQL tabla: contact
	campos: FirstName

*/

USE adventureworks;

SELECT FirstName FROM Contact WHERE FirstName LIKE 'y%';

/* 

	4) Mostrar las personas que la segunda letra de su apellido es una s.
	SQL tabla:Person.Person
	MySQL tabla: contact
	campos: LastName

*/

USE adventureworks;

SELECT LastName FROM Contact WHERE LastName LIKE '_s%';

/* 

	5) Mostrar el nombre concatenado con el apellido de las personas cuyo apellido tengan
	terminación española (ez).
	SQL tabla:Person.Person
	MySQL tabla: contact
	campos: FirstName,LastName

*/

USE adventureworks;

SELECT CONCAT_WS(' ', FirstName, LastName) AS FirstNameLastName FROM Contact WHERE LastName LIKE '%ez';

/* 

	6) Mostrar los nombres de los productos que terminen en un número.
	SQL tabla: Production.Product
	MySQL tabla: Product
	campos: Name

*/

USE adventureworks;

SELECT Name FROM Product WHERE Name REGEXP '[0-9]';

-- Expresión regular

/* 

	7) Mostrar las personas cuyo nombre tenga una C o c como primer carácter, cualquier
	otro como segundo carácter, ni d ni e ni f ni g como tercer carácter, cualquiera entre j y
	r o entre s y w como cuarto carácter y el resto sin restricciones.
	SQL tabla:Person.Person
	MySQL tabla: contact
	campos: FirstName

*/

USE adventureworks;

SELECT FirstName FROM contact WHERE FirstName REGEXP '^c.[^d-g][j-w].';
