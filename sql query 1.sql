use assignment;
-- 1. Create a table called employees with the following structure?
-- : emp_id (integer, should not be NULL and should be a primary key)Q
-- : emp_name (text, should not be NULL)Q
-- : age (integer, should have a check constraint to ensure the age is at least 18)Q
-- : email (text, should be unique for each employee)Q
-- : salary (decimal, with a default value of 30,000).

CREATE TABLE employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INTEGER NOT NULL CHECK (age >= 18),
    email VARCHAR(255) NOT NULL UNIQUE,
    salary DECIMAL DEFAULT 30000
);

-- 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
-- example for both adding and removing a constraint.

CREATE TABLE emp (
    empid INT,
    empname VARCHAR(28),
    empdep VARCHAR(30)
);

-- add constrain

alter table emp modify empid varchar(30) primary key;
alter table emp add constraint unique(empdep);

-- remove constrain

alter table emp drop constraint empid;


-- 6. You created a products table without constraints as follows:

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10 , 2 )
);

alter table products add constraint primary key(product_id);

alter table products modify price decimal(10,2) default(50.00);

-- 8. Consider the following three tables:
-- Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
-- listed even if they are not associated with an order 

CREATE TABLE orders (
    order_id INT UNIQUE PRIMARY KEY,
    order_date DATE,
    customer_id INT UNIQUE
);

insert into orders values (1,'2024-01-01',101),(2,'2024-01-03',102);

CREATE TABLE customers (
    customer_id INT UNIQUE,
    customer_name VARCHAR(50)
);

insert into customers values (101,'Alice'),(102,'Bob');

CREATE TABLE product (
    product_id INT UNIQUE,
    product_name VARCHAR(50),
    order_id INT
);

insert into product values (1,'Laptop',1),(2,'Phone',null);

SELECT 
    o.order_id, c.customer_name, p.product_name
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
        JOIN
    product p ON o.order_id = p.order_id;       
    
## 9 Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

create table sales (sale_id int unique, product_id int, amount int not null);

insert into sales values(1,101,500),(2,102,300),(3,101,700);
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50));
insert into products values(101,'laptop'),(102,'Phone');

SELECT 
    products.product_id AS Product, SUM(sales.amount) AS total
FROM
    products 
        JOIN
    sales ON products.product_id = sales.product_id group by Product ;

-- 10 Write a query to display the order_id, customer_name, and the quantity of products ordered by each
-- customer using an INNER JOIN between all three tables.
 create table order_details ( order_id int not null, product_id int not null , Quantity int not null);
 insert into order_details values(1,101,2),(1,102,1),(2,101,3);
 
 SELECT 
    orders.order_id, customer_name,product_id, Quantity
FROM
    order_details
        JOIN
    orders ON orders.order_id = orders.order_id
        JOIN
    customers ON orders.customer_id = customers.customer_id; 