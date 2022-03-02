USE lab20;

INSERT INTO Cars
VALUES 
("3K096I98581DHSNUP", "Volkswagen", "Tiguan", 2019, "Blue"),
("ZM8G7BEUQZ97IH46V", "Peugeot", "Rifter", 2019, "Red"),
("RKXVNNIHLVVZOUB4M", "Ford", "Fusion", 2018, "White"),
("HKNDGS7CU31E9Z7JW", "Toyota", "RAV4", 2018, "Silver"),
("DAM41UDN3CHU2WVF6", "Volvo", "V60", 2019, "Gray");

INSERT INTO Customers (Customer_ref, Name, Phone_number, Email, Address, City, ZIP, State_Province, Country)
VALUES 
(10001, "Pablo Picasso", "+34 636 17 63 82", "", "Paseo de la Chopera, 14", "Madrid", 28045, "Madrid", "Spain"),
(20001, "Abraham Lincoln", "+1 305 907 7086", "", "120 SW 8th St", "Miami", 33130, "Florida", "USA"),
(30001, "Napoléon Bonaparte", "+33 1 79 75 40 00", "", "40 Rue du Colisée", "Paris", 75008, "Île-de-France", "France"),
# duplicate on purpose for exercise delete.sql
(30001, "Napoléon Bonaparte", "+33 1 79 75 40 00", "", "40 Rue du Colisée", "Paris", 75008, "Île-de-France", "France");

INSERT INTO Staff
VALUES
(00001, "Petey Cruiser", "Madrid"),
(00002, "Anna Sthesia", "Barcelona"),
(00003, "Paul Molive", "Berlin"),
(00004, "Gail Forcewind", "Paris"),
(00005, "Paige Turner", "Mimia"), # typo on purpose for exercise update.sql
(00006, "Bob Frapples", "Mexico City"),
(00007, "Walter Melon", "Amsterdam"),
(00008, "Shonda Leer", "São Paulo");

INSERT INTO Invoices (Invoice_ref, Date, Car, Customer, Salesperson)
VALUES
(852399038, "2018-08-22", "3K096I98581DHSNUP", 10001, 00002),
(731166526, "2018-12-31", "RKXVNNIHLVVZOUB4M", 30001, 00006),
(271135104, "2019-01-22", "3K096I98581DHSNUP", 20001, 00005);


