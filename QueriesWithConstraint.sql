CREATE DATABASE ANGANBADI;
USE ANGANBADI;


CREATE TABLE supplier(
SID INT PRIMARY KEY ,
Sname VARCHAR(50),
branch VARCHAR(50) DEFAULT 'Delhi',
city VARCHAR(50) CHECK (CHAR_LENGTH(city)>2),
phone VARCHAR(15)
);

CREATE TABLE part(
PID INT PRIMARY KEY,
Pname VARCHAR(50) UNIQUE ,
color VARCHAR(50),
PRICE DECIMAL(10,2)
);

CREATE TABLE supplies(
SID INT,
PID INT,
qty INT,
date_supplied DATE,
FOREIGN KEY(SID) REFERENCES supplier(SID)
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



START TRANSACTION;
UPDATE supplier
SET city = 'Mumbai'
WHERE SID = 204001;

COMMIT;
SAVEPOINT sp1;

UPDATE supplier
SET city = 'Banglore'
WHERE SID = 204002;

ROLLBACK TO SAVEPOINT sp1;

SELECT 
MIN(price) AS min_value,
MAX(price) AS max_value,
AVG(price) AS average_value,
SUM(price) AS sum_value
FROM part;

SELECT count(*) FROM part;

SELECT AVG(part.price) AS average_price
FROM supplier 
JOIN supplies ON supplier.SID = supplies.SID
JOIN part ON supplies.PID = part.PID
WHERE supplier.Sname = 'Riya';

SELECT color, SUM(price) AS total_price
FROM part
GROUP BY color;

SELECT branch, COUNT(SID) AS total_suppliers
FROM supplier
GROUP BY branch
HAVING COUNT(SID) > 2;

SELECT *
FROM part
ORDER BY Pname ASC, PRICE DESC;

SELECT branch, COUNT(SID) AS total_suppliers
FROM supplier
GROUP BY branch;

SELECT *
FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 4;

SELECT
department,
COUNT(*) AS total_employees,
SUM(CASE WHEN salary > 80000 THEN 1 ELSE 0 END) AS high_earning_employees,
SUM(CASE WHEN salary > 80000 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS percentage_above_80000
FROM employee
GROUP BY department
ORDER BY high_earning_employees DESC
LIMIT 1;


WITH RECURSIVE department_hierarchy AS (
SELECT
department_id,
department_name,
parent_department_id,
1 AS level
FROM department
WHERE parent_department_id IS NULL
UNION ALL
SELECT
d.department_id,
d.department_name,
d.parent_department_id,
dh.level + 1
FROM department d
JOIN department_hierarchy dh
ON d.parent_department_id = dh.department_id
),
top_departments AS (
SELECT
department_id,
AVG(salary) AS average_salary
FROM employee
GROUP BY department_id
ORDER BY average_salary DESC
LIMIT 2
)
SELECT
td.department_id,
dh.department_name,
td.average_salary,
dh.parent_department_id,
dh.level
FROM top_departments td
JOIN department_hierarchy dh
ON td.department_id = dh.department_id
ORDER BY td.average_salary DESC;



WITH RECURSIVE department_hierarchy AS (
SELECT department_id, department_name, parent_department_id, 1 AS level
FROM department
WHERE parent_department_id IS NULL
UNION ALL
SELECT d.department_id, d.department_name, d.parent_department_id, dh.level + 1
FROM department d
JOIN department_hierarchy dh ON d.parent_department_id = dh.department_id
),
top_departments AS (
SELECT department_id, AVG(salary) AS average_salary
FROM employee
GROUP BY department_id
ORDER BY average_salary DESC
LIMIT 2
)
SELECT td.department_id, dh.department_name, td.average_salary, dh.parent_department_id, dh.level
FROM top_departments td
JOIN department_hierarchy dh ON td.department_id = dh.department_id
ORDER BY td.average_salary DESC;


WITH RECURSIVE employee_hierarchy AS (
SELECT id, parentid, name, 1 AS level, CAST(LPAD(id, 10, '0') AS CHAR(1000)) AS path
FROM employee
WHERE parentid IS NULL
UNION ALL
SELECT e.id, e.parentid, e.name, eh.level + 1, CONCAT(eh.path, '/', LPAD(e.id, 10, '0'))
FROM employee e
JOIN employee_hierarchy eh ON e.parentid = eh.id
)
SELECT id, parentid, name, level, path
FROM employee_hierarchy
ORDER BY level, path;

WITH RECURSIVE employee_hierarchy AS (
SELECT id, parentid, name, 1 AS level, id AS root_id, CAST(name AS CHAR(1000)) AS path
FROM employee
WHERE parentid IS NULL
UNION ALL
SELECT e.id, e.parentid, e.name, eh.level + 1, eh.root_id, CONCAT(eh.path, ' -> ', e.name)
FROM employee e
JOIN employee_hierarchy eh ON e.parentid = eh.id
)
SELECT id, parentid, name, level, root_id, path
FROM employee_hierarchy
ORDER BY path;