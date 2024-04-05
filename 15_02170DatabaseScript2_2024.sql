--Queries:
SELECT CustomerEmail, CartID, COUNT(DISTINCT ProductID) AS Products,SUM(price) AS $Total 
FROM creates NATURAL JOIN cart NATURAL JOIN items NATURAL JOIN product
GROUP BY CartID

-- Get reviews ordered by review id
SELECT ReviewID,ProductID,ProductName,Rating,Title,body,reviewDate 
FROM Review NATURAL JOIN Product 
WHERE ProductID IN (11)
ORDER BY reviewDate

-- Get the average starrating of Products
SELECT ProductName,AVG(Rating) 
FROM Review NATURAL JOIN Product 
GROUP BY ProductID
HAVING AVG(Rating) > 2






-- Give examples of a function, a procedure and a trigger and explain what they do. Give one example of each.

-- FUNCTION
-- Finds the total cost of a cart
drop function if exists Total_in_Cart;

DELIMITER //
Create function Total_in_Cart(Cart_ID VARCHAR(320)) returns decimal(10,2)
Begin
Declare Result decimal(10,2);
SELECT SUM(Price) into Result
FROM Items
JOIN Product ON Items.ProductID = Product.ProductID
WHERE CartID = Cart_ID
GROUP BY CartID;
return Result;
end//
DELIMITER ;

SELECT Total_in_Cart('Cart01');




-- PROCEDURE
-- Buy items in cart. means empty cart and decress the stock of the products 
drop PROCEDURE if exists Buy;
DELIMITER //
CREATE PROCEDURE Buy (IN Cart_ID VARCHAR(320))
BEGIN
UPDATE Product 
JOIN items ON Items.ProductID = Product.ProductID
SET Stock = stock-1
WHERE Product.ProductID in (SELECT Items.ProductID FROM Items WHERE CartID=Cart_Id);
DELETE FROM Cart WHERE CartID = Cart_ID;
end//
DELIMITER ;


call Buy ("Cart03");
select * from items;
select productid, stock from product;
 
-- TRIGGER 
-- If product is removed remove all its reviews and remove it from carts

drop trigger if exists RemoveReviews;
DELIMITER //
create trigger RemoveReviews before delete on product
For each row
BEGIN
DELETE FROM Review where Review.ProductID= OLD.Productid;
DELETE FROM items where items.ProductID= OLD.Productid;
end//
DELIMITER ;



delete from Product where ProductID="33";
Select * from Review;
select * from Items;






