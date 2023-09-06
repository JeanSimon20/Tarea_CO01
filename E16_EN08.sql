-- Creacion de Base de Datos de prueba
CREATE DATABASE schooldb
USE schooldb;
 
-- �ndices Agrupados
CREATE TABLE student
(
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    DOB datetime NOT NULL,
    total_score INT NOT NULL,
    city VARCHAR(50) NOT NULL
 )

EXECUTE sp_helpindex student

--�ndices no Agrupados
CREATE NONCLUSTERED INDEX IX_tblStudent_Name
ON student(name ASC)


-- Indice Unico
( 
ID INT IDENTITY (1,1) PRIMARY KEY,
Name Varchar(50) CONSTRAINT UQ_Name UNIQUE,
ADDRESS NVARCHAR(MAX)
)

DROP INDEX UQ_Name ON DiffIndexTypesDemo

ALTER TABLE DiffIndexTypesDemo DROP CONSTRAINT UQ_Name

CREATE UNIQUE NONCLUSTERED INDEX IX_DiffIndexTypesDemo_Name ON DiffIndexTypesDemo (NAME)
--- Un �ndice �nico es usado para aplicar la singularidad de los valores de �ndice clave. 


-- Indice de texto completo
EXEC sp_fulltext_database 'enable';
GO

CREATE TABLE ProductDescriptions (
    ProductID INT PRIMARY KEY,
    Description NVARCHAR(MAX)
);
GO

-- Insertar algunos datos en la tabla ProductDescriptions
INSERT INTO ProductDescriptions (ProductID, Description)
VALUES (1, 'Estos auriculares de alta calidad cuentan con cancelaci�n de ruido.'),
       (2, 'El smartphone tiene una potente c�mara para tomar fotos impresionantes.'),
       (3, 'La computadora port�til tiene un procesador r�pido para tareas exigentes.');
GO

-- Crear un cat�logo de texto completo
CREATE FULLTEXT CATALOG MyFullTextCatalog;
GO

--Indice Especiales
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY,
    LocationName NVARCHAR(100),
    Coordinates GEOGRAPHY
);
GO

INSERT INTO Locations (LocationID, LocationName, Coordinates)
VALUES (1, 'Oficina A', geography::Point(47.12345, -122.45678, 4326)),
       (2, 'Almac�n B', geography::Point(48.98765, -123.98765, 4326)),
       (3, 'Tienda C', geography::Point(46.54321, -121.23456, 4326));
GO

-- Crear un �ndice espacial en la columna Coordinates
CREATE SPATIAL INDEX idx_Coordinates ON Locations(Coordinates);
GO


-- Indice de Columna Calculada
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    TotalPrice AS (Quantity * UnitPrice) PERSISTED  -- Columna calculada persistente
);
GO

-- Insertar algunos datos en la tabla OrderItems
INSERT INTO OrderItems (OrderItemID, ProductID, Quantity, UnitPrice)
VALUES (1, 1, 5, 29.99),
       (2, 2, 2, 499.99),
       (3, 3, 1, 799.99);
GO

-- Crear un �ndice en la columna calculada TotalPrice
CREATE INDEX idx_TotalPrice ON OrderItems (TotalPrice);
GO

select * from OrderItems;