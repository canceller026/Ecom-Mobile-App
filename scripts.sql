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

INSERT INTO User_Profile VALUES 
(1,'Doan Hong Khue','Go Vap District',1,1),
(2,'Pham Thanh Tam','Hoc Mon',1,2),
(3,'Vu Trung Thuc','District 9',1,3),
(4,'Do Thuy Van','District 5',2,4),
(5,'Doan Yen Dan','Tan Binh District',2,5),
(6,'Nguyen Phi Diep','District 5',2,6),
(7,'Le Huong Xuan','District 8',2,7),
(8,'Le The Doanh','District 2',2,8),
(9,'Ly Quang Huy','Thu Duc District',3,9),
(10,'Bui Gia Huy','Tan Phu District',3,10);
COMMIT;

INSERT INTO Category VALUES 
(1,'Clothing','Tailored clothing category includes suits/sports coats/trousers/formal wear'),
(2,'Cosmetic','Making for beauty especially of the complexion'),
(3,'Furniture','Objects kept in a house or other building to make it suitable or comfortable for living or working in.'),
(4,'Computer','An electronic device for storing and processing data typically in binary form according to instructions given to it in a variable program.'),
(5,'Electronic Devices','A device that is used for audio/video/text communication or any other type of computer or computer-like instrument');
COMMIT;

INSERT INTO Listing VALUES 
(1,'Buy','[6/9][Thu Duc] Need to buy Macbook Pro 2015',9),
(2,'Buy','[10/11][Thu Duc] Need to buy 5 screw drivers',10),
(3,'Buy','[20/10][Thu Duc] Need to buy Macbook Air 2017',10),
(4,'Sell','[20/10][Thu Duc] Need to sell Macbook Pro 2015',9),
(5,'Sell','[25/10][Thu Duc] Need to sell Iphone 14 PM',9),
(6,'Sell','[20/10][Thu Duc] Need to sell 4 screw drivers',10),
(7,'Buy','[25/11][Thu Duc] Need to buy Macbook Air 2017',10),
(8,'Sell','[26/12][Thu Duc] Need to sell used desk',9),
(9,'Sell','[24/12][Thu Duc] Need to sell used table',10),
(10,'Buy','[28/12][Thu Duc]  Need to buy chair' ,10);
COMMIT;

INSERT INTO Courier VALUES 
(1,'Hoang Dinh Trung'),
(2,'Pham Viet Khoa'),
(3,'Do Cong Thanh'),
(4,'Truong Phuc Thinh'),
(5,'Ho Van Thuy'),
(6,'Vo Xuan Tam'),
(7,'Le Hong Ha'),
(8,'Bui Dung Tri'),
(9,'Ngo Khanh Quynh'),
(10,'Ho Ngoc Han'); 
COMMIT;

INSERT INTO Shop VALUES 
(1,'Uniqlo','Shop stylish and comfortable clothes for women, men, kids and babies',5,4),
(2,'InnisFree','The first natural brand from Korea, is dedicated to sharing the clean and pure energy of nature for healthy beauty',4.8,5),
(3,'Ikea','A global home furnishing brand that brings affordability, design and comfort to people all over the world.',4.5,6),
(4,'NewEgg','The leading tech-focused e-retailer in North America, with a global reach in Europe, South America, Asia Pacific and the Middle East',3,7),
(5,'Toshiba','Specializes in the production of a wide variety of consumer and industry electronics, including appliances, digital media devices, semiconductors, memory chips, and integrated systems.',3.8,8);
COMMIT; 

INSERT INTO Product VALUES 
(1,'T-shirt','Clothing','A minimalistic Tshirt for winter',1,80,1,1),
(2,'Straight pants','Clothing','A denim pants with scratch12-7-2022es',1,200,1,1),
(3,'Toner','Cosmetic','A mid tier product with high user rating',1,42,2,2),
(4,'Lipstick','Cosmetic','A high tier lipstick with incredible tone and vibrant color',0,69,2,2),
(5,'Desk','Furniture','A minimalistic desk, great for office or home use',0,150,3,3),
(6,'Chair','Furniture','A duo with the minimalistic desk, great for office and home use',1,99,3,3),
(7,'Macbook pro','Computer','Our most powerful laptops, MacBook Pros are supercharged by M1 and M2 chips. Featuring Magic Keyboard, Touch ID, and brilliant Retina display.',1,1499,4,4),
(8,'Dell prebuilt','Computer','Our most powerful desktop, supercharged by Intel chips and nVidia graphics.',0,999,4,4),
(9,'Refridgerator','Electronic device','Toshiba Multi Door Refrigerator. Optimise the storage as per your need!',1,799,5,5),
(10,'Battery','Electronic device','A rechargeable battery with outstanding safety performance',1,6,5,5);
COMMIT;

INSERT INTO Orders VALUES 
(1,'2022-07-12',0,0,1,'CC',0,'2022-07-12',2,1),
(2,'2022-07-12',0,0,2,'DC',0,'2022-07-12',2,1),
(3,'2022-07-12',0,0,3,'PC',0,'2022-07-12',1,2),
(4,'2022-07-12',0,0,4,'CC',0,'2022-07-12',3,3),
(5,'2022-07-12',0,0,5,'CC',0,'2022-07-12',2,2);
COMMIT;

INSERT INTO Added VALUES 
(1,7,1),
(1,8,2),
(2,4,3),
(3,2,4),
(3,1,9),
(4,10,7),
(5,10,8);
COMMIT; 



---DEBUG---
CREATE DATABASE ECOM;
DROP DATABASE IF EXISTS ECOM;

SELECT * FROM courier;
SELECT * FROM orders;
