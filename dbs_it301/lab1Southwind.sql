create database southwind;

-- Query OK, 0 rows affected (0.01 sec)

use southwind;

-- Database changed

create table products(
productID INT UNSIGNED NOT NULL AUTO_INCREMENT,
productCode CHAR(3) NOT NULL DEFAULT ' ',
name VARCHAR(30) NOT NULL DEFAULT ' ',
quantity INT UNSIGNED NOT NULL DEFAULT 0,
price DECIMAL(7,2) NOT NULL DEFAULT 99999.99,
primary key (productID));

/*
Query OK, 0 rows affected (0.06 sec)
*/

INSERT INTO products VALUES
(1001, 'PEN', 'Pen Red', 5000, 1.23);
(NULL,'PEN', 'Pen Blue', 8000, 1.25),
(NULL, 'PEN', 'Pen Black', 2000, 1.25),
(NULL, 'PEC', 'Pencil 2B', 10000, 0.48),
(NULL, 'PEC', 'Pencil 2H', 8000, 0.49);

/* 
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0
*/
select * from products;

/*
+-----------+-------------+-----------+----------+-------+
| productID | productCode | name      | quantity | price |
+-----------+-------------+-----------+----------+-------+
|      1001 | PEN         | Pen Red   |     5000 |  1.23 |
|      1002 | PEN         | Pen Blue  |     8000 |  1.25 |
|      1003 | PEN         | Pen Black |     2000 |  1.25 |
|      1004 | PEC         | Pencil 2B |    10000 |  0.48 |
|      1005 | PEC         | Pencil 2H |     8000 |  0.49 |
+-----------+-------------+-----------+----------+-------+
5 rows in set (0.00 sec)
*/

describe products;

/*
+-------------+------------------+------+-----+----------+----------------+
| Field       | Type             | Null | Key | Default  | Extra          |
+-------------+------------------+------+-----+----------+----------------+
| productID   | int(10) unsigned | NO   | PRI | NULL     | auto_increment |
| productCode | char(3)          | NO   |     |          |                |
| name        | varchar(30)      | NO   |     |          |                |
| quantity    | int(10) unsigned | NO   |     | 0        |                |
| price       | decimal(7,2)     | NO   |     | 99999.99 |                |
+-------------+------------------+------+-----+----------+----------------+
5 rows in set (0.05 sec)
*/

select * from products where name in ('Pen Red', 'Pen Blue');

/*
+-----------+-------------+----------+----------+-------+
| productID | productCode | name     | quantity | price |
+-----------+-------------+----------+----------+-------+
|      1001 | PEN         | Pen Red  |     5000 |  1.23 |
|      1002 | PEN         | Pen Blue |     8000 |  1.25 |
+-----------+-------------+----------+----------+-------+
2 rows in set (0.00 sec)
*/

select * from products having quantity > 5000;

/*
+-----------+-------------+-----------+----------+-------+
| productID | productCode | name      | quantity | price |
+-----------+-------------+-----------+----------+-------+
|      1002 | PEN         | Pen Blue  |     8000 |  1.25 |
|      1004 | PEC         | Pencil 2B |    10000 |  0.48 |
|      1005 | PEC         | Pencil 2H |     8000 |  0.49 |
+-----------+-------------+-----------+----------+-------+
3 rows in set (0.00 sec)
*/

select productCode,COUNT(*) AS count from products group by productCode order by count desc;

/*
+-------------+-------+
| productCode | count |
+-------------+-------+
| PEN         |     3 |
| PEC         |     2 |
+-------------+-------+
2 rows in set (0.00 sec)
*/

 create table suppliers(
 supplierID INT NOT NULL AUTO_INCREMENT,
 name VARCHAR(30) NOT NULL DEFAULT ' ',
 phone CHAR(8) NOT NULL DEFAULT '12345678',
 primary key(supplierID));
 
 -- Query OK, 0 rows affected (0.06 sec)
 
 SHOW tables;
 
 /*
 +---------------------+
| Tables_in_southwind |
+---------------------+
| products            |
| suppliers           |
+---------------------+
2 rows in set (0.00 sec)
*/

describe suppliers;

/*
+------------+-------------+------+-----+----------+----------------+
| Field      | Type        | Null | Key | Default  | Extra          |
+------------+-------------+------+-----+----------+----------------+
| supplierID | int(11)     | NO   | PRI | NULL     | auto_increment |
| name       | varchar(30) | NO   |     |          |                |
| phone      | char(8)     | NO   |     | 12345678 |                |
+------------+-------------+------+-----+----------+----------------+
3 rows in set (0.03 sec)
*/

SELECT productCode, MAX(price), MIN(price),
CAST(AVG(price) AS DECIMAL(7,2)) AS 'Average',
CAST(STD(price) AS DECIMAL(7,2)) AS 'Std Dev',
SUM(quantity) FROM products GROUP BY productCode;

/*
+-------------+------------+------------+---------+---------+---------------+
| productCode | MAX(price) | MIN(price) | Average | Std Dev | SUM(quantity) |
+-------------+------------+------------+---------+---------+---------------+
| PEC         |       0.49 |       0.48 |    0.49 |    0.01 |         18000 |
| PEN         |       1.25 |       1.23 |    1.24 |    0.01 |         15000 |
+-------------+------------+------------+---------+---------+---------------+
2 rows in set (0.00 sec)
*/

INSERT INTO suppliers VALUE
(501, 'ABC Traders', '88881111'),
(NULL, 'XYZ Company', '88882222'),
(NULL, 'QQ Corp.', '88883333');

/*
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0
*/

select * from suppliers;

/*
+------------+-------------+----------+
| supplierID | name        | phone    |
+------------+-------------+----------+
|        501 | ABC Traders | 88881111 |
|        502 | XYZ Company | 88882222 |
|        503 | QQ Corp.    | 88883333 |
+------------+-------------+----------+
3 rows in set (0.00 sec)
*/

SELECT productCode AS 'PC', COUNT(*) AS 'count',
CAST(AVG(price) AS DECIMAL(7,2)) AS 'Average'
FROM products GROUP BY PC HAVING count >= 3;

/*
+-----+-------+---------+
| PC  | count | Average |
+-----+-------+---------+
| PEN |     3 |    1.24 |
+-----+-------+---------+
1 row in set (0.00 sec)
*/