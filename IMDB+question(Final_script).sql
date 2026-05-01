USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:
SELECT * FROM genre;
SELECT * FROM movie;
SELECT * FROM names;
SELECT * FROM ratings;
SELECT * FROM role_mapping;




-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

SELECT COUNT(*) AS Num_of_rows_director_mapping
FROM director_mapping;
-- Total number of rows in director_mapping table are 3872.

SELECT COUNT(*) AS Num_of_rows_genre
FROM genre;
-- Total number of rows in genre table are 14662.

SELECT COUNT(*) AS Num_of_rows_movie
FROM movie;
-- Total number of rows in movie table are 7997.

SELECT COUNT(*) AS Num_of_rows_names
FROM names;
-- Total number of rows in names table are 25735.

SELECT COUNT(*) AS Num_of_rows_ratings
FROM ratings;
-- Total number of rows in ratings table are 7997.

SELECT COUNT(*) AS Num_of_role_mapping
FROM role_mapping;
-- Total number of rows in role_mapping table are 15615.



-- Q2. Which columns in the movie table have null values?
-- Type your code below:

SELECT * 
FROM  movie;


SELECT Sum(CASE
             WHEN id IS NULL THEN 1
             ELSE 0
           end) AS id_null_count,
       Sum(CASE
             WHEN title IS NULL THEN 1
             ELSE 0
           end) AS title_null_count,
       Sum(CASE
             WHEN year IS NULL THEN 1
             ELSE 0
           end) AS year_null_count,
       Sum(CASE
             WHEN date_published IS NULL THEN 1
             ELSE 0
           end) AS date_published_null_count,
       Sum(CASE
             WHEN duration IS NULL THEN 1
             ELSE 0
           end) AS duration_null_count,
       Sum(CASE
             WHEN country IS NULL THEN 1
             ELSE 0
           end) AS country_null_count,
       Sum(CASE
             WHEN worlwide_gross_income IS NULL THEN 1
             ELSE 0
           end) AS worlwide_gross_income_null_count,
       Sum(CASE
             WHEN languages IS NULL THEN 1
             ELSE 0
           end) AS languages_null_count,
       Sum(CASE
             WHEN production_company IS NULL THEN 1
             ELSE 0
           end) AS production_company_null_count
FROM   movie; 

/* The movie table has 'Four' columns with null values , they are , Country ,
    Worldwide_gross_income , Languages , Production_company with count of 
    20 , 3724 , 194 , 528 respectively. */
    



-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT year, 
		COUNT(id) as number_of_movies 
FROM movie 
GROUP BY year;

/* Year 2017 has 3052 number of movies,
	Year 2018 has 2944 number of movies,
    Year 2019 has 2001 number of movies. */

SELECT Month(date_published) AS month_num,
       Count(id)             AS number_of_movies
FROM   movie
GROUP  BY month_num
ORDER  BY month_num;

-- March month has highest number of movies with count of 824.



/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

SELECT Count(id) AS Total_Movie_Count
FROM   movie
WHERE  year = '2019'
       AND ( country LIKE '%USA%'
              OR country LIKE '%India%' );

-- 1059 movies were produced in the USA or India in the year 2019.







/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

SELECT DISTINCT( genre ) AS Unique_genres
FROM   genre;

/* The unique list of the genres conatins 13 distinct 
	geners in the data set, they are, 
	Drama,Fantasy,Thriller,Comedy,Horror,Family,Romance,
    Adventure,Action,Sci-Fi,Crime,Mystery,Others.    */
    
    







/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

SELECT     genre,
           Count(m.id) AS number_of_movies
FROM       movie       AS m
INNER JOIN genre       AS g
where      g.movie_id = m.id
GROUP BY   genre
ORDER BY   number_of_movies DESC
LIMIT      1;

/*  To find highest number of movies based on genre , we join the tables movie and genre and order them in descending 
and apply limit 1 to get the highest . Based on above query we get , 'Drama' genre has highest number of movies 
with count of 4285. */








/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

WITH movies_with_one_genre
     AS (SELECT movie_id
         FROM   genre
         GROUP  BY movie_id
         HAVING Count(DISTINCT genre) = 1)
SELECT Count(*) AS movies_with_one_genre
FROM   movies_with_one_genre; 

