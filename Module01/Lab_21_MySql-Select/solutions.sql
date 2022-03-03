# CHALLENGE 1: Who Have Published What At Where?
SELECT auths.au_id AS Author_ID, auths.au_lname AS LastName, auths.au_fname AS FirstName, tits.title AS Title, pubs.pub_name AS Publisher
FROM titleauthor titauth
LEFT JOIN authors auths
ON titauth.au_id = auths.au_id
LEFT JOIN titles tits
ON titauth.title_id = tits.title_id
LEFT JOIN publishers pubs
ON tits.pub_id = pubs.pub_id
ORDER BY Author_ID;
# 25 rows returned, as the number of records in titleauthor


# CHALLENGE 2: Who Have Published How Many At Where?
DROP TABLE IF EXISTS summary_challenge2; 
CREATE TABLE IF NOT EXISTS summary_challenge2
AS (
SELECT auths.au_id AS Author_ID, auths.au_lname AS LastName, auths.au_fname AS FirstName, pubs.pub_name AS Publisher, Count(tits.title) as Title_count
FROM titleauthor titauth
LEFT JOIN authors auths
ON titauth.au_id = auths.au_id
LEFT JOIN titles tits
ON titauth.title_id = tits.title_id
LEFT JOIN publishers pubs
ON tits.pub_id = pubs.pub_id
GROUP BY Author_ID, Publisher
ORDER BY Title_count DESC, Author_ID DESC)
;

SELECT Sum(Title_count) FROM summary_challenge2;

# Other way if we do not want to store the summary table.
SELECT Sum(Title_count) FROM
(
SELECT auths.au_id AS Author_ID, auths.au_lname AS LastName, auths.au_fname AS FirstName, pubs.pub_name AS Publisher, Count(tits.title) as Title_count
FROM titleauthor titauth
LEFT JOIN authors auths
ON titauth.au_id = auths.au_id
LEFT JOIN titles tits
ON titauth.title_id = tits.title_id
LEFT JOIN publishers pubs
ON tits.pub_id = pubs.pub_id
GROUP BY Author_ID, Publisher
ORDER BY Title_count DESC, Author_ID DESC
) 
AS summary; # Derived table must have its own alias.

SELECT Sum(Title_count) FROM summary_challenge2;
# 25 titles, as the number of records in titleauthor

# CHALLENGE 3: Best Selling Authors
SELECT auths.au_id AS Author_ID, auths.au_lname AS LastName, auths.au_fname AS FirstName, Sum(sales.qty) AS Total
FROM titleauthor titauth
LEFT JOIN authors auths
ON titauth.au_id = auths.au_id
LEFT JOIN sales
ON titauth.title_id = sales.title_id
GROUP BY Author_ID
ORDER BY Total DESC
LIMIT 3;

# CHALLENGE 4: Best Selling Authors Ranking
SELECT auths.au_id AS Author_ID, auths.au_lname AS LastName, auths.au_fname AS FirstName, IF(Sum(sales.qty), Sum(sales.qty), 0) AS Total
FROM titleauthor titauth
RIGHT JOIN authors auths
ON titauth.au_id = auths.au_id
LEFT JOIN sales
ON titauth.title_id = sales.title_id
GROUP BY Author_ID
ORDER BY Total DESC;