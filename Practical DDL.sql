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
date_supplied DATE,
FOREIGN KEY(SID) REFERENCES supplier(SID),
FOREIGN KEY(PID) REFERENCES part(PID)
);

ALTER TABLE supplier
ADD COLUMN email VARCHAR(50);

ALTER TABLE supplier
DROP city;

ALTER TABLE supplier
MODIFY phone VARCHAR(15);

ALTER TABLE supplier
RENAME COLUMN city TO address;

RENAME TABLE supplier TO sup;

TRUNCATE table supplies;

DROP table part;
