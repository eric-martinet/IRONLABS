USE lab20;

SET SQL_SAFE_UPDATES = 0;

UPDATE staff
SET Store = "Miami"
WHERE Store = "Mimia";

UPDATE customers
SET Email = "ppicasso@gmail.com"
WHERE Name = "Pablo Picasso";

UPDATE customers
SET Email = "lincoln@us.gov"
WHERE Name = "Abraham Lincoln";

UPDATE customers
SET Email = "hello@napoleon.me"
WHERE Name = "Napoléon Bonaparte";