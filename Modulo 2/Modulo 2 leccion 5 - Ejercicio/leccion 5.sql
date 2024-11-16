
CREATE TABLE t1 (
	a INT,
    b CHAR(10)
    );
    
ALTER TABLE t1 RENAME t2;

ALTER TABLE t2 
	MODIFY COLUMN a TINYINT NOT NULL;

ALTER TABLE t2
	MODIFY COLUMN b CHAR(20);  
-- quise hacer las dos cosas a la vez pero me daba error
ALTER TABLE t2    
    RENAME COLUMN b TO c;
    
ALTER TABLE t2
	ADD COLUMN d TIMESTAMP;

ALTER TABLE t2
	DROP COLUMN  c;

CREATE TABLE t3 LIKE t2;

DROP TABLE t2;

RENAME TABLE t3 TO t1;

CREATE TABLE IF NOT EXISTS customers_mod
SELECT *
FROM customers;



INSERT INTO customers_mod
	VALUES (
    343,
    'Adalab',
    'Rodriguez',
    'Julia',
    '672986373',
    'Calle Falsa 123',
    'Puerta 42',
    'Madrid',
    'España',
    28000,
    'España',
    15,
    20000000
    );
    
INSERT INTO customers_mod
	VALUES (
    344,
    'La pegatina After',
    'Santiago',
    'Maricarmen',
    '00000000',
    'Travesía del rave',
    NULL,
    'Palma de Mayorca',
    NULL,
    07005,
    'España',
    10,
    45673453);
    
   -- Para dejar vacío contact_first_name tendría que cambiar la condición de la variable, porque ahora no puede ser null 
INSERT INTO customers_mod
	VALUES	(545, 'Triana', 'Miralaella', 'Latrini', '555456786', 'Calle la mayor s/n', NULL, 'Cáceres',NULL, 25075, 'España', 25, 150000),
			(380, 'Gonzalez', 'Perez', 'Lalola', '555354868', 'Esa vive en la calle', NULL, 'Trujillo', NULL, 28658, 'España', 66, 780000),
            (600,'Retuerta', 'Abajo', 'Mirinda', '55566554654', 'La calle es su vida', NULL,'Coria',35856, NULL, 'España', 88, 8556675),
            (125,'Triana', 'Gonzalez','Rosalina', '45658765454', 'Calle la menor', NULL,'Plasencia', NULL, 85865,'España', 55, 25000),
            (388,'Retuerta', 'Triana', 'Cataleya', '45646546548', 'Calle del medio', NULL, 'Montehermoso', NULL, 5869, 'España', 69, 5646546);

UPDATE customers_mod
	SET contact_first_name = NULL
    WHERE contact_first_name = 'Mirinda'; -- NO DEJA DEJAR ESTE CAMPO NULL

UPDATE customers_mod
	SET address_line1 = 'Polígono Industrial de Son Castelló', address_line2 = 'Nave 92', city = 'Palma de Mallorca'
    WHERE customer_name = 'La pegatina After'
    
    -- Se me olvidaron algunos datos:

UPDATE customers_mod
	SET state = 'España', postal_code = 28123, country = 'España', sales_rep_employee_number = 25, credit_limit = 5000000
      WHERE customer_name = 'La pegatina After'
    
CREATE TABLE customers_destroy LIKE customers_mod

UPDATE customers_destroy
	SET address_line1 = 'Vamos', address_line2 = 'a', postal_code = 'fastidiar', country = 'la tabla :)'
    
INSERT INTO customers_destroy
SELECT *
FROM customers_mod;

UPDATE customers_mod
	SET sales_rep_employee_number = 2
	LIMIT 10;

DELETE FROM customers_mod
	WHERE contact_first_name = NULL; -- NO SE PUEDE DEJAR ESTE CAMPO NULL.
    
-- VOY A BORRAR OTROS. ESOS NO PUEDO
DELETE FROM customers_destroy -- tb lo he probado con customers_mod y tampoco borra nada
	WHERE address_line2 = NULL;
-- por qué no borra nada?????

DELETE FROM customers_mod;

    

    






    

