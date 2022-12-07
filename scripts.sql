-- @block

---TABLE CREATION---
CREATE TABLE User_Profile(
    id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    address TEXT,
    role VARCHAR(1) NOT NULL,
    user_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES auth_user(id) ON DELETE CASCADE
);

CREATE TABLE Category(
    id INT AUTO_INCREMENT,
    cat_name VARCHAR(255) NOT NULL UNIQUE,
    cat_description TEXT,
    PRIMARY KEY (id)
);

CREATE TABLE Listing(
    id INT AUTO_INCREMENT,
    list_type VARCHAR(255),
    list_description TEXT,
    poster_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (poster_id) REFERENCES User_Profile(id) ON DELETE CASCADE
);

CREATE TABLE Courier(
    id INT AUTO_INCREMENT,
    cour_name VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE Shop(
    id INT AUTO_INCREMENT,
    shop_name VARCHAR(255) NOT NULL,
    shop_description TEXT,
    rating FLOAT DEFAULT 0.0,
    owner_id INT,
    PRIMARY KEY (id), 
    FOREIGN KEY (owner_id) REFERENCES User_Profile(id) ON DELETE CASCADE
);

CREATE TABLE Product(
    id INT AUTO_INCREMENT,
    pro_name VARCHAR(255) NOT NULL UNIQUE,
    pro_type VARCHAR(255),
    pro_description TEXT,
    pro_status BOOLEAN,
    price FLOAT,
    shop_id INT,
    cat_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (shop_id) REFERENCES Shop(id) ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES Category(id) ON DELETE CASCADE
);

CREATE TABLE Orders(
    id INT AUTO_INCREMENT,
    created_date DATE,
    order_status BOOLEAN,
    total FLOAT DEFAULT 0.0,
    payment_id INT,
    payment_type VARCHAR(255),
    quantity INT DEFAULT 0,
    ETA DATE,
    owner_id INT NOT NULL,
    courier_id INT NOT NULL, 
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES User_Profile(id) ON DELETE CASCADE,
    FOREIGN KEY (courier_id) REFERENCES Courier(id) ON DELETE CASCADE
);

CREATE TABLE Added(
    order_id INT,       
    product_id INT, 
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES Product(id) ON DELETE CASCADE
);

---DATABASE OPERATIONS---
UPDATE User_Profile SET User_Profile.Address = "Go Vap District" WHERE User_Profile.id = 9;
SELECT * FROM User_Profile;

DELETE FROM Listing WHERE Listing.poster_id = 9;
SELECT * FROM Listing;
---PROCEDURE---
DELIMITER //
CREATE PROCEDURE listAllProductOfCategory ( C char(10) )
BEGIN
    SELECT P.id, P.pro_name, p.price
    FROM Product as P, Category as Ca
    WHERE (P.cat_id = Ca.id AND Ca.cat_name = C);
END
//

CREATE PROCEDURE listAllOrder ( U char(10) )
BEGIN
    SELECT O.id, O.total, O.quantity, O.payment_id, O.payment_type, O.ETA, O.order_status
    FROM Orders as O, auth_user
    WHERE (O.owner_id = auth_user.id AND auth_user.username = U);
END
//


CREATE PROCEDURE listAllProductOfShop ( S char(10) )
BEGIN
    SELECT Product.id, Product.pro_name, Product.price
    FROM Shop, Product
    WHERE (Product.shop_id = Shop.id AND Shop.shop_name = S);
END
//

CREATE PROCEDURE listAllProductInRange ( S char(10), A INT, B INT )
BEGIN
    SELECT Product.id, Product.pro_name, Product.price
    FROM Shop, Product
    WHERE (Product.shop_id = Shop.id AND Shop.shop_name = S AND Product.Price > A AND Product.Price < B); 
END
//

CREATE PROCEDURE listAllListing ( U char(50) )
BEGIN
    SELECT DISTINCT Listing.id, Listing.list_type, Listing.list_description
    FROM Listing, User_Profile
    WHERE (Listing.poster_id = User_Profile.id AND User_Profile.name = U); 
END
//


CREATE PROCEDURE listAllProductOfCategoryWithRating ( Ca char(50), R FLOAT )
BEGIN
    SELECT DISTINCT Product.id, Product.pro_name, Product.price
    FROM Category, Shop, Product
    WHERE (Shop.Rating > R AND Shop.id = Product.shop_id AND Category.cat_name = Ca AND Category.id = Product.cat_id);
END
//


CREATE PROCEDURE listAllShopCourierStop( Co INT)
BEGIN
    SELECT DISTINCT Shop.id, Shop.shop_name
    FROM Shop, Product, Added, Orders
    WHERE (Added.product_id = Product.id AND Product.shop_id = Shop.id AND Added.order_id  = Orders.id AND Orders.courier_id = Co);
END
//


CREATE PROCEDURE listAllOrdersOfShop( S char(50))
BEGIN
    SELECT DISTINCT Orders.id, Orders.order_status, Orders.total_cost, Orders.quantity, Orders.owner_id, Orders.courier_id
    FROM Shop, Product, Added, Orders
    WHERE (Shop.shop_name = S AND Added.product_id = Product.id AND Product.shop_id = Shop.id AND Added.order_id  = Orders.id);
END
// 

---PROCEDURE TESTING---
CALL listAllProductOfCategory('Computer');
CALL listAllOrder('user2');
CALL listAllOrderOfShop('Ikea');
CALL listAllProductInRange('Ikea',100,149);
CALL listAllProductInRange('Ikea',98,151);
CALL listAllListing("Bui Gia Huy");
CALL listAllShopCourierStop(2);
CALL listAllProductOfCategoryWithRating("Computer",3.5);
CALL listAllProductOfCategoryWithRating("Clothing",4.5);
---CREATE TRIGGER---
CREATE TRIGGER quantity_up AFTER INSERT ON ADDED
FOR EACH ROW
BEGIN
UPDATE Orders
SET Orders.quantity = Orders.quantity + 1
WHERE NEW.order_id = Orders.id;
END
//


CREATE TRIGGER total_up AFTER INSERT ON ADDED
FOR EACH ROW
BEGIN
UPDATE Orders
SET Orders.total = Orders.total + (SELECT Product.Price FROM Product WHERE NEW.product_id = Product.id) *NEW.quantity
WHERE NEW.order_id = Orders.id;
END
//

CREATE TRIGGER quantity_down AFTER DELETE ON ADDED
FOR EACH ROW
BEGIN
UPDATE Orders
SET Orders.quantity = Orders.quantity - 1
WHERE OLD.order_id = Orders.id;
END
//


CREATE TRIGGER total_down AFTER DELETE ON ADDED
FOR EACH ROW
BEGIN
UPDATE Orders
SET Orders.total = Orders.total - (SELECT Product.Price FROM Product WHERE OLD.product_id = Product.id) *OLD.quantity
WHERE OLD.order_id = Orders.id;
END
//

DELIMITER;
*/
---TRIGGER TESTING---
INSERT INTO ADDED VALUES (2,3,4)
SELECT * FROM ORDERS WHERE ORDERS.id = 2;

DELETE FROM ADDED WHERE ADDED.product_id = 3;
SELECT * FROM ORDERS WHERE ORDERS.id = 2;

---INSERT DATA---


INSERT INTO ADDED VALUES (1,7,1);
INSERT INTO ADDED VALUES (1,8,2);
INSERT INTO ADDED VALUES (2,4,3);
INSERT INTO ADDED VALUES (3,2,4);
INSERT INTO ADDED VALUES (3,1,9);
INSERT INTO ADDED VALUES (4,10,7);
INSERT INTO ADDED VALUES (5,10,8);


---DEBUG---
CREATE DATABASE ECOM;
DROP DATABASE IF EXISTS ECOM;

SELECT * FROM courier;
SELECT * FROM orders;
