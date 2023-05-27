
-- basic quries just to get my hands dirty.
-- SELECT first_name from employees WHERE gender = 'M';
-- SELECT * from employees;
-- select DISTINCT dept_name from departments;
-- SELECT * from salaries;
-- SELECT salary from salaries WHERE emp_no = '10001';
-- SELECT title FROM titles WHERE emp_no = '10006';


-- Renaming columns tho it won't affect the main database.
-- SELECT gender as "Gender", first_name as "First Name", last_name as "Last Name" FROM employees;


-- concating columns and changing the name of the columns.
-- SELECT concat(first_name, '  ', last_name ) as "Name" FROM employees;
-- SELECT concat(emp_no, ' is a ', title) as "Employee Title" from titles;
-- SELECT emp_no, concat( first_name, ' ', last_name) as "Full Name" FROM employees;


-- There are two types of function. Aggregate and Scalar. Aggregate function will give you one output. Ex: You want to get the total salries of the employees.
-- Scalar function will give you a new column. Ex: You want to concatanate two columns.


-- Aggregate function examples below:
-- SELECT max(salary) from salaries;
-- SELECT sum(salary) from salaries;
-- Question 1: What is the average salary for the company?
-- SELECT avg( salary) from salaries;
-- Question 2: What year was the youngest person born in the company?
-- SELECT min(birth_date) from employees;
-- Question 1: How many towns are there in france?
-- SELECT count(id) from towns;
-- Question 1: How many official languages are there?
-- SELECT * from countrylanguage;
-- SELECT count(countrycode) from countrylanguage where isofficial = 'true';
-- Question 2: What is the average life expectancy in the world?
-- SELECT avg(lifeexpectancy) from country;
-- Question 3: What is the average population for cities in the netherlands?
-- SELECT avg(population) from city where countrycode = 'NLD';

-- SELECT concat(first_name, ' ', last_name) as "Full_Name" from employees where first_name = 'Mayumi' AND last_name = 'Schueller';
-- SELECT * from employees where gender = 'F';
-- SELECT count(gender) FROM customers WHERE (state = 'OR' AND gender = 'F') OR (state = 'NY' AND gender = 'F');

-- How many female customers do we have from the state of Oregon (OR)?
-- SELECT count(customerid) from customers where state = 'OR' and gender = 'F';

-- Who over the age of 44 has an income of 100 000 or more?
-- SELECT count(customerid) from customers where age > '44' and income >= '100000';

-- Who between the ages of 30 and 50 has an income of less than 50 000?
-- SELECT count(customerid) from customers where age > '30' and age < '50' and income < '50000';

-- What is the average income between the ages of 20 and 50?
-- SELECT avg(income) from customers where age >= '20' and age <= '50';
-- 

-- 
--  Select people either under 30 or over 50 with an income above 50000
-- * Include people that are 50
-- * that are from either Japan or Australia

-- SELECT age, income, country from customers where (age < '30' or age >= '50') and (income > '50000') and (country = 'Japan' or country = 'Australia');

/*
* DB: Store
* Table: Orders
* Question: 
* What was our total sales in June of 2004 for orders over 100 dollars?
*/

-- SELECT * from orders;
-- 
-- SELECT sum(totalamount) from orders where totalamount > '100' and orderdate >= '2004-06-01' and orderdate <= '2004-06-30';
-- 

-- SELECT * from orders where totalamount > '100' and date_part('MONTH', orderdate) = 6;
-- 



-- SELECT * from employees;
-- 
-- SELECT first_name from employees;

-- SELECT * from employees;
-- 
-- SELECT concat(first_name, ' D. ', last_name) as real_name from employees;
-- SELECT concat(first_name, ' D. ', last_name, '/ gender = ', gender) as real_name from employees;
/*
* DB: Store
* Table: customers
* Question: adjust the following query to display the null values as "No Address"
*/

-- We use COALESCE function to replace null values of a column with a value.
-- SELECT COALESCE(address2, 'No Address') FROM customers;

/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/

-- SELECT * FROM customers WHERE COALESCE(address2, null) IS null;
-- 



/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/

-- SELECT coalesce(lastName, 'Empty'), * from customers where (age is not null);
-- 




