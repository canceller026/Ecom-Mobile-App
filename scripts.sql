-- @block
CREATE TABLE User_Profile(
    id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    address TEXT,
    role VARCHAR(1) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Authen(
    id INT AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    h_password BINARY(32),
    user_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES User_Profile(id)
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
    FOREIGN KEY (poster_id) REFERENCES User_Profile(id) 
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
    FOREIGN KEY (owner_id) REFERENCES User_Profile(id)
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
    FOREIGN KEY (shop_id) REFERENCES Shop(id),
    FOREIGN KEY (cat_id) REFERENCES Category(id)
);

CREATE TABLE Orders(
    id INT AUTO_INCREMENT,
    created_date DATE,
    order_status BOOLEAN,
    total FLOAT,
    payment_id INT,
    payment_type VARCHAR(255),
    ETA DATE,
    owner_id INT NOT NULL,
    courier_id INT NOT NULL, 
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES User_Profile(id),
    FOREIGN KEY (courier_id) REFERENCES Courier(id)
); 
CREATE TABLE Added(
    order_id INT,       
    product_id INT, 
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (order_id) REFERENCES Product(id)
);


/*
DELIMITER //
CREATE PROCEDURE listAllProductOfCategory ( C char(10) )
BEGIN
    SELECT P.id, P.pro_name, p.price
    FROM Product as P, Category as Ca
    WHERE (P.cat_id = Ca.id & Ca.cat_name = C);
END
//

---List all the orders where user U is the buyer---
CREATE PROCEDURE listAllOrder ( U char(10) )
BEGIN
    SELECT O.id
    FROM Orders as O, User
    WHERE (O.owner_id = USER.id & USER.name = U);
END
//

---List all the products shop S is selling---
CREATE PROCEDURE listAllProductOfShop ( S char(10) )
BEGIN
    SELECT Product.id, Product.pro_name, Product.price
    FROM Shop, Product
    WHERE (Product.shop_id = Shop.id & Shop.shop_name = S);
END
//

---List the products shop S is selling whose price is between A and B---
    CREATE PROCEDURE listAllProductInRange ( S char(10), A INT, B INT )
    BEGIN
        SELECT Product.id, Product.pro_name, Product.price
        FROM Shop, Product
        WHERE (Product.shop_id = Shop.id & Shop.shop_name = S & Product.Price > A & Product.Price < B); 
    END
    //

---Show all listing of user U:---
CREATE PROCEDURE listAllListing ( U char(50) )
BEGIN
    SELECT DISTINCT Listing.id, Listing.list_type, Listing.list_description
    FROM Listing, User
    WHERE (Listing.poster_id = User.id & User.name = U); 
END
//

DELIMITER;
*/

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
