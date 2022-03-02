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
# Let's look, by genre, if people tend to give a better rating to free or paid apps.
# Let's  firt look at the average rating for free apps.
SELECT prime_genre, AVG(user_rating) as RatingAverageFreeApps FROM applestore
WHERE price  = 0
GROUP BY prime_genre
ORDER BY prime_genre;

# Let's now look at the average rating for paying apps.
SELECT prime_genre, AVG(user_rating) as RatingAveragePayingApps FROM applestore
WHERE price  > 0
GROUP BY prime_genre
ORDER BY prime_genre;