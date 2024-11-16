SELECT customer_name, contact_last_name, contact_first_name, phone, address_line1, address_line2, city, state, postal_code, country
FROM customers;

SELECT customer_number, customer_name, contact_last_name, phone
FROM customers
WHERE country = 'USA';

SELECT country
FROM customers
WHERE credit_limit > 10000;





