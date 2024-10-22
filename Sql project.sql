--Easy Level:- 

-- Q1.Who is the senior most employee based on job title?
	
-- select employee_id,last_name,first_name,title
-- from employee
-- order by levels asc
-- limit 1;


-- Q2.Which countries have the most invoices?

-- select count (*) as c,billing_country 
-- from invoice
-- group by billing_country
-- order by c desc


-- Q3. What are the top 3 values of total invoices?

-- select total from invoice 
-- order by total desc
-- limit 3;



-- Q4.Which city has the best customers? We would like to throw a promotional Music Festival in the city 
-- we made the most money. Write aquery that returns one city that has the highest sum of he invoice totals.
-- Return both the city name & sum of all invoice totals


-- select sum(total) as invoice_total, billing_city
-- from invoice 
-- group by billing_city
-- order by invoice_total desc




-- Q5. Who is the best customer?The customer who has spent the most money will be declared
-- the best customer. Write a query that returns the person who has spent the most money. 

-- select customer.id,customer.first_name, customer.last_name SUM(invoice.total) as total 
-- from customer 
-- join invoice ON customer.customer_id=invoice.customer_id   --here the common column between customer and invoice so that's why we have written "join invoice On customer.id"
-- group by customer.customer_id
-- order by total desc
-- limit 1;


--------------------------------------------------------------------------------------------------------------------------------

-- Medium Level:-


-- Q1. Write query to return the email,first name, last name , & Genre of all Rock Music Listeners.
-- Return your list ordered alphabetically by email starting with A.


-- select Distinct email, first_name , last_name 
-- from customer 
-- Join invoice on customer.customer_id=invoice.customer_id
-- Join invoice_line on invoice_id=invoice_line.invoice_id
-- where track_id In(
-- 	select track_id From track
-- 	join genre on track.genre_id=genre.genre_id  --here we have joint genre table on the basis of the genre id
-- 	where genre.name like 'Rock'
-- )
-- order by email;



--Q2.Let's invite the artists who have written the most rock music in our dataset.Write a query
-- that retruns the Artist name and total track count of the top 10  rock bands.


-- select artist.artist_id,artist.name,COUNT(artist.artist_id)AS number_of_songs
-- from track
-- join ablum ON album.album_id=track.album_id
-- join artist ON artist.artist_id=album.artist_id
-- join genre ON genre.genre_id=track.genre_id
-- where genre.name LIKE 'Rock'
-- Group By artist.artist_id
-- order by number_of_songs Desc
-- limit 10;



-- Q3.Return all the track names that have a song length  longer than the average song length.
-- Return the Name and Milliseconds for each track.Order by the song length with the longest songs listed first. 


-- select name,milliseconds
-- from track
-- where milliseconds >(
--   select AVG(milliseconds) AS avg_track_length
--   from track)
-- order by millisecond desc;




----------------------------------------------------------------------------------------------------------------------------------------------------------


-- Advance Level:- 

-- Q1. Find how much amount spent by each customer on artists?Write a query to return customer
-- name and total spent

-- Ans
-- 	With best_seeling_artist AS(
-- 	SELECT artist.artist_id AS artist_id, artist.name AS artist_name,
-- 	SUM(invoice_line.unit _price*invoice_line.quantity)AS total_sales
-- 	FROM invoice_line
-- 	JOIN track ON track.track_id=invoice_line.track_id
-- 	JOIN album ON album.album_id=track.album_id
-- 	JOIN artist ON artist.artist_id=album.artist_id
-- 	GROUP BY 1
-- 	ORDER BY 3 DESC 
-- 	LIMIT 1
-- )

-- Select c.customer_id,c.first_name,c.last_name,bsa.artist_name,SUM(il.unit_price * il.quantity) AS amount _spent
-- FROM invoice i
-- JOIN customer c ON c.customer_id=i.customer_id
-- JOIN invoice_line il ON il.invoice_id=i.invoice_id
-- JOIN track t ON t.track_id =il.track_id
-- JOIN album alb ON alb.album_id = t.album_id
-- JOIN best_selling_artist bsa ON bsa.artist_id=alb.artist_id
-- GROUP BY 1,2,3,4
-- ORDER BY 5 DESC;




-- Q2.We wan to find out the most popular music Genre for each country.We Determine the most purchases. 
-- Write a query that returns each country along with the top Genre. For Countries where 
-- the maximum number of purchases is shared return all Genres.

-- Ans

-- WITH popular_genre AS
-- (
-- 	SELECT COUNT(invoice_line.quantity) AS purchases,customer.country,genre.name,genre.gnre_id,
-- 	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT (invoice_line.quantity)DESC) AS RowNO
--     FROM invoice_line
-- 	JOIN invoice ON invoice.invoice _id=invoice_line.invoice_id
-- 	JOIN track ON  track.track_id=invoice_line.customer_id
-- 	JOIN genre ON genre.genre_id=track.genre_id
-- 	GROUP BY 2,3,4
-- 	ORDER BY 2 ASC, 1 DESC
-- )
-- SELECT * FROM popular_genre WHERE Row <=1
-- max_genre_per_country AS(SELECT MAX(purchases_per_genere)AS max_genre_number,country)
-- FROM sales_per_country
-- Group By 2
-- Order By 2

-- select sales_per_country.
-- FROM sales_per_country
-- Join max_genre_per_country ON salecs_per_country.country=max_genre_coutry
-- WHERE sale_per_country.because _per_genre=amx_genre_per_country.max_genre_number




-- 	Q3.Write a query that determines the customer tthat has spent the most on music for each country,
-- Write a query thatt returns the country along with the top customer and how they spent.
-- For countries where the top amount spent is shared , provide all customers who spend this amount.


-- Ans

-- WITH RECURSIVE 
-- Customer_with_contry AS(
-- 	Select customer.customer_id,first_name,last_name,billing _country, SUM(total) AS total_spending 
-- 	from invoice 
-- 	join customer ON customer.customer_id=invoice.customer_id
-- 	group by 1,2,3,4
-- 	order by 1,5 Desc),

-- 	country_max_spending AS(
-- 	SELECT billing_country, MAX(total_spending) AS max_spending 
-- 	FROM customer_with_country
-- 	Group By billing _country)
	
-- SELECT cc.billing_country,cc.total_spending,cc.first_name,cc.last_name
-- From customer_with_country cc
-- JOIN country_max_spending ms)
-- ON cc.billing_country =ms.billing_country
-- where cc.total_spending=ms.max_spending 
-- ORDER BY 1;
-- )