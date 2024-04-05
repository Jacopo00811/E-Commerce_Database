-- Give examples of a function, a procedure and a trigger and explain what they do. Give one example of each.

-- FUNCTION
-- Finds the total cost of a cart
DROP FUNCTION IF EXISTS Total_in_Cart;

DELIMITER //
CREATE FUNCTION Total_in_Cart(Cart_ID VARCHAR(320)) RETURNS DECIMAL(10,2)
BEGIN
DECLARE Result DECIMAL(10,2);
SELECT SUM(Price) INTO Result
FROM Items
JOIN Product ON Items.ProductID = Product.ProductID
WHERE CartID = Cart_ID
GROUP BY CartID;
RETURN Result;
END//
DELIMITER ;

SELECT Total_in_Cart('Cart01');




-- PROCEDURE
-- Buy items in cart. means empty cart and decress the stock of the products 
DROP PROCEDURE IF EXISTS Buy;
DELIMITER //
CREATE PROCEDURE Buy (IN Cart_ID VARCHAR(320))
BEGIN
UPDATE Product 
JOIN items ON Items.ProductID = Product.ProductID
SET Stock = stock-1
WHERE Product.ProductID IN (SELECT Items.ProductID FROM Items WHERE CartID=Cart_Id);
DELETE FROM Cart WHERE CartID = Cart_ID;
END//
DELIMITER ;


CALL Buy ("Cart03");
SELECT * FROM items;
SELECT productid, stock FROM product;
 
-- TRIGGER 
-- Changes all bad reviews to be good reviews

DROP TRIGGER IF EXISTS RemoveBaDReviews;
DELIMITER //
CREATE TRIGGER RemoveBaDReviews Before insert on Review
FOR EACH ROW
If New.rating=1 
-- then update Review Set rating =5 where ReviewID = new.ReviewID;
then SET NEW.rating=5;
Set New.Title = "10/10 Would buy again";
Set New.body= "The best purchase of my life would recomened, \n -Totaly real person";


END if//
DELIMITER ;


insert Review value  ("R6","11","1","IS very bad fish","This fish had awful flavor and consistancy","2000-04-03");
select * from Review;


-- DELETE STATEMENT
-- This statement shows you how you can drop a product from the website
DELETE FROM Product WHERE ProductID="33";
SELECT * FROM Review;
SELECT * FROM Items;

-- UPDATE STATEMENT
-- This statement shows how you can change a review of a product if you change your mind in the future
UPDATE Review
SET Rating = 5, Title = "Best fish Ever", Body = "I love rotten fish" 
WHERE ReviewID = "R4";
SELECT * FROM Review;





