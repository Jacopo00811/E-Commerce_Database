# If the tables already exists, then they are deleted!
drop database if exists ecommerce;
create database ecommerce;
use ecommerce;

DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Creates;
DROP TABLE IF EXISTS Cart;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Oders; # TODO: Need to change the name in previous steps because Order is a reserved keyword
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
	 # Items , # TODO: decide the type
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
	 CartID VARCHAR(8),
	 ProductID VARCHAR(8),
	 PRIMARY KEY(CustomerEmail, CartID, ProductID),
     FOREIGN KEY(CustomerEmail) REFERENCES Customer(CustomerEmail) ON DELETE CASCADE,
     FOREIGN KEY(CartID) REFERENCES Cart(CartID) ON DELETE CASCADE,
     FOREIGN KEY(ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
	);
    
CREATE TABLE Review
	(ReviewID VARCHAR(8),
	 ProductID VARCHAR(8),
     Rating INT CHECK (Rating > 0 AND Rating <= 5),
     Title VARCHAR(30) NOT NULL,
     # Text VARCHAR(300) NOT NULL, # TODO: Change name here and in previous steps becase Text is a keyword
     # Date Date, # TODO: Change name here and in previous steps becase Date is a keyword
	 PRIMARY KEY(ReviewID),
     FOREIGN KEY(ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE
	);
    

insert Customer Values
("Anna@gmail.com","Anna","London"),
("Bob@dtu.dk","Bob","Hemple"),
("Charlie@Ku.dk","Chaelie","KBH"),
("Donald@trump.com","Donald","Jail"),
("Eric@Eric.Eric","Eric","Eric");

insert Orders Values
("1234","2010-04-03"),
("12345","2020-05-04"),
("12346","2009-06-06"),
("12347","2019-01-01"),
("12348","1999-05-03");

insert Category values 
("1","Cat Food"),
("2","Dog Food"),
("3","human Food"),
("4","notFood"),
("5","Food");


insert Product values
('11', '1', 'fish', 'This is fish for cats', 10.99, 3),
('22', '2', 'Bone', 'This is Bone for dogs', 100.99, 1000),
('33', '3', 'Big Mac', 'This is a burger', 1.99, 1),
('44', '4', 'Rocks', 'Do not eat rocks', 0.99, 1000000),
('55', '4', 'more rocks', 'could be edible', 1.99, 0);



insert Cart values
("CART01","1234"),
("CART02","12345"),
("CART03","12346"),
("CART04","12347"),
("CART05","12348");


insert Items values
("Cart01", "11"),
("Cart01", "22"),
("Cart02", "44"),
("Cart02", "55"),
("Cart03", "33");


insert Creates values
("Anna@gmail.com", "Cart03","33"),
("Bob@dtu.dk", "Cart01","11"),
("Bob@dtu.dk", "Cart01","22"),
("Donald@trump.com", "Cart02","44"),
("Donald@trump.com", "Cart02","55");




insert Review values
("R1","11","5","IS fish"),
("R2","11","5","IS very good fish"),
("R3","44","4","good rocks"),
("R4","55","1","not edible"),
("R5","33","3","Not worth");

