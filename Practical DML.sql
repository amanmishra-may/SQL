CREATE DATABASE company;
USE company;

CREATE TABLE supplier(
SID INT PRIMARY KEY ,
Sname VARCHAR(50),
branch VARCHAR(50),
city VARCHAR(50),
phone VARCHAR(15)
);

CREATE TABLE part(
PID INT PRIMARY KEY,
Pname VARCHAR(50),
color VARCHAR(50),
PRICE DECIMAL(10,2)
);

CREATE TABLE supplies(
SID INT,
PID INT,
qty INT,
date_supplied DATE
);

INSERT INTO supplier(SID , Sname ,branch , city , phone)
VALUES
(204001, 'Amit', 'North', 'Delhi', '9876543210'),
(204002, 'Rahul', 'South', 'Mumbai', '9876543211'),
(204003, 'Vandana', 'East', 'Delhi', '9876543212'),
(204004, 'Riya', 'West', 'Agra', '9876543213'),
(204005, 'Rakesh', 'North', 'Goa', '9876543214'),
(204006, 'Vikas', 'South', 'Delhi', '9876543215'),
(204007, 'Priya', 'East', 'Agra', '9876543216'),
(204008, 'Rohit', 'West', 'Mumbai', '9876543217'),
(204009, 'Veena', 'North', 'Goa', '9876543218'),
(204010, 'Kavita', 'South', 'Delhi', '9876543219');


INSERT INTO part(PID ,Pname ,color , PRICE)
VALUES
(101, 'Bolt', 'Red', 10.50),
(102, 'Nut', 'Blue', 5.00),
(103, 'Screw', 'Black', 8.75),
(104, 'Washer', 'Silver', 3.50),
(105, 'Gear', 'Grey', 150.00),
(106, 'Spring', 'Red', 12.00),
(107, 'Pipe', 'White', 80.00),
(108, 'Valve', 'Green', 45.00),
(109, 'Bearing', 'Black', 65.50),
(110, 'Wheel', 'Yellow', 120.00);

INSERT INTO supplies( SID,PID ,qty ,date_supplied)
VALUES
(204001, 101, 100, '2026-10-01'),
(204002, 102, 200, '2026-10-02'),
(204003, 103, 150, '2026-10-03'),
(204004, 104, 300, '2026-10-04'),
(204005, 105, 50, '2026-10-05'),
(204006, 106, 250, '2026-10-06'),
(204007, 107, 75, '2026-10-07'),
(204008, 108, 120, '2026-10-08'),
(204009, 109, 180, '2026-10-09'),
(204010, 110, 90, '2026-10-10');

SELECT * FROM supplier;
SELECT * FROM part;
SELECT * FROM supplies;

SELECT Sname , city FROM supplier;

SELECT Sname ,phone , city FROM supplier 
WHERE city = 'delhi';

SELECT DISTINCT branch FROM supplier;

DELETE FROM supplier
WHERE SID = 204001;

SELECT Sname FROM supplier
WHERE Sname LIKE '%iK%';

SELECT Sname FROM supplier
WHERE Sname LIKE '_R%';

SELECT Sname FROM supplier
WHERE Sname LIKE 'V%a';

SET SQL_SAFE_UPDATES = 0;
UPDATE supplier
SET city = 'Goa'
WHERE Sname = 'Vandana';

DELETE FROM supplier
WHERE city LIKE 'A%';

UPDATE supplier
SET city = 'Bombay';

DELETE FROM supplier;



