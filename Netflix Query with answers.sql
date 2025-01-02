-- Question No: 1. List all users subscribed to the Premium plan:

-- To list all users who are subscribed to the "Premium" plan,
-- you can simply query the Users table with a WHERE clause to filter out users who have the plan set to 'Premium'. 
-- Here's the SQL query for this:

SELECT 
    name AS user_name,
    email
FROM 
    Users
WHERE 
    plan = 'Premium';


-- Question No: 2. Retrieve all movies in the Drama genre with a rating higher than 8.5:

-- To retrieve all movies in the Drama genre with a rating higher than 8.5, 
-- you can query the Movies table and filter the results by both the genre and rating. 
-- Here's the SQL query to do this:


    SELECT title, genre, rating 
FROM Movies 
WHERE genre = 'Drama' AND rating > 8.5;


-- 3. Find the average rating of all movies released after 2015:

-- To find the average rating of all movies released after 2015, 
-- you need to filter the movies based on their release year (greater than 2015) 
-- and then calculate the average of their ratings. 
-- Here's the SQL query for this:

SELECT 
    AVG(rating) AS average_rating
FROM 
    Movies
WHERE 
    release_year > 2015;
    
-- 4. List the names of users who have watched the movie Stranger Things along with their completion percentage:

    -- To list the names of users who have watched the movie Stranger Things along with their completion percentage, 
    -- you need to join the Users, WatchHistory, and Movies tables. 
    -- Here's the SQL query to achieve this:

SELECT 
    U.name AS user_name,
    WH.completion_percentage
FROM 
    Users U
JOIN 
    WatchHistory WH ON U.user_id = WH.user_id
JOIN 
    Movies M ON WH.movie_id = M.movie_id
WHERE 
    M.title = 'Stranger Things';
    
    
  -- 5. Find the name of the user(s) who rated a movie the highest among all reviews:

-- To find the user(s) who rated a movie the highest among all reviews, 
-- you need to first identify the highest rating from the Reviews table, and then retrieve the user(s) who gave that rating. 
-- Here's the SQL query for this:  

SELECT 
    U.name AS user_name,
    R.rating AS highest_rating
FROM 
    Reviews R
JOIN 
    Users U ON R.user_id = U.user_id
WHERE 
    R.rating = (SELECT MAX(rating) FROM Reviews);



-- 6. Calculate the number of movies watched by each user and sort by the highest count:

-- To calculate the number of movies watched by each user and sort the results by the highest count, 
-- you can use the WatchHistory table to count the movies each user has watched. 
-- Here's the SQL query for this:

SELECT 
    U.name AS user_name,
    COUNT(WH.movie_id) AS movies_watched
FROM 
    Users U
JOIN 
    WatchHistory WH ON U.user_id = WH.user_id
GROUP BY 
    U.user_id
ORDER BY 
    movies_watched DESC;
    
    
-- 7.List all movies watched by John Doe, including their genre, rating, and his completion percentage:

-- To list all movies watched by John Doe, including their genre, rating, and his completion percentage, 
-- you need to join the Users, WatchHistory, and Movies tables. 
-- Here's the SQL query to achieve this:

SELECT 
    M.title AS movie_title,
    M.genre,
    M.rating,
    WH.completion_percentage
FROM 
    Users U
JOIN 
    WatchHistory WH ON U.user_id = WH.user_id
JOIN 
    Movies M ON WH.movie_id = M.movie_id
WHERE 
    U.name = 'John Doe';

-- 8.Update the movie's rating for Stranger Things:

-- To update the movie rating for Stranger Things, you can use the UPDATE statement in SQL. 
-- Here's the query to update the rating for this movie:

UPDATE 
    Movies
SET 
    rating = 9.0
WHERE 
    title = 'Stranger Things';


-- Example Output:
-- If the rating for Stranger Things was previously 8.7, after executing the query, 
-- the rating will be updated to 9.0.


-- 9.Remove all reviews for movies with a rating below 4.0:

-- To remove all reviews for movies with a rating below 4.0, 
-- you need to delete rows from the Reviews table where the associated movie has a rating below 4.0. 
-- Here's the SQL query to achieve this:

DELETE FROM 
    Reviews
WHERE 
    movie_id IN (
        SELECT movie_id
        FROM Movies
        WHERE rating < 4.0
    );

-- 10. Fetch all users who have reviewed a movie but have not watched it completely (completion percentage < 100):

