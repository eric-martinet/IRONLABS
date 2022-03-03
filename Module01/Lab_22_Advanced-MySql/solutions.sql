# Most Profiting Authors
# Step-by-step using temporary tables

####### STEP 1: ROYALTIES #######
# Royalties by author by title
drop temporary table if exists roy_per_au_per_tit;

CREATE TEMPORARY TABLE IF NOT EXISTS roy_per_au_per_tit
SELECT authors.au_id, titles.title_id, Sum(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN sales
ON titleauthor.title_id = sales.title_id
GROUP BY au_id, title_id;

select * from roy_per_au_per_tit;


# Royalties by author
drop temporary table if exists roy_per_au;

CREATE TEMPORARY TABLE IF NOT EXISTS roy_per_au
SELECT au_id, Sum(sales_royalty) AS royalties FROM roy_per_au_per_tit
GROUP BY au_id;

select * from roy_per_au;

# Total royalties = 777
select sum(royalties) from roy_per_au;

####### STEP 2: ADVANCES #######
# Advance by author by title
drop temporary table if exists adv_per_au_per_tit;

CREATE TEMPORARY TABLE IF NOT EXISTS adv_per_au_per_tit
SELECT authors.au_id, titles.title_id, titles.advance * titleauthor.royaltyper / 100 AS advance
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id;

select * from adv_per_au_per_tit;


# Advances by author
drop temporary table if exists adv_per_au;

CREATE TEMPORARY TABLE adv_per_au
SELECT au_id, Sum(advance) AS advances FROM adv_per_au_per_tit
GROUP BY au_id;

select * from adv_per_au;

# Total advances = 95,400
select sum(advances) from adv_per_au;

####### STEP 3: SALES #######
# Sales by author by title (using royalty share as allocation key)
drop temporary table if exists sales_per_au_per_tit;

CREATE TEMPORARY TABLE IF NOT EXISTS sales_per_au_per_tit
SELECT authors.au_id, titles.title_id, Sum(titles.price * sales.qty * titleauthor.royaltyper / 100) AS title_sales
FROM titleauthor
LEFT JOIN titles
ON titleauthor.title_id = titles.title_id
LEFT JOIN authors
ON titleauthor.au_id = authors.au_id
LEFT JOIN sales
ON titleauthor.title_id = sales.title_id
GROUP BY au_id, title_id;

select * from sales_per_au_per_tit;


# Sales by author
drop temporary table sales_per_au;

CREATE TEMPORARY TABLE sales_per_au
SELECT au_id, Sum(title_sales) as sales FROM sales_per_au_per_tit
GROUP BY au_id;

select * from sales_per_au;

# Total sales = 6,677
select sum(sales) from sales_per_au;

####### STEP 4: PROFITS #######
# Sales, advances, royalties and profits by author
SELECT sales_per_au.au_id, sales, advances, royalties, sales - advances - royalties AS profits
FROM sales_per_au
LEFT JOIN adv_per_au
ON sales_per_au.au_id = adv_per_au.au_id
LEFT JOIN roy_per_au
ON sales_per_au.au_id = roy_per_au.au_id
ORDER BY profits DESC
LIMIT 3
;