-- Between keyword is just like y <= x <= z.
-- SELECT age from customers where age BETWEEN 30 and 50;
-- 

-- In keyword checks if something is in a list just like python.

-- SELECT * from customers where phone in('4608499546', '5119315633');
-- 


/*
* DB: Store
* Table: orders
* Question: How many orders were made by customer 7888, 1082, 12808, 9623
*/

-- SELECT * FROM orders where customerid in ('7888', '1082', '12808', '9623');

-- SELECT concat(lastname, '  ', firstname, ' is ', age, ' years old') as Full_Name from customers;

/*
* DB: World
* Table: city
* Question: How many cities are in the district of Zuid-Holland, Noord-Brabant and Utrecht?
*/

-- SELECT count(id) FROM city WHERE district in ('Zuid-Holland', 'Noord-Brabant',  'Utrecht');
-- 



-- Between Rule

-- SELECT * from city where population BETWEEN 500000 and 1000000;
-- 



-- Like Rule

/*
* DB: Employees
* Table: employees
* Question: Find the age of all employees who's name starts with M.
* Sample output: https://imgur.com/vXs4093
* Use EXTRACT (YEAR FROM AGE(birth_date)) we will learn about this in later parts of the course
*/
-- SELECT emp_no, first_name, EXTRACT (YEAR FROM AGE(birth_date)) as "age" FROM employees WHERE first_name like 'M%';
-- 

-- SELECT * from employees;
-- 
/*
* DB: Employees
* Table: employees
* Question: How many people's name start with A and end with R?
* Expected output: 1846
*/

-- SELECT count(emp_no) from employees where first_name Ilike 'A%' and first_name Ilike '%R';
-- 

                                                  
/*
* DB: Store
* Table: customers
* Question: How many people's zipcode have a 2 in it?.
* Expected output: 4211 
*/

-- SELECT * from customers;
-- 

-- SELECT count(customerid) FROM customers WHERE zip::text like '%2%';
-- 

/*
* DB: Store
* Table: customers
* Question: How many people's zipcode start with 2 with the 3rd character being a 1.
* Expected output: 109 
*/

-- SELECT count(customerid) from customers where zip::text like '2_1%';
-- 

/*
* DB: Store
* Table: customers
* Question: Which states have phone numbers starting with 302?
* Replace null values with "No State"                                                  
* Expected output: https://imgur.com/AVe6G4c
*/

-- SELECT COALESCE(state, 'No state'), * from customers WHERE phone::text like '302%';
-- 
 


 /*
* DB: Employees
* Table: employees
* Question: Get me all the employees above 60, use the appropriate date functions
*/

 
-- SELECT * from employees where EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM birth_date::date) > 60;
-- 
/*
* DB: Employees
* Table: employees
* Question: How many employees where hired in February?
*/


-- SELECT COUNT(emp_no) FROM employees WHERE date_part('month', hire_date) = 2;



/*
* DB: Employees
* Table: employees
* Question: How many employees were born in november?
*/

-- 
-- SELECT COUNT(emp_no) FROM employees WHERE date_part('month', birth_date) = 11;
-- 

/*
* DB: Employees
* Table: employees
* Question: Who is the oldest employee? (Use the analytical function MAX)
*/

-- SELECT max(EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM birth_date::date)) FROM employees;
-- 
/*
* DB: Store
* Table: orders
* Question: How many orders were made in January 2004?
*/



-- SELECT COUNT(orderid) FROM orders WHERE EXTRACT(MONTH FROM orderdate) = 1 AND EXTRACT(YEAR FROM orderdate) = 2004;
-- 


/*
* DB: Employees
* Table: titles
* Question: What unique titles do we have?
*/

-- SELECT DISTINCT title FROM titles;
-- 

/*
* DB: Employees
* Table: employees
* Question: How many unique birth dates are there?
*/

-- SELECT COUNT(DISTINCT birth_date) from employees;
/*
* DB: World
* Table: country
* Question: Can I get a list of distinct life expectancy ages
* Make sure there are no nulls
*/


-- SELECT distinct lifeexpectancy from country where lifeexpectancy Is not null;
-- 