-- To fetch all users who have reviewed a movie but have not watched it completely 
-- (i.e., their completion_percentage is less than 100), 
-- you need to join the Users, Reviews, and WatchHistory tables. 
-- Here's the SQL query to achieve this:

SELECT 
    U.name AS user_name,
    U.email,
    M.title AS movie_title,
    WH.completion_percentage
FROM 
    Users U
JOIN 
    Reviews R ON U.user_id = R.user_id
JOIN 
    Movies M ON R.movie_id = M.movie_id
JOIN 
    WatchHistory WH ON U.user_id = WH.user_id AND M.movie_id = WH.movie_id
WHERE 
    WH.completion_percentage < 100;

SELECT U.name, M.title, R.review_text 
FROM Users U
JOIN Reviews R ON U.user_id = R.user_id
JOIN Movies M ON R.movie_id = M.movie_id
LEFT JOIN WatchHistory W ON U.user_id = W.user_id AND M.movie_id = W.movie_id
WHERE (W.completion_percentage IS NULL OR W.completion_percentage < 100);



-- 11. List all movies watched by John Doe along with their genre and his completion percentage:

-- To list all movies watched by John Doe, along with their genre and his completion percentage, 
-- you need to join the Users, WatchHistory, and Movies tables. 
-- Here's the SQL query:

SELECT 
    M.title AS movie_title,
    M.genre,
    WH.completion_percentage
FROM 
    Users U
JOIN 
    WatchHistory WH ON U.user_id = WH.user_id
JOIN 
    Movies M ON WH.movie_id = M.movie_id
WHERE 
    U.name = 'John Doe';

SELECT M.title, M.genre, W.completion_percentage 
FROM Movies M
JOIN WatchHistory W ON M.movie_id = W.movie_id
JOIN Users U ON W.user_id = U.user_id
WHERE U.name = 'John Doe';


-- 12.Retrieve all users who have reviewed the movie Stranger Things, including their review text and rating:

-- To retrieve all users who have reviewed the movie Stranger Things, including their review text and rating, 
-- you need to join the Users, Reviews, and Movies tables.
 -- Here's the SQL query to achieve this:
 
 
 SELECT 
    U.name AS user_name,
    U.email,
    R.review_text,
    R.rating
FROM 
    Users U
JOIN 
    Reviews R ON U.user_id = R.user_id
JOIN 
    Movies M ON R.movie_id = M.movie_id
WHERE 
    M.title = 'Stranger Things';
    
    SELECT U.name, R.review_text, R.rating 
FROM Users U
JOIN Reviews R ON U.user_id = R.user_id
JOIN Movies M ON R.movie_id = M.movie_id
WHERE M.title = 'Stranger Things';


-- 13. Fetch the watch history of all users, including their name, email, movie title, genre, watched date, 
-- and completion percentage:

-- To fetch the watch history of all users, including their name, email, movie title, genre, watched date, and completion percentage, 
-- you can join the Users, WatchHistory, and Movies tables. 
-- Here's the SQL query:

SELECT 
    U.name AS user_name,
    U.email,
    M.title AS movie_title,
    M.genre,
    WH.watched_date,
    WH.completion_percentage
FROM 
    Users U
JOIN 
    WatchHistory WH ON U.user_id = WH.user_id
JOIN 
    Movies M ON WH.movie_id = M.movie_id;

SELECT U.name, U.email, M.title, M.genre, W.watched_date, W.completion_percentage 
FROM Users U
JOIN WatchHistory W ON U.user_id = W.user_id
JOIN Movies M ON W.movie_id = M.movie_id;


-- 14.List all movies along with the total number of reviews and average rating for each movie, 
-- including only movies with at least two reviews:

-- To list all movies along with the total number of reviews and the average rating for each movie, 
-- including only those with at least two reviews, you can use the following SQL query. 
-- This query utilizes the Movies, Reviews, and COUNT, AVG functions, 
-- along with a HAVING clause to filter movies that have at least two reviews:

SELECT 
    M.title AS movie_title,
    COUNT(R.review_id) AS total_reviews,
    AVG(R.rating) AS average_rating
FROM 
    Movies M
JOIN 
    Reviews R ON M.movie_id = R.movie_id
GROUP BY 
    M.movie_id
HAVING 
    COUNT(R.review_id) >= 2;

SELECT M.title, COUNT(R.review_id) AS total_reviews, AVG(R.rating) AS average_rating 
FROM Movies M
JOIN Reviews R ON M.movie_id = R.movie_id
GROUP BY M.movie_id
HAVING COUNT(R.review_id) >= 2;
