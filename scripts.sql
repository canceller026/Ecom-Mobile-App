-- @block
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


/*
DELIMITER //
CREATE PROCEDURE listAllProductOfCategory ( C char(10) )
BEGIN
    SELECT P.id, P.pro_name, p.price
    FROM Product as P, Category as Ca
    WHERE (P.cat_id = Ca.id AND Ca.cat_name = C);
END
//

---List all the orders where user U is the buyer---
CREATE PROCEDURE listAllOrder ( U char(10) )
BEGIN
    SELECT O.id
    FROM Orders as O, User_Profile
    WHERE (O.owner_id = User_Profile.id AND User_Profile.name = U);
END
//

---List all the products shop S is selling---
CREATE PROCEDURE listAllProductOfShop ( S char(10) )
BEGIN
    SELECT Product.id, Product.pro_name, Product.price
    FROM Shop, Product
    WHERE (Product.shop_id = Shop.id AND Shop.shop_name = S);
END
//

---List the products shop S is selling whose price is between A and B---
CREATE PROCEDURE listAllProductInRange ( S char(10), A INT, B INT )
BEGIN
    SELECT Product.id, Product.pro_name, Product.price
    FROM Shop, Product
    WHERE (Product.shop_id = Shop.id AND Shop.shop_name = S AND Product.Price > A AND Product.Price < B); 
END
    //

---Show all listing of user U:---
CREATE PROCEDURE listAllListing ( U char(50) )
BEGIN
    SELECT DISTINCT Listing.id, Listing.list_type, Listing.list_description
    FROM Listing, User_Profile
    WHERE (Listing.poster_id = User_Profile.id AND User_Profile.name = U); 
END
//

---List all products of category Ca that comes from a shop whose rating is R at least:---
CREATE PROCEDURE listAllProductOfCategoryWithRating ( Ca char(50), R FLOAT )
BEGIN
    SELECT DISTINCT Listing.id, Listing.list_type, Listing.list_description
    FROM Category, Shop, Product
    WHERE (Shop.Rating > R AND Shop.id = Product.shop_id AND Category.cat_name = Ca AND Category.id = Product.cat_id);
END
//

---List all the shop have order shipped by courrier Co---
CREATE PROCEDURE listAllShopCourierStop( Co char(50))
BEGIN
    SELECT DISTINCT Shop.id, Shop.shop_name
    FROM Shop, Product, Added, Orders
    WHERE (Added.product_id = Product.id AND Product.shop_id = Shop.id AND Added.order_id  = Orders.id AND Orders.courier_id = Co);
END
//

---List all the orders where shop S is the seller---
CREATE PROCEDURE listAllOrdersOfShop( S char(50))
BEGIN
    SELECT DISTINCT Orders.id, Orders.order_status
    FROM Shop, Product, Added, Orders
    WHERE (Shop.shop_name = S AND Added.product_id = Product.id AND Product.shop_id = Shop.id AND Added.order_id  = Orders.id);
END
// 
---UPDATE quantity of order on Insert of Added---
CREATE TRIGGER quantity_up AFTER INSERT ON ADDED
FOR EACH ROW
BEGIN
UPDATE Orders
SET Orders.quantity = Orders.quantity + 1
WHERE Added.order_id = Orders.id;
END
//

---UPDATE total cost of order on Insert of Added---
CREATE TRIGGER total_up AFTER INSERT ON ADDED
FOR EACH ROW
BEGIN
UPDATE Orders
SET Orders.total = Orders.total + Product.price*Added.quantity
WHERE Added.order_id = Orders.id AND Added.product_id = Product.id;
END
//
---UPDATE quantity of order on Delete of Added---
CREATE TRIGGER quantity_up AFTER DELETE ON ADDED
FOR EACH ROW
BEGIN
UPDATE Orders
SET Orders.quantity = Orders.quantity - 1
WHERE Added.order_id = Orders.id;
END
//

---UPDATE total cost of order on Delete of Added---
CREATE TRIGGER total_up AFTER DELETE ON ADDED
FOR EACH ROW
BEGIN
UPDATE Orders
SET Orders.total = Orders.total - Product.price*Added.quantity
WHERE Added.order_id = Orders.id AND Added.product_id = Product.id;
END
//    
DELIMITER;
*/
INSERT INTO auth_user (id, password, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES(1,"123", FALSE, "minhdat01","Phan","Dat","dat.phanpan7@hcmut.edu.vn", 1,1,'2022-12-8');
INSERT INTO auth_user (id, password, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES(2,"123", FALSE, "minhdat012","Phan","Dat","dat.phanpan7@hcmut.edu.vn", 1,1,'2022-12-8');
INSERT INTO auth_user (id, password, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES(3,"123", FALSE, "minhdat0123","Phan","Dat","dat.phanpan7@hcmut.edu.vn", 1,1,'2022-12-8');
INSERT INTO auth_user (id, password, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES(4,"123", FALSE, "minhdat01234","Phan","Dat","dat.phanpan7@hcmut.edu.vn", 1,1,'2022-12-8');
INSERT INTO auth_user (id, password, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES(5,"123", FALSE, "minhdat0134","Phan","Dat","dat.phanpan7@hcmut.edu.vn", 1,1,'2022-12-8');


INSERT INTO User_Profile VALUES (1,'abc','xyz','b');
INSERT INTO User_Profile VALUES (2,'Pham Van A','TPHCM','b');
INSERT INTO User_Profile VALUES (3,'Tran Van B','TPHCM','b');
INSERT INTO User_Profile VALUES (4,'Phan Thi C','Hai Phong','v');
INSERT INTO User_Profile VALUES (5,'Nguyen Quoc Chan','Ha Noi','s');

INSERT INTO SHOP VALUES (1,'Trang Nemo','Ban my pham',4.6, 4);
INSERT INTO SHOP VALUES (2,'Louis Vuitton','Ban Quan Ao',3.0,4);
INSERT INTO SHOP VALUES (3,'Sony','Ban thiet bi dien tu',4.9,4);
INSERT INTO SHOP VALUES (4,'Phong Vu','Ban Linh kien may tinh',2.4,4);
INSERT INTO SHOP VALUES (5,'Circle K','Cua hang tien loi',5.0,4);

INSERT INTO LISTING VALUES (1,'Sell','Sell A',5);
INSERT INTO LISTING VALUES (2,'Sell','Sell B',5);
INSERT INTO LISTING VALUES (3,'Trade','Trade E for F',5);
INSERT INTO LISTING VALUES (4,'Buy','Want to Buy X',5);
INSERT INTO LISTING VALUES (5,'Sell','Sell Z',5);

INSERT INTO CATEGORY VALUES (1,'Linh Kien Dien Tu','');
INSERT INTO CATEGORY VALUES (2,'My Pham','');
INSERT INTO CATEGORY VALUES (3,'Quan APo','');
INSERT INTO CATEGORY VALUES (4,'Do Gia Dung','');
INSERT INTO CATEGORY VALUES (5,'Thuc pham','');

SELECT * FROM USER;
DROP PROCEDURE listAllListing;
DROP PROCEDURE listAllProductInRange;
DROP PROCEDURE listAllProductOfCategory;
DROP PROCEDURE listAllOrder;
DROP PROCEDURE listAllProductOfShop;

CREATE DATABASE ECOM;
DROP DATABASE IF EXISTS ECOM;