-- Database: ProductDatabase

-- DROP DATABASE "ProductDatabase";

CREATE DATABASE "ProductDatabase"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
	
	
	
	CREATE TABLE category(
		category_id SERIAL,
		category_name VARCHAR(20) NOT NULL,
		product_id INT REFERENCES products(product_id) NOT NULL
	);
	
	
	CREATE TABLE inventory(
		inventory_id INT PRIMARY KEY,
		product_id INT REFERENCES products(product_id) NOT NULL,
		isin_Stock BOOLEAN NOT NULL,
		product_quantity INT NOT NULL
	);
	
	
	CREATE TABLE purchase_order(
		order_id INT PRIMARY KEY,
		product_id INT REFERENCES products(product_id) NOT NULL,
		qty_needed INT NOT NULL
	);
	
	CREATE TABLE products(
		product_id SERIAL PRIMARY KEY,
		product_name VARCHAR(30) NOT NULL,
		manufacturer VARCHAR(30) NOT NULL,
		shortcode CHAR(4) NOT NULL,
		c_price INT,
		s_price INT,	
	);
	
	ALTER TABLE products
DROP COLUMN pbrand_name;
	INSERT INTO purchase_order(order_id,product_id,qty_needed)
	 VALUES(1,1,5),
	 (2,2,10),
	 (3,4,10),
	 (4,6,20),
	 (5,7,2);
	 
	 
	CREATE TABLE supplier(
		product_id INT REFERENCES products(product_id),
		supplier_id INT PRIMARY KEY,
		supplier_name VARCHAR(128),
		order_date DATE,
		phoneno INT,
		email VARCHAR(128),
		city VARCHAR(40),
		state VARCHAR(30),
		order_id INT REFERENCES purchase_order(order_id)
	);
	
	CREATE TABLE staff(
		staff_id SERIAL PRIMARY KEY,
		staff_name VARCHAR(30) NOT NULL,
		staff_gender CHAR(1) NOT NULL,
		staff_phoneno INT UNIQUE,
		staff_age INT,
		staff_dept VARCHAR(30) NOT NULL
	);
	
	CREATE TABLE supplier_product(
		product_id INT REFERENCES products(product_id) NOT NULL,
		supplier_id INT REFERENCES supplier(supplier_id) NOT NULL
	)
	
	
	--VALUES FOR PRODUCT TABLE
	INSERT INTO products(product_name, manufacturer, shortcode, c_price, s_price)
	VALUES('TV', 'LG', 'tv',10000,12000),
	('Freeze', 'Wirlpool','fz',15000,18000),
	('AC', 'Samsung','ac',300000,40000),
	('Mobile','Vivo','mob',16999,19999),
	('Laptop','Lenovo','lapi',45000,55000);
	
	
	INSERT INTO products(product_name, manufacturer, shortcode, c_price, s_price)
	VALUES('Maggi', 'sunfeest', 'mg',50,60),
	('Dairy Milk','cadbaury', 'dm',100,120),
	('Cookies', 'ParleG','coo',200,300),
	('Milk','Amul','mlk',50,80),
	('Cream','Amul','crm',500,700);
	
	SELECT * From products;
	
	
	INSERT INTO category(category_name,product_id)
	VALUES('Electronics',1),
	('Electronics',2),
	('Electronics',3),
	('Electronics',4),
	('Electronics',5),
	('Food',6),
	('Chocolates',7),
	('Food',8),
	('Dairy',9),
	('Dairy',10)
	
	
	SELECT * from category;
	
	
	INSERT INTO inventory(inventory_id,product_id,isin_Stock,product_quantity)
	VALUES(1,1,true,10),
	(2,2,false,0),
	(3,3,true,5),
	(4,4,true,6),
	(5,5,false,0);
	
	
	ALTER TABLE supplier
ADD COLUMN phoneno VARCHAR(10);

SELECT * FROM supplier;
	
	INSERT INTO staff(staff_name,staff_gender, staff_phoneno, staff_age,staff_dept)
	VALUES('Bruce','M',2222222888,21,'counter member'),
	('Herry','M',1111111111,35,'product collector'),
	('Jerry','F',9999999999,12,'product collector'),
	('Stark','M',1212121221,25,'counter member'),
	('Rahul','M',33333333,41,'godown manager'),
	('Gaurav','M',983437353,22,'godown manager'),
	('Ruchi','F',9933423244,45,'product collector'),
	('Tonny','M',2332323232,25,'counter member');
	
	INSERT INTO supplier(product_id,supplier_id,supplier_name,order_date,phoneno,email,city,state,order_id)
	VALUES(1,1,'Rajat','2000-12-30','1111232333','rajat@gmail.com','Ghaziabad','UP',1),
	(2,2,'Gaurav','1888-12-30','2222223232','gaurav@gmail.com','Patna','Bihar',2),
	(3,3,'Harshit','1999-10-21','98923823','harshit@gmail.com','fzd','UP',3),
	(4,4,'Rohit','2000-1-13','2222244232','rohit@gmail.com','Agra','UP',4),
	(5,5,'Yanshik','1666-12-20','98232323','yanshik@gmail.com','Bijnor','UP',5);
	
	
	INSERT INTO supplier_product(product_id,supplier_id)
	VALUES(1,1),
	(2,1),
	(1,2),
	(3,3),
	(4,4),
	(5,1);
	
	SELECT * FROM supplier_product;
	
	SELECT * FROM supplier;
	--1. Query staff using name
	
	SELECT Staff.FirstName,Staff.Id,Staff.PhoneNumber,Staff.Gender,Staff.RoleId, Role.RollName,
	Address.AddressLine1,Address.AddressLine2 FROM Staff INNER JOIN Role ON Staff.RoleId = Role.Id
	INNER JOIN  Address ON Staff.AddressId = Address.Id WHERE Staff.FirstName='Yanshik';
	
	
	//SELECT * FROM staff WHERE  = 'Yanshik';
	
	--1.Query staff using phone no	
	--SELECT * FROM staff WHERE staff_phoneno = '9933423244';
	SELECT Staff.FirstName,Staff.Id,Staff.PhoneNumber,Staff.Gender,Staff.RoleId, Role.RollName,
	Address.AddressLine1,Address.AddressLine2 FROM Staff INNER JOIN Role ON Staff.RoleId = Role.Id
	INNER JOIN  Address ON Staff.AddressId = Address.Id WHERE Staff.PhoneNumber='8788788787';
	
	-- 2. Query Staff using their role
	--SELECT staff_name from staff WHERE staff_dept = 'product collector';
	SELECT Staff.FirstName,Staff.Id,Staff.PhoneNumber,Staff.Gender,Staff.RoleId, Role.RollName,
	Address.AddressLine1,Address.AddressLine2 FROM Staff INNER JOIN Role ON Staff.RoleId = Role.Id
	INNER JOIN  Address ON Staff.AddressId = Address.Id WHERE Role.RollName='Product Manager';
	
	
	-- 3.aQuery product  based on Name 
	SELECT *
	FROM products
	WHERE product_name='TV';
   
   --3.b based on category
    SELECT *
	FROM products INNER JOIN  category
	ON products.product_id=category.category_id 
	where category_name='Electronics';
	
   --3.c based on instock,outstock
   SELECT *
   from products INNER JOIN inventory
   on products.product_id = inventory.product_id
   where isin_stock = true;
   
   
  --3.d SP less than
  SELECT product_name, s_price FROM products WHERE s_price < 1000;
   
   --SP greater than 
   SELECT product_name, s_price FROM products WHERE s_price > 1000;
	--SP between
	 SELECT product_name, s_price FROM products WHERE s_price BETWEEN 12000 AND 20000;

--4-Numbers of products out of stock
SELECT COUNT(inventory.product_id)
   from products INNER JOIN inventory
   on products.product_id = inventory.product_id
   where isin_stock = false;
   
   --5- Number of product within a categpory
   SELECT COUNT(products.product_id)
	FROM products INNER JOIN  category
	ON products.product_id=category.category_id 
	where category_name='Dairy';
	
	
	--6- highest to lowest
	SELECT category.category_name,COUNT(DISTINCT(products.product_name))
	FROM products INNER JOIN  category
	ON products.product_id=category.category_id 
	 GROUP BY category.category_name
	 ORDER BY COUNT(DISTINCT(products.product_name)) DESC;
	
	--7a. List of supplier NAme;
	SELECT supplier_name FROM supplier;
	SELECT * FROM supplier WHERE supplier_name ='Yanshik';
	--7b. List of supplier Phone;
	SELECT phoneno FROM supplier;
	
	--7c. List of supplier Email;
	SELECT email FROM supplier;
	
	--7d. List of supplier City;
	SELECT city FROM supplier;
	SELECT state FROM supplier;
	
	--8 
	SELECT products.product_name,supplier.supplier_name,supplier.order_date,purchase_order.qty_needed FROM products
	INNER JOIN supplier 
	ON products.product_id= supplier.product_id INNER JOIN supplier_product
	ON products.product_id = supplier_product.product_id INNER JOIN purchase_order ON products.product_id = purchase_order.product_id;
	
	--8a Product name
	
	SELECT products.product_name,supplier.supplier_name,supplier.order_date,purchase_order.qty_needed FROM products
	INNER JOIN supplier 
	ON products.product_id= supplier.product_id INNER JOIN supplier_product
	ON products.product_id = supplier_product.product_id INNER JOIN purchase_order ON products.product_id = purchase_order.product_id
	WHERE products.product_name = 'TV';
	
	--8b Supplier Name
	
	SELECT products.product_name,supplier.supplier_name,supplier.order_date,purchase_order.qty_needed FROM products
	INNER JOIN supplier 
	ON products.product_id= supplier.product_id INNER JOIN supplier_product
	ON products.product_id = supplier_product.product_id INNER JOIN purchase_order ON products.product_id = purchase_order.product_id
	WHERE supplier.supplier_name ='Rajat';
	
	--8c Product Code
	SELECT products.product_name,supplier.supplier_name,supplier.order_date,purchase_order.qty_needed FROM products
	INNER JOIN supplier 
	ON products.product_id= supplier.product_id INNER JOIN supplier_product
	ON products.product_id = supplier_product.product_id INNER JOIN purchase_order ON products.product_id = purchase_order.product_id
	WHERE products.shortcode = 'fz';
	
	--8d Supplied After a particular date
	
	SELECT products.product_name,supplier.supplier_name,supplier.order_date,purchase_order.qty_needed FROM products
	INNER JOIN supplier 
	ON products.product_id= supplier.product_id INNER JOIN supplier_product
	ON products.product_id = supplier_product.product_id INNER JOIN purchase_order ON products.product_id = purchase_order.product_id
	WHERE supplier.order_date > '1990-12-25';
	
	--8e Supplied Before a particular date
	
	SELECT products.product_name,supplier.supplier_name,supplier.order_date,purchase_order.qty_needed FROM products
	INNER JOIN supplier 
	ON products.product_id= supplier.product_id INNER JOIN supplier_product
	ON products.product_id = supplier_product.product_id INNER JOIN purchase_order ON products.product_id = purchase_order.product_id
	WHERE supplier.order_date < '1990-12-25';
	
	--8f Supplied Before a particular date
	--less than
	
	SELECT products.product_name,supplier.supplier_name,supplier.order_date,purchase_order.qty_needed FROM products
	INNER JOIN supplier 
	ON products.product_id= supplier.product_id INNER JOIN supplier_product
	ON products.product_id = supplier_product.product_id INNER JOIN purchase_order ON products.product_id = purchase_order.product_id
	WHERE purchase_order.qty_needed < 6;
	
	--More than
	
	
	SELECT products.product_name,supplier.supplier_name,supplier.order_date,purchase_order.qty_needed FROM products
	INNER JOIN supplier 
	ON products.product_id= supplier.product_id INNER JOIN supplier_product
	ON products.product_id = supplier_product.product_id INNER JOIN purchase_order ON products.product_id = purchase_order.product_id
	WHERE purchase_order.qty_needed > 6;
	
	
	
	DROP TABLE staff;
	
	CREATE TABLE Role(
	Id BIGINT PRIMARY KEY,
	RollName VARCHAR(64),
	Description VARCHAR(1024)
	);
	
	DROP TABLE role;
	
	CREATE TABLE Address(
	Id SERIAL PRIMARY KEY,
	AddressLine1 varchar(128) NOT NULL,
	AddressLine2 varchar(64),
	City varchar(64) NOT NULL,
	State varchar(64) NOT NULL,
	PinCode char(6)
	);
	SELECT * FROM role
	
	
	CREATE TABLE Staff(
		Id SERIAL PRIMARY KEY,
		FirstName varchar(64) NOT NULL,
		LastName varchar(64),
		PhoneNumber char(10) NOT NULL,
		Gender char(1) NOT NULL,
		AddressId BIGINT REFERENCES Address(Id) NOT NULL,
		RoleId BIGINT REFERENCES Role(Id) NOT NULL,
		Salary BIGINT 
	)
	
	SELECT * FROM Staff;

	INSERT INTO Role(Id,RollName,Description)
	VALUES(1,'Godown Manager','Handles Godown'),
	(2,'Product Manager','Handles products'),
	(3,'Counter Manager','Handles counter');
	
	SELECT * FROM Role;
	
	INSERT INTO Address(AddressLine1,AddressLine2,City,State,PinCode)
	VALUES('Arya Nagar','Near Ghnadi Nagar Chauraha', 'Firozabad','Uttar Pradesh',283203),
	('Mohan Nagar','Jalesar Road', 'Noida','Uttar Pradesh',288883),
	('Lohia Nagar','Jalesar Road', 'Agra','Uttar Pradesh',303030),
	('Sanjay Palace','Railway Road', 'Agra','Uttar Pradesh',283201),
	('RKGIT','Meerurt-Delhi Highway', 'Ghaziabad','Uttar Pradesh',201003),
	('Mohan Nagar','Jalesar Road', 'Noida','Uttar Pradesh',283203),
	('Taazaa Tech','Sector 63', 'Noida','Uttar Pradesh',200300);
	
	SELECT * FROM Address;
	
	
	INSERT INTO Staff(FirstName,LastName,PhoneNumber,Gender,AddressId,RoleId,Salary)
	VALUES('Gaurav', 'Raj',9892929222,'M',1,1,25000),
	('Yanshik', 'Kumar',9676767677,'M',2,2,25000),
	('Rishab', 'Sharma',8788788787,'M',2,3,55000),
	('Ritik','Sharma',5464646466,'M',3,1,22000),
	('Prerna', 'Pachauri',8787656363,'F',5,2,25000),
	('Anjali', 'Kumari',9892929444,'F',6,3,55000);
		
	SELECT * FROM Staff;