/*******************
**Ejercicios Joins**
*******************/

-- 1. Obtener los clientes y las películas que han alquilado.

SELECT c.first_name, c.last_name, f.title
	FROM customer as c
    INNER JOIN rental
		USING (customer_id)
	INNER JOIN inventory
		USING (inventory_id)
	INNER JOIN film AS f
		USING (film_id);
        

-- 3. . Obtener todas las películas y, si están disponibles en inventario, mostrar la cantidad disponible.

-- Contamos todas las películas que hay para cada título
SELECT f.title, COUNT(i.inventory_id) AS num_disponible
	FROM film AS f
	LEFT JOIN inventory AS i
    USING (film_id)
    GROUP BY title;
    
-- Like, not like y regexp 4. Encuentra todas las películas cuyo título contiene la palabra "The." 
SELECT title
	FROM film
    WHERE title LIKE '%the%';
    
    
/*******************    
**Ejercicios union**
*******************/


-- 1. Encuentra todos los actores cuyos nombres comienzan con la letra "A" en la tabla `actor`
	/*y encuentra todos los clientes cuyos nombres comienzan con la letra "B" en la tabla `customer`.     
	Combina ambos conjuntos de resultados en una sola tabla.*/
    
SELECT CONCAT(first_name,' ', last_name) AS nombre, 'actor' AS tabla
	FROM actor
    WHERE first_name LIKE 'A%'
UNION 
SELECT CONCAT(first_name,' ', last_name), 'customer'
	FROM customer
    WHERE first_name LIKE 'B%';
/********************************************    
**Ejercicios subqueries y queries complejas**
********************************************/

-- 1. Encuentra el nombre y apellido de los actores que han actuado en películas 
/*que se alquilaron después de que la película "ACADEMY DINOSAUR" se alquilara por primera vez. 
Ordena los resultados alfabéticamente por apellido.*/

  
--  Averiguamos los inventary_id de la película 'ACADEMY DINOSAUR'
SELECT inventory_id
	FROM inventory
    WHERE film_id = (SELECT film_id
					FROM film
					WHERE title ='ACADEMY DINOSAUR')
-- -----------------------------------------
SELECT film_id, title 
	FROM film
	WHERE title ='ACADEMY DINOSAUR'


-- Averiguamos la primera fecha de cada id del inventario
SELECT film_id, inventory_id, MIN(rental_date) AS primer_alquiler
	FROM inventory
    INNER JOIN rental
    USING(inventory_id)
    GROUP BY inventory_id;
    
-- Averiguamos la primera fecha en que se alquilaron los números de inventario de 'ACADEMY DINOSAUR'

SELECT inventory_id, MIN(rental_date) AS primer_alquiler
	FROM inventory
    INNER JOIN rental
    USING(inventory_id)
    WHERE inventory_id IN (SELECT inventory_id
						FROM inventory
						WHERE film_id = (SELECT film_id
								FROM film
								WHERE title ='ACADEMY DINOSAUR'))
    GROUP BY inventory_id;

    
-- Averiguamos cúando se alquiló por primera vez 'ACADEMY DINOSAUR'

SELECT MIN(rental_date) AS primer_alquiler
	FROM inventory
    INNER JOIN rental
    ON inventory.inventory_id = rental.inventory_id
		INNER JOIN film
		ON inventory.film_id = film.film_id
		WHERE film.film_id = (SELECT film_id
							FROM film
							WHERE title ='ACADEMY DINOSAUR')
GROUP BY film.title
ORDER BY primer_alquiler
LIMIT 1;

-- Averiguamos cuales son las películas que se alquilaron después de la primera vez que se alquiló 'ACADEMY DINOSAUR'

SELECT i.film_id, f.title 
	-- Juntamos las tablas inventario y películas para saber los nombres de las películas
	FROM inventory AS i
    INNER JOIN film AS f
	ON i.film_id = f.film_id
    INNER JOIN rental AS r
    ON r.inventory_id = i.inventory_id
		WHERE rental_date > (SELECT MIN(rental_date) AS primer_alquiler
								FROM inventory
								INNER JOIN rental
								ON inventory.inventory_id = rental.inventory_id
								INNER JOIN film
								ON inventory.film_id = film.film_id
								WHERE film.film_id = (SELECT film_id
										FROM film
										WHERE title ='ACADEMY DINOSAUR')
							GROUP BY film.title
							ORDER BY primer_alquiler
							LIMIT 1)