/* Here we use CTEs .The entire query counts the number of movies in the genre table 
that are associated with exactly one unique genre. The result is a single number
 representing how many such movies exist in the dataset. 
 Therefore , there are 3289 number of movies which has unique genre. */







/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT g.genre,
       Round(Avg(m.duration), 2) AS avg_duration
FROM   genre AS g
       INNER JOIN movie AS m
               ON g.movie_id = m.id
GROUP  BY g.genre; 

/* The above query finds the average movie duration for each genre and rounds it to two decimal places.
    Hence Drama genre has highest avg_duration of 106.77 minutes. */












/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

WITH thriller_genre_rank
     AS (SELECT genre,
                Count(movie_id),
                Rank()
                  OVER(
                    ORDER BY Count(movie_id) DESC) genre_rank
         FROM   genre
         GROUP  BY genre)
SELECT *
FROM   thriller_genre_rank
WHERE  genre = "thriller"; 

-- Thriller has rank=3 with movie count of 1484.







/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

SELECT Min(avg_rating)    AS min_avg_rating,
       Max(avg_rating)    AS max_avg_rating,
       Min(total_votes)   AS min_total_votes,
       Max(total_votes)   AS max_total_votes,
       Min(median_rating) AS min_median_rating,
       Max(median_rating) AS max_median_rating
FROM   ratings; 



    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

SELECT     title ,
           avg_rating,
           Dense_rank() over(ORDER BY avg_rating DESC) AS movie_rank
FROM       movie                                       AS m
INNER JOIN ratings                                     AS r
ON         m.id=r.movie_id
LIMIT      10;

-- The above query can also be solved using CTEs, as shown below:

WITH movie_rank
     AS (SELECT title,
                avg_rating,
                Row_number()
                  OVER(
                    ORDER BY avg_rating DESC) AS movie_rank
         FROM   ratings AS r
                INNER JOIN movie AS m
                        ON m.id = r.movie_id)
SELECT *
FROM   movie_rank
WHERE  movie_rank <= 10; 

-- Top 3 movies have average rating >= 9.8


/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

SELECT median_rating,
       Count(movie_id) AS movie_count
FROM   ratings
GROUP  BY median_rating
ORDER  BY movie_count DESC; 		



/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:

WITH production_company_hit_movie_summary
     AS (SELECT production_company,
                Count(movie_id)                     AS MOVIE_COUNT,
                Rank()
                  OVER(
                    ORDER BY Count(movie_id) DESC ) AS PROD_COMPANY_RANK
         FROM   ratings AS R
                INNER JOIN movie AS M
                        ON M.id = R.movie_id
         WHERE  avg_rating > 8
                AND production_company IS NOT NULL
         GROUP  BY production_company)
SELECT *
FROM   production_company_hit_movie_summary
WHERE  prod_company_rank = 1; 

/* Dream Warrior Pictures and National Theatre Live production houses has produced the most number of hit movies with 
    average rating > 8 and they have rank=1 with movie count =3. */

-- The above query can also be solved without using CTEs , as shown below:

SELECT production_company,
       Count(id)                    AS no_of_movies,
       Dense_rank()
         OVER(
           ORDER BY Count(id) DESC) prod_company_rank
FROM   movie m
       INNER JOIN ratings r
               ON m.id = r.movie_id
WHERE  r.avg_rating > 8
       AND m.production_company IS NOT NULL
GROUP  BY m.production_company; 




-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Here we need to find the following, 
-- 1. Number of movies released in each genre 
-- 2. During March 2017 
-- 3. In the USA  (LIKE operator is used for pattern matching)
-- 4. Movies had more than 1,000 votes
-- To solve these we need to join three tables,i.e, genre,movie and ratings.

SELECT genre,
       Count(M.id) AS MOVIE_COUNT
FROM   movie AS M
       INNER JOIN genre AS G
               ON G.movie_id = M.id
       INNER JOIN ratings AS R
               ON R.movie_id = M.id
WHERE  year = 2017
       AND Month(date_published) = 3
       AND country LIKE '%USA%'
       AND total_votes > 1000
GROUP  BY genre
ORDER  BY movie_count DESC; 

/* 24 Drama movies were released during March 2017 in the USA and had more than 1,000 votes.
   Top 3 genres are Drama, Comedy and Action during March 2017 in the USA and had more than 1,000 votes. */






-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:


-- Query to find:
-- 1. Number of movies of each genre that start with the word ‘The’ (LIKE operator is used for pattern matching)
-- 2. Which have an average rating > 8?
-- Grouping by title to fetch distinct movie titles as movie belog to more than one genre


SELECT m.title,
       r.avg_rating,
       g.genre
FROM   movie m
       INNER JOIN ratings r
               ON m.id = r.movie_id
       INNER JOIN genre g
               ON m.id = g.movie_id
WHERE  m.title LIKE 'The%'
       AND r.avg_rating > 8
ORDER  BY r.avg_rating DESC; 



-- There are 8 movies which begin with "The" in their title.
-- The Brighton Miracle has highest average rating of 9.5.
-- All the movies belong to the top 3 genres.








-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

-- BETWEEN operator is used to find the movies released between 1 April 2018 and 1 April 2019.

SELECT median_rating,
       Count(*) AS movie_count
FROM   movie AS M
       INNER JOIN ratings AS R
               ON R.movie_id = M.id
WHERE  median_rating = 8
       AND date_published BETWEEN '2018-04-01' AND '2019-04-01'
GROUP  BY median_rating;


-- 361 movies have released between 1 April 2018 and 1 April 2019 with a median rating of 8.







-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

WITH german_movie_vote
     AS (SELECT Sum(total_votes) AS German_movie_total_votes
         FROM   ratings r
                INNER JOIN movie m
                        ON r.movie_id = m.id
         WHERE  languages LIKE '%german%'),
     italian_movie_vote
     AS (SELECT Sum(total_votes) AS Italian_movie_total_votes
         FROM   ratings r
                INNER JOIN movie m
                        ON r.movie_id = m.id
         WHERE  languages LIKE '%italian%')
SELECT *
FROM   german_movie_vote,
       italian_movie_vote; 

-- German movies has the highest votes with a count of 4421525. 


-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT Sum(CASE
             WHEN name IS NULL THEN 1
             ELSE 0
           end) AS name_nulls,
       Sum(CASE
             WHEN height IS NULL THEN 1
             ELSE 0
           end) AS height_nulls,
       Sum(CASE
             WHEN date_of_birth IS NULL THEN 1
             ELSE 0
           end) AS date_of_birth_nulls,
       Sum(CASE
             WHEN known_for_movies IS NULL THEN 1
             ELSE 0
           end) AS known_for_movies_nulls
FROM   names; 

/* There are no null values in name column , whereas height column has 17335 null values,
date of birt column has 13431 null values, known for movies column has 15226 null values. */




/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

WITH top_3_genres
AS
  (
             SELECT     genre,
                        count(m.id)                            AS movie_count ,
                        rank() over(ORDER BY count(m.id) DESC) AS genre_rank
             FROM       movie                                  AS m
             INNER JOIN genre                                  AS g
             ON         g.movie_id = m.id
             INNER JOIN ratings AS r
             ON         r.movie_id = m.id
             WHERE      avg_rating > 8
             GROUP BY   genre
             LIMIT      3 )
  SELECT     n.name            AS director_name ,
             count(d.movie_id) AS movie_count
  FROM       director_mapping  AS d
  INNER JOIN genre g
  USING      (movie_id)
  INNER JOIN names AS n
  ON         n.id = d.name_id
  INNER JOIN top_3_genres
  USING      (genre)
  INNER JOIN ratings
  USING      (movie_id)
  WHERE      avg_rating > 8
  GROUP BY   name
  ORDER BY   movie_count DESC
  LIMIT      3 ;
  
  
-- James Mangold ,  Anthony Russo and Soubin Shahir are top three directors 
-- in the top three genres whose movies have an average rating > 8. 




/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT N.name          AS actor_name,
       Count(movie_id) AS movie_count
FROM   role_mapping AS RM
       INNER JOIN movie AS M
               ON M.id = RM.movie_id
       INNER JOIN ratings AS R USING (movie_id)
       INNER JOIN names AS N
               ON N.id = RM.name_id
WHERE  R.median_rating >= 8
       AND category = 'ACTOR'
GROUP  BY actor_name
ORDER  BY movie_count DESC
LIMIT  2; 

-- Mammootty and Mohanlal are the top two actors with movie count of 8 and 5 respectively.




/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:


SELECT     production_company,
           Sum(total_votes)                            AS vote_count,
           Rank() over(ORDER BY sum(total_votes) DESC) AS prod_comp_rank
