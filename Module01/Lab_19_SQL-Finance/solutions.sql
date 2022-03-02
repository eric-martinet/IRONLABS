USE olist;

# 1. From the order_items table, find the price of the highest priced order and lowest price order.
SELECT * from order_items;

SELECT Max(price), Min(Price) FROM order_items;
# Price of the highest priced order = 6,735
# Price of the highest priced order = 0.85

# 2. From the order_items table, what is the range of the shipping_limit_date of the orders?
SELECT Datediff(Max(shipping_limit_date), Min(shipping_limit_date)) FROM order_items;
# The range is 1,299 days: from 2016-09-19 02:15:34 to 2020-04-10 00:35:08

# 3. From the customers table, find the states with the greatest number of customers.
SELECT * from customers;

SELECT customer_state, Count(customer_id) AS NumberOfCustomers from customers
GROUP BY customer_state
ORDER BY NumberOfCustomers DESC;
# The state with the greatest number of customers is SP (Sao Paulo), followed by RJ (Rio de Janeiro) and MG (Minas Gerais).

# 4. From the customers table, within the state with the greatest number of customers, 
# find the cities with the greatest number of customers.
SELECT customer_city, Count(customer_id) AS NumberOfCustomers from customers
WHERE customer_state = "SP"
GROUP BY customer_city
ORDER BY NumberOfCustomers DESC;
# Within the state with the greatest number of customers (Sao Paulo), the cities with the greatest number of customers are
# 1. Sao Paulo, 2. Campinas, 3. Guarulhos

# 5. From the closed_deals table, how many distinct business segments are there (not including null)?
SELECT * from closed_deals;

SELECT Count(DISTINCT business_segment) from closed_deals;
WHERE business_segment IS NOT NULL;
# There are 33 distinct business segments (not including null) in the closed_deals table.

# 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment
# and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
SELECT business_segment, Sum(declared_monthly_revenue) AS MonthlyRevenue from closed_deals
GROUP BY business_segment
ORDER BY MonthlyRevenue DESC
LIMIT 3;
# The 3 business segments with the highest declared monthly revenue are:
# 1. construction_tools_house_garden
# 2. phone_mobile
# 3. home_decor

# 7. From the order_reviews table, find the total number of distinct review score values.
SELECT * FROM order_reviews;

SELECT Count(DISTINCT review_score) FROM order_reviews;
# The total number of distinct review score values is 5.

# 8. In the order_reviews table, create a new column with a description that corresponds
# to each number category for each review score from 1 - 5
# then find the review score and category occurring most frequently in the table.
ALTER TABLE order_reviews
ADD review_category varchar(255);

SELECT * FROM order_reviews;

SET SQL_SAFE_UPDATES = 0;

UPDATE order_reviews
SET review_category = "VERY BAD"
WHERE review_score = 1;

UPDATE order_reviews
SET review_category = "BAD"
WHERE review_score = 2;

UPDATE order_reviews
SET review_category = "AVERAGE"
WHERE review_score = 3;

UPDATE order_reviews
SET review_category = "GOOD"
WHERE review_score = 4;

UPDATE order_reviews
SET review_category = "VERY GOOD"
WHERE review_score = 5;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM order_reviews;

SELECT review_category, review_score, Count(review_id) FROM order_reviews
GROUP BY review_category, review_score
ORDER BY Count(review_id) DESC;

# The review score and category occurring most frequently in the table is
# 5 - VERY GOOD

# 9. From the order_reviews table, find the review value occurring most frequently and how many times it occurs.
SELECT review_score, Count(review_id) FROM order_reviews
GROUP BY review_score
ORDER BY Count(review_id) DESC;
# The review score occurring most frequently is 5 and it occurs 57,420 times.