GROUP BY i.film_id;

 
--  Nombres de actores de cada película
SELECT a.first_name, a.last_name, fa.film_id, f.title
	FROM actor AS a
		INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
			INNER JOIN inventory as i
			ON i.film_id = fa.film_id    
				INNER JOIN film AS f
				ON i.film_id = f.film_id
					INNER JOIN rental AS r
					ON r.inventory_id = i.inventory_id
						WHERE rental_date > (SELECT MIN(rental_date) AS primer_alquiler
												FROM inventory
												INNER JOIN rental
												ON inventory.inventory_id = rental.inventory_id
												INNER JOIN film
												ON inventory.film_id = film.film_id
												WHERE film.film_id = (SELECT film_id
														FROM film
														WHERE title ='ACADEMY DINOSAUR')
											GROUP BY film.title
											ORDER BY primer_alquiler
											LIMIT 1)
GROUP BY  a.first_name, a.last_name, fa.film_id                                          
ORDER BY a.last_name;


-- 2. Encuentra el título de las películas que han sido alquiladas por el cliente con el 
/*nombre "MARY SMITH" y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.*/

-- nombre cliente, titulo y fecha retorno
SELECT c.first_name, c.last_name, f.title, r.return_date
	FROM customer as c
    INNER JOIN rental AS r
		USING (customer_id)
	INNER JOIN inventory
		USING (inventory_id)
	INNER JOIN film AS f
		USING (film_id);
	
SELECT c.first_name, c.last_name, f.title, r.return_date
	FROM customer as c
    INNER JOIN rental AS r
		USING (customer_id)
	INNER JOIN inventory
		USING (inventory_id)
	INNER JOIN film AS f
		USING (film_id)
        WHERE first_name = 'Mary' AND last_name = 'Smith'
							AND return_date IS NULL;
					-- No hay resultados porque Mary Smith ha devuelto todas las películas
                    
SELECT f.title   -- solo pide los títulos y en orden alfabético
	FROM customer as c
    INNER JOIN rental AS r
		USING (customer_id)
	INNER JOIN inventory
		USING (inventory_id)
	INNER JOIN film AS f
		USING (film_id)
        WHERE first_name = 'Mary' AND last_name = 'Smith'
									-- AND return_date IS NULL
	ORDER BY title;
    

-- 3. Encuentra los nombres de los clientes que han alquilado al menos 5 películas distintas. 
/*Ordena los resultados alfabéticamente por apellido.*/


	SELECT first_name, last_name, COUNT(DISTINCT title) AS num, customer_id
	FROM customer as c
    INNER JOIN rental AS r
		USING (customer_id)
	INNER JOIN inventory AS i
		USING (inventory_id)
	INNER JOIN film AS f
		ON i.film_id = f.film_id
	GROUP BY customer_id, first_name, last_name
		HAVING num > 5
    ORDER BY last_name;

-- 4. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece 
/*a la categoría "Horror." Ordena los resultados alfabéticamente por apellido.*/

-- Buscamos las películas que tiene la categoría Horror

SELECT f.film_id, f.title, fc.category_id, c.name
	FROM film AS f
    INNER JOIN film_category AS fc
		   ON fc.film_id = f.film_id
           INNER JOIN category AS c
				ON fc.category_id = c.category_id
                WHERE c.name = 'Horror';


SELECT a.first_name, a.last_name, COUNT(f.title) as num_peliculas_Horror
	FROM actor AS a
		INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
			INNER JOIN film AS f
            ON fa.film_id = f.film_id
				INNER JOIN film_category AS fc
					ON fc.film_id = f.film_id
					INNER JOIN category AS c
					ON fc.category_id = c.category_id
					WHERE c.name = 'Horror'
GROUP BY a.first_name, a.last_name
HAVING num_peliculas_Horror >= 1
ORDER BY a.last_name;




    



-- 5. Encuentra los nombres de las películas que tienen la misma duración que la película con el título "GATTACA." 
/*Ordena los resultados alfabéticamente por título de película.*/

SELECT title, length
	FROM film
    WHERE title = 'GATTACA';
		-- No existe la película GATTACA, pero la subquery funciona igual

SELECT title
	FROM film
	WHERE length = (SELECT length
					FROM film
					WHERE title = 'ACADEMY DINOSAUR')
	ORDER BY title;
    

