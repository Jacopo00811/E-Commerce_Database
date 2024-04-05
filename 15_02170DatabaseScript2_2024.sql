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
-- If product is removed remove all its reviews and remove it from carts

DROP TRIGGER IF EXISTS RemoveReviews;
DELIMITER //
CREATE TRIGGER RemoveReviews BEFORE DELETE ON product
FOR EACH ROW
BEGIN
DELETE FROM Review where Review.ProductID= OLD.Productid;
DELETE FROM items where items.ProductID= OLD.Productid;
END//
DELIMITER ;


-- DELETE STATEMENT
DELETE FROM Product WHERE ProductID="33";
SELECT * FROM Review;
SELECT * FROM Items;

-- UPDATE STATEMENT
UPDATE Review
SET Rating = 5, Title = "Best fish Ever", Body = "I love rotten fish" 
WHERE ReviewID = "R4";
SELECT * FROM Review;





