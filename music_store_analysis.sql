-- Music Store SQL Analysis Project

-- Q1: Who is the senior most employee based on job title?
SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1;

-- Q2: Which Countries have the most invoices ?
select COUNT(*) as c, billing_country
from invoice
group by billing_country
order by c desc

-- Q3: What are top 3 Values of total invoice ?
select total from invoice
order by total desc 
limit 3

-- Q4: Which city has the best customers? We would like to throw a promotional Festival 
--in the city, we made the most money. Write a query that returns one city that has 
--the highest sum of invoice totals. Return both the city name and sum of all invoice
--totals. 
select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc
limit 1

-- Q5: Who is the best customer? The customer who has spent the most money. Will be 
--declared the best customer. Write a query that returns the person who has spent 
--the most money.

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

--Q6: Write query to return the email, first name, last name and Genre of all rock music 
--listeners. Return your list order albhabetically by email starting with A.

select distinct customer.first_name, customer.last_name, customer.email
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
where genre.name = 'Rock'
order by customer.email;

--Q7: Lets invite the artists who have written the most rock music in our dataset.
--Write a query that returns the artist name and total track count of the top 10 
--rock bands.

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track 
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
group by artist.artist_id
order by number_of_songs 
limit 10

--Q8: Return all the track names that have a song length longer then the average song
--length. Return the name and miliseconds for each track. Order by song lenth with 
--the longest songs listed first. 

select name, milliseconds as order_by_song
from track
where milliseconds > (
select avg(milliseconds)
from track 
)
order by order_by_song DESC




