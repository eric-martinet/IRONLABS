USE applestore_database;

SELECT * FROM applestore;

# 1. What are the different genres?
SELECT DISTINCT prime_genre FROM applestore
ORDER BY prime_genre;

# 2. Which is the genre with the most apps rated?
SELECT prime_genre, Count(id) as CountAppsRated from applestore
WHERE rating_count_tot > 0
GROUP BY prime_genre
ORDER BY CountAppsRated DESC
LIMIT 1;

# 3. Which is the genre with the most apps?
SELECT prime_genre, Count(id) as CountApps from applestore
GROUP BY prime_genre
ORDER BY CountApps DESC
LIMIT 1;

# 4. Which is the one with least?
SELECT prime_genre, Count(id) as CountApps from applestore
GROUP BY prime_genre
ORDER BY CountApps ASC
LIMIT 1;

# 5. Find the top 10 apps most rated.
SELECT prime_genre, track_name, rating_count_tot from applestore
ORDER BY rating_count_tot DESC
LIMIT 10;

# 6. Find the top 10 apps best rated by users.
SELECT prime_genre, track_name, user_rating from applestore
ORDER BY user_rating DESC
LIMIT 10;

# 10. How could you take the top 3 regarding both user ratings and number of votes?
SELECT prime_genre, track_name, user_rating, rating_count_tot from applestore
ORDER BY user_rating DESC, rating_count_tot DESC
LIMIT 3;

# 11. Do people care about the price of an app?
# Let's look if people tend to give a better rating to free or paid apps.

# Let's  first look at the average rating for free apps.
SELECT AVG(user_rating), Sum(rating_count_tot) as RatingAverageFreeApps FROM applestore
WHERE price  = 0;
#3.83 with 23,045,350 reviews

# Let's now look at the average rating for paying apps.
SELECT AVG(user_rating), Sum(rating_count_tot) as RatingAveragePayingApps FROM applestore
WHERE price  <> 0;
#4.04 with 4,311,926 reviews

# Conclusion: users are generally more satisfied with paid apps than free apps.

# But are users satisfied with the most expensive apps? Let's see the price ranges and average ratings.
SELECT price, AVG(user_rating) FROM applestore
GROUP BY price
ORDER BY price DESC;

# Let's define three groups: paying app with price below $5, between $5 and $10, above $10
# and let's look at the average rating.
# Let's not forget about the number of ratings to make sure it is significant.

SELECT AVG(user_rating), Sum(rating_count_tot) as RatingAveragePayingApps FROM applestore
WHERE price  < 5 AND price > 0;
# 4.05 with 3,876,088 reviews

SELECT AVG(user_rating), Sum(rating_count_tot)as RatingAveragePayingApps FROM applestore
WHERE price  < 10 AND price >= 5;
# 3.95 with 429,202 reviews

SELECT AVG(user_rating), Sum(rating_count_tot) as RatingAveragePayingApps FROM applestore
WHERE price  >= 10;
# 3.92 with 6,636 reviews
# Not that significant.

# As price goes up, users tend to be slightly less happy with the app, but still remain happier than with a free app.

