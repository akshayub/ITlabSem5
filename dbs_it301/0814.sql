-- CREATE DATABASE IF NOT EXISTS southwind_15it204;
-- DROP DATABASE southwind_15it204;
CREATE DATABASE IF NOT EXISTS southwind_15it204;
USE southwind_15it204;
SELECT DATABASE();

CREATE TABLE IF NOT EXISTS products (
	productID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	productCode CHAR(3) NOT NULL DEFAULT ' ',
	name VARCHAR(30) NOT NULL DEFAULT ' ',
	quantity INT UNSIGNED NOT NULL DEFAULT 0,
	price DECIMAL(7,2) NOT NULL DEFAULT 99999.99,
	PRIMARY KEY (productID)
);

SHOW TABLES;
DESCRIBE products;

/*
INSERT INTO products
VALUES (NULL, 'PED', 'ped test', 50000, 2.55);
SELECT * FROM products;
DELETE FROM products where productID=1;
*/

INSERT INTO products
VALUES (1001, 'PEN', 'Pen Red', 5000, 1.23),
	(1002, 'PEN', 'Pen Blue', 8000, 1.25),
	(1003, 'PEN', 'Pen Black', 2000, 1.25),
	(1004, 'PEC', 'Pencil 2B', 10000, 0.48),
	(1005, 'PEC', 'Pencil 2H', 8000, 0.49);
	
/*	
DELETE FROM products where productID=1001;
DELETE FROM products where productID=1002;
DELETE FROM products where productID=1003;
DELETE FROM products where productID=1004;
DELETE FROM products where productID=1005;
*/

CREATE TABLE IF NOT EXISTS suppliers (
	supplierID INT UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL DEFAULT ' ',
	phone CHAR(8) NOT NULL DEFAULT '00000000',
	PRIMARY KEY (supplierID)
);

SHOW TABLES;
DESCRIBE suppliers;

INSERT INTO suppliers
VALUES (501, 'ABC Traders', '88881111'),
	(502, 'XYZ Company', '88882222'),
	(503, 'QQ Corp', '88883333');
/*	
DELETE FROM suppliers where productID=501;
DELETE FROM suppliers where productID=502;
DELETE FROM suppliers where productID=503;
*/	

SELECT * FROM products;
SELECT * FROM suppliers;