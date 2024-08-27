Create table If Not Exists Customers (customer_id int, customer_name varchar(20));
insert into Customers (customer_id, customer_name) values ('1', 'Alice');
insert into Customers (customer_id, customer_name) values ('4', 'Bob');
insert into Customers (customer_id, customer_name) values ('5', 'Charlie');

/*Write an SQL query to find the missing customer IDs. The missing IDs are ones that are not in the Customers table but are in the range between 1 and the maximum customer_id present in the table.

Notice that the maximum customer_id will not exceed 100.

Return the result table ordered by ids in ascending order.

The query result format is in the following example.

The maximum customer_id present in the table is 5, so in the range [1,5], IDs 2 and 3 are missing from the table.   */

SELECT generate_series(1, (SELECT MAX(customer_id) FROM customers)) AS ids
EXCEPT
SELECT customer_id FROM customers;