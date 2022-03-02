CREATE DATABASE lab20;

USE lab20;

CREATE TABLE Cars (
VIN varchar(255) PRIMARY KEY,
Manufacturer varchar(255),
Model varchar(255),
Year int,
Colour varchar(255)
);

CREATE TABLE Customers (
id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
Customer_ref varchar(255),
Name varchar(255),
Phone_number varchar(255),
Email varchar(255),
Address varchar(255),
City varchar(255),
ZIP varchar(255),
State_Province varchar(255),
Country varchar(255)
);

CREATE TABLE Invoices (
id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
Invoice_ref varchar(255),
Date date,
Car varchar(255),
Customer varchar(255),
Salesperson varchar(255)
);

CREATE TABLE Staff (
Staff_ID varchar(255),
Name varchar(255),
Store varchar(255)
);