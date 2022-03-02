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
Customer_ID varchar(255) PRIMARY KEY,
Name varchar(255),
Phone_number varchar(255),
Email varchar(255),
Address varchar(255),
City varchar(255),
State_Province varchar(255),
ZIP varchar(255)
);
CREATE TABLE Invoices (
Invoice_ID varchar(255) PRIMARY KEY,
Date date,
Car varchar(255),
Customer varchar(255),
Salesperson varchar(255)
);

CREATE TABLE Salespeople (
Staff_ID varchar(255),
Name varchar(255),
Store varchar(255)
);