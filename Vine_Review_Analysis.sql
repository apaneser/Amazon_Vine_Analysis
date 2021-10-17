-- Create Table from imported csv
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

SELECT * FROM vine_table;

-- Create new table where the total votes are greater or equal to 20
CREATE TABLE vine_vote_filter
AS
SELECT * FROM vine_table
WHERE total_votes >= 20;

SELECT * FROM vine_vote_filter;

-- create new table from the previous one
-- where helpful_votes/total-votes are greater than 50%

CREATE TABLE vine_helpful_votes
AS
SELECT * FROM vine_vote_filter
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >= 0.5;

SELECT * FROM vine_helpful_votes;

-- Filter table for rows that were part of the vine program (paid)
CREATE TABLE vine_program
AS
SELECT * FROM vine_helpful_votes
WHERE vine = 'Y';

SELECT * FROM vine_program;

-- filter table for reviews that werent part of the vine program (unpaid)
CREATE TABLE no_vine_program
AS
SELECT * FROM vine_helpful_votes
WHERE vine = 'N';

SELECT * FROM no_vine_program;

-- QUERIES FOR PAID PROGRAM
-- Determine total number of reviews for paid program
SELECT COUNT(*) AS review_num_paid
FROM vine_program;

-- Determine number of 5-star reviews for paid program
SELECT COUNT(*) AS review_num_5_star_paid
FROM vine_program
WHERE star_rating = 5;

-- Determine percentage of five star reviews for paid program
SELECT CAST(COUNT(CASE WHEN star_rating = 5 THEN 1 END) AS FLOAT)/CAST(COUNT(*) AS FLOAT) AS five_star_percentage_paid
FROM vine_program

-- QUERIES FOR UNPAID PROGRAM
-- Determine total number of reviews for unpaid program
SELECT COUNT(*) AS review_num_unpaid
FROM no_vine_program;

-- Determine number of 5-star reviews for unpaid program
SELECT COUNT(*) AS review_num_5_star_unpaid
FROM no_vine_program
WHERE star_rating = 5;

-- Determine percentage of five star reviews for unpaid program
SELECT CAST(COUNT(CASE WHEN star_rating = 5 THEN 1 END) AS FLOAT)/CAST(COUNT(*) AS FLOAT) AS five_star_percentage_unpaid
FROM no_vine_program