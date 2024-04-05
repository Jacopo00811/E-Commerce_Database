# If the tables already exists, then they are deleted!
drop database if exists ecommerce;
create database ecommerce;
use ecommerce;

DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Creates;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Review;

# Table creation! Create Tables with Foreign Keys after the referenced tables are created!

CREATE TABLE Customer
	(CustomerEmail VARCHAR(320),
	 CustomerName VARCHAR(15) NOT NULL,
	 CustomerAddress VARCHAR(40) NOT NULL,
	 PRIMARY KEY(CustomerEmail)
	);

CREATE TABLE Orders
	(OrderID VARCHAR(8),
	 ExpectedDate DATE,
	 PRIMARY KEY(OrderID)
	);
    
CREATE TABLE Category
	(CategoryID VARCHAR(8),
     CategoryName VARCHAR(30) NOT NULL,
	 PRIMARY KEY(CategoryID)
	);
    
CREATE TABLE Product
	(ProductID VARCHAR(8),
     CategoryID VARCHAR(8),
     ProductName VARCHAR(30) NOT NULL,
     ProductDesciption VARCHAR(100) NOT NULL,
     Price DECIMAL(10, 2) NOT NULL,
	 Stock INT,
	 PRIMARY KEY(ProductID),
     FOREIGN KEY(CategoryID) REFERENCES Category(CategoryID) ON DELETE CASCADE
	);
    
CREATE TABLE Cart
	(CartID VARCHAR(320),
	 OrderID VARCHAR(8),
	 PRIMARY KEY(CartID),
     FOREIGN KEY(OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
	);
    
CREATE TABLE Items
	(CartID VARCHAR(8),
	 ProductID VARCHAR(8),
	 PRIMARY KEY(CartID, ProductID),
     FOREIGN KEY(CartID) REFERENCES Cart(CartID) ON DELETE CASCADE,
     FOREIGN KEY(ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
	);
    
CREATE TABLE Creates
	(CustomerEmail VARCHAR(320),
	 CartID VARCHAR(8) NOT NULL UNIQUE,
	 CreationDate Date,
	 PRIMARY KEY(CustomerEmail),
     FOREIGN KEY(CustomerEmail) REFERENCES Customer(CustomerEmail) ON DELETE CASCADE,
     FOREIGN KEY(CartID) REFERENCES Cart(CartID) ON DELETE CASCADE
	);
    
CREATE TABLE Review
	(ReviewID VARCHAR(8),
	 ProductID VARCHAR(8),
     Rating INT CHECK (Rating > 0 AND Rating <= 5),
     Title VARCHAR(30) NOT NULL,
     Body VARCHAR(300) NOT NULL, 
     ReviewDate Date,
	 PRIMARY KEY(ReviewID),
     FOREIGN KEY(ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
	);
    

INSERT Customer VALUES
("Anna@gmail.com","Anna","London"),
("Bob@dtu.dk","Bob","Hemple"),
("Charlie@Ku.dk","Chaelie","KBH"),
("Donald@trump.com","Donald","Jail"),
("Eric@Eric.Eric","Eric","Kampsax");

INSERT Orders VALUES
("1234","2010-04-03"),
("12345","2020-05-04"),
("12346","2009-06-06"),
("12347","2019-01-01"),
("12348","1999-05-03");

INSERT Category VALUES 
("1","Cat Food"),
("2","Dog Food"),
("3","human Food"),
("4","notFood"),
("5","Food");

INSERT Product VALUES
('11', '1', 'fish', 'This is fish for cats', 10.99, 3),
('22', '2', 'Bone', 'This is Bone for dogs', 100.99, 1000),
('33', '3', 'Big Mac', 'This is a burger', 1.99, 1),
('44', '4', 'Rocks', 'Do not eat rocks', 0.99, 1000000),
('55', '4', 'more rocks', 'could be edible', 1.99, 0);

INSERT Cart VALUES
("CART01","1234"),
("CART02","12345"),
("CART03","12346"),
("CART04","12347"),
("CART05","12348");


INSERT Items VALUES
("Cart01", "11"),
("Cart01", "22"),
("Cart02", "44"),
("Cart02", "55"),
("Cart03", "33");

INSERT Creates VALUES
("Anna@gmail.com", "Cart03","2020-05-04"),
("Bob@dtu.dk", "Cart01","2015-09-04"),
("Donald@trump.com", "Cart02","2120-12-04");

INSERT Review VALUES
("R1","11","4","IS fish","This fish had great flavor and consistancy","2020-04-03"),
("R2","11","5","IS very good fish","This fish had great flavor and consistancy","2000-04-03"),
("R3","44","4","good rocks","This fish had great flavor and consistancy, but was too bony","2010-04-15"),
("R4","55","1","not edible","This fish had way too many bones and smelled old","2010-04-03"),
("R5","33","3","Not worth","I weighed the fish to 200g instead of the expected 400g","2010-01-03");

# View
DROP VIEW IF EXISTS ProductAndReviews;
CREATE VIEW ProductAndReviews AS
SELECT * FROM Product NATURAL JOIN Review;

# All tables
SELECT * FROM Creates;
SELECT * FROM Cart;
SELECT * FROM Items;
SELECT * FROM Orders;
SELECT * FROM Category;
SELECT * FROM Product;
SELECT * FROM Review;

# Calling the view
SELECT * FROM ProductAndReviews;


