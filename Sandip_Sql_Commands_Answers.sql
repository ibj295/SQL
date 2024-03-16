#----Assasment SQL Commands---

use mavenmovies;

#--- 1.Identify the primary keys and foreign keys in maven movies db. Discuss the differences ---

/* 
Primary and foreign key are used in sql as a constrains the dirrerance is 
primary key is used to indetify each record from table and it is unique and should be not null whereas,
foreign key can contain non-unique data and can contain null values. primary and foreign key are used to connect table while extracting data from multipal tables.
*/
SELECT * FROM information_schema.key_column_usage;

#--- 2. List all details of actors---
select * from actor;

#--- 3. List all customer information from DB.---
select * from customer;

#--- 4. List different countries.---
select distinct(country) from country;

#--- 5. Display all active customers. ---
SELECT customer_id, first_name, last_name, email FROM customer 
WHERE `active`=1;

#--- 6. List of all rental IDs for customer with ID 1. ---
SELECT rental_id FROM rental WHERE customer_id=1;

#--- 7. Display all the films whose rental duration is greater than 5.---
SELECT film_id, title FROM film WHERE rental_duration > 5;

#--- 8. List the total number of films whose replacemnet cost is greater than $15 and less than  $20.---
SELECT COUNT(*) FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

#--- 9. Display the count of unique first names of actors.---
SELECT COUNT(DISTINCT first_name) FROM actor;


#--- 10. Display the first 10 recods from the customer table.---
SELECT * FROM customer LIMIT 10;

#--- 11. Display the first 3 records from the customer table whose first name starts with 'b'.---
SELECT * FROM customer WHERE first_name LIKE 'b%' LIMIT 3;

#--- 12.  Display the names of first 5 movies which are rated as G.---
SELECT title FROM film WHERE rating = 'G' LIMIT 5;

#--- 13. Find all customers whose first name starts with "a".---
SELECT * FROM customer WHERE first_name LIKE "a%";

#--- 14. Find all customers whose first name ends with "a".---
SELECT * FROM customer WHERE first_name LIKE "%a";

#--- 15. Display the list of first 4 cities which start and end with ‘a’.---
SELECT city FROM city WHERE city LIKE 'a%%a' LIMIT 4;

#--- 16. Find all customers whose first name have "NI" in any position.---
SELECT first_name FROM customer WHERE first_name LIKE '%ni%';

#--- 17. Find all customers whose first name have "r" in the second position. ---
SELECT first_name FROM customer WHERE first_name LIKE '_r%';

#--- 18. Find all customers whose first name starts with "a" and are at least 5 characters in length.---
SELECT first_name FROM customer WHERE first_name LIKE 'a____%';

#--- 19. Find all customers whose first name starts with "a" and ends with "o".---
SELECT first_name FROM customer WHERE first_name LIKE 'a%o';

#--- 20. Get the films with pg and pg-13 rating using IN operator.---
SELECT title FROM film WHERE rating IN ('PG', 'PG-13');

#--- 20. Get the films with length between 50 to 100 using between operator.---
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

#--- 21. Get the top 50 actors using limit operator.---
SELECT * FROM actor LIMIT 50;

#--- 22. Get the distinct film ids from inventory table.---
SELECT DISTINCT film_id FROM inventory;