FROM       movie                                       AS m
INNER JOIN ratings                                     AS r
ON         r.movie_id = m.id
GROUP BY   production_company
LIMIT      3;

/* Top three production house are Marvel Studios, Twentieth Century Fox, Warner Bros.
    With vote counts of 2656967 , 2411163 , 2396057 respectively.





/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, 
--  then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH rank_actors
     AS (SELECT NAME                                                       AS
                actor_name
                ,
                Sum(total_votes)
                AS
                   total_votes,
                Count(a.movie_id)                                          AS
                   movie_count,
                Round(Sum(avg_rating * total_votes) / Sum(total_votes), 2) AS
                   actor_avg_rating
         FROM   role_mapping a
                INNER JOIN names b
                        ON a.name_id = b.id
                INNER JOIN ratings c
                        ON a.movie_id = c.movie_id
                INNER JOIN movie d
                        ON a.movie_id = d.id
         WHERE  category = 'actor'
                AND country LIKE '%India%'
         GROUP  BY name_id,
                   NAME
         HAVING Count(DISTINCT a.movie_id) >= 5)
SELECT *,
       Dense_rank()
         OVER (
           ORDER BY actor_avg_rating DESC) AS actor_rank
FROM   rank_actors; 


-- Top actor is Vijay Sethupathi followed by Fahadh Faasil and Yogi Babu.





-- Top actor is Vijay Sethupathi


-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, 
-- then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT     name                                                                               AS actor_name,
           Sum(total_votes)                                                                   AS total_votes,
           Count(m.id)                                                                        AS movie_count,
           Round(Sum(avg_rating * total_votes)/Sum(total_votes),2)                            AS actress_avg_rating,
           Rank() over(ORDER BY round(sum(avg_rating * total_votes)/sum(total_votes),2) DESC) AS actress_rank
FROM       movie                                                                              AS m
INNER JOIN ratings                                                                            AS r
ON         m.id = r.movie_id
INNER JOIN role_mapping AS rm
ON         m.id=rm.movie_id
INNER JOIN names AS nm
ON         rm.name_id=nm.id
WHERE      category='actress'
AND        country='india'
AND        languages LIKE '%hindi%'
GROUP BY   name
HAVING     movie_count>=3
LIMIT      5;


-- Top five actresses in Hindi movies released in India based on their average ratings are 
-- Taapsee Pannu, Kriti Sanon, Divya Dutta, Shraddha Kapoor, Kriti Kharbanda.










/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

-- Using CASE statements to classify thriller movies as per avg rating 

WITH thriller_movies
     AS (SELECT DISTINCT title,
                         avg_rating
         FROM   movie AS M
                INNER JOIN ratings AS R
                        ON R.movie_id = M.id
                INNER JOIN genre AS G using(movie_id)
         WHERE  genre LIKE 'THRILLER')
SELECT *,
       CASE
         WHEN avg_rating > 8 THEN 'Superhit movies'
         WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit movies'
         WHEN avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch movies'
         ELSE 'Flop movies'
       END AS avg_rating_category
FROM   thriller_movies; 










/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 

/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT genre,
       Round(Avg(duration), 2)                      AS avg_duration,
       SUM(Round(Avg(duration), 2))
         over(
           ORDER BY genre ROWS unbounded preceding) AS running_total_duration,
       Avg(Round(Avg(duration), 2))
         over(
           ORDER BY genre ROWS 10 preceding)        AS moving_avg_duration
FROM   movie AS m
       inner join genre AS g
               ON m.id = g.movie_id
GROUP  BY genre
ORDER  BY genre; 







-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies


-- 1) creating a CTE for top 3 genres based on count of movies in each genre:
WITH top_genre
AS
  (
             SELECT     g.genre,
                        count(g.movie_id) AS genre_mv_count
             FROM       genre             AS g
             INNER JOIN ratings           AS r
             ON         r.movie_id = g.movie_id
             GROUP BY   g.genre
             ORDER BY   genre_mv_count DESC
             LIMIT      3),
  -- 2) creating another CTE using first CTE to create a table for genre, year, movie_name , worlwide_gross_income & its converted numerical value(WGI):
  -- Conversion factor for INR to USD is taken as 1 USD = 80 INR
  income_list
AS
  (
             SELECT     g.genre,
                        year,
                        title AS movie_name,
                        worlwide_gross_income,
                        CONVERT(
                        CASE
                                   WHEN worlwide_gross_income LIKE 'INR%' THEN substr(worlwide_gross_income, 4)*0.0125
                                   WHEN worlwide_gross_income LIKE '$%' THEN substr(worlwide_gross_income, 2)
                        end, FLOAT) AS wgi
             FROM       movie m
             INNER JOIN genre g
             ON         g.movie_id = m.id
             WHERE      g. genre IN
                        (
                               SELECT genre
                               FROM   top_genre)
             ORDER BY   wgi DESC),
  -- 3) creating 3rd CTE for ranking the movies based on the converted value of gross income, with a partition over year:
  rank_list
AS
  (
           SELECT   *,
                    row_number() over (partition BY year ORDER BY wgi DESC) AS movie_rank
           FROM     income_list)
  -- Creating final list as per question :
  SELECT genre,
         year,
         movie_name,
         worlwide_gross_income,
         movie_rank
  FROM   rank_list
  WHERE  movie_rank<=5
  order by year;


-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

WITH production_company_summary
AS
  (
             SELECT     production_company,
                        count(*) AS movie_count
             FROM       movie    AS m
             INNER JOIN ratings  AS r
             ON         r.movie_id = m.id
             WHERE      median_rating >= 8
             AND        production_company IS NOT NULL
             AND        position(',' IN languages) > 0
             GROUP BY   production_company
             ORDER BY   movie_count DESC)
  SELECT   *,
           rank() over( ORDER BY movie_count DESC) AS prod_comp_rank
  FROM     production_company_summary
  LIMIT    2;


-- Star Cinema and Twentieth Century Fox are the top two production houses that 
-- have produced the highest number of hits among multilingual movies with a movie count of 7 and 4 respectively.




-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 actresses based on number of Super Hit movies


WITH actress_summary
AS
  (
             SELECT     n.name                                                AS actress_name,
                        sum(total_votes)                                      AS total_votes,
                        count(r.movie_id)                                     AS movie_count,
                        round(sum(avg_rating*total_votes)/sum(total_votes),2) AS actress_avg_rating
             FROM       movie                                                 AS m
             INNER JOIN ratings                                               AS r
             ON         m.id=r.movie_id
             INNER JOIN role_mapping AS rm
             ON         m.id = rm.movie_id
             INNER JOIN names AS n
             ON         rm.name_id = n.id
             INNER JOIN genre AS g
             ON         g.movie_id = m.id
             WHERE      category = 'ACTRESS'
             AND        avg_rating>8
             AND        genre = "Drama"
             GROUP BY   name )
  SELECT   *,
           rank() over(ORDER BY movie_count DESC) AS actress_rank
  FROM     actress_summary
  LIMIT    3;

-- Top 3 actresses based on number of Super Hit movies are Parvathy Thiruvothu, Susan Brown and Amanda Lawrence





/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:


WITH next_date_published_summary
AS
  (
             SELECT     d.name_id,
                        name,
                        d.movie_id,
                        duration,
                        r.avg_rating,
                        total_votes,
                        m.date_published,
                        lead(date_published,1) over(partition BY d.name_id ORDER BY date_published,movie_id ) AS next_date_published
             FROM       director_mapping                                                                      AS d
             INNER JOIN names                                                                                 AS n
             ON         n.id = d.name_id
             INNER JOIN movie AS m
             ON         m.id = d.movie_id
             INNER JOIN ratings AS r
             ON         r.movie_id = m.id ), top_director_summary
AS
  (
         SELECT *,
                datediff(next_date_published, date_published) AS date_difference
         FROM   next_date_published_summary )
  SELECT   name_id                       AS director_id,
           name                          AS director_name,
           count(movie_id)               AS number_of_movies,
           round(avg(date_difference),2) AS avg_inter_movie_days,
           round(avg(avg_rating),2)      AS avg_rating,
           sum(total_votes)              AS total_votes,
           min(avg_rating)               AS min_rating,
           max(avg_rating)               AS max_rating,
           sum(duration)                 AS total_duration
  FROM     top_director_summary
  GROUP BY director_id
  ORDER BY count(movie_id) DESC
  LIMIT    9;




/*  THANK YOU , 
	CASE STUDY DONE BY- RAYEES DAANISH SYED */

