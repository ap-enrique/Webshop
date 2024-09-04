drop database if exists webshop;
CREATE DATABASE webshop;
USE webshop;

CREATE TABLE Kund (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(25) NOT NULL,
	Email VARCHAR(50) NOT NULL,
	Address VARCHAR(50) NOT NULL
);

CREATE TABLE Brand (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(20) NOT NULL unique
);

CREATE TABLE Kategori (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(20) NOT NULL unique
);

CREATE TABLE Orders (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Datum DATE NOT NULL,
	Kund_ID INT,
	Createad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	Last_Update TIMESTAMP DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	FOREIGN KEY (Kund_ID) REFERENCES Kund(ID)
);

CREATE TABLE Produkt (
	ID INT AUTO_INCREMENT PRIMARY KEY,
	Name VARCHAR(25) NOT NULL,
	Storlek VARCHAR(5) NOT NULL,
	Color VARCHAR(20) NOT NULL,
	Price DECIMAL(10) NOT NULL,
	Stock INT NOT NULL,
	Brand_ID INT,
	FOREIGN KEY (Brand_ID) REFERENCES Brand(ID)
);

CREATE TABLE Order_Item (
	ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Quantity INT NOT NULL,
	Orders_ID INT,
	Produkt_ID INT,
	Createad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	Last_Update TIMESTAMP DEFAULT CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
	FOREIGN KEY (Orders_ID) REFERENCES Orders(ID),
	FOREIGN KEY (Produkt_ID) REFERENCES Produkt(ID)
);

CREATE TABLE Produkt_Kategori (
	Produkt_ID INT,
	Kategori_ID INT,
	FOREIGN KEY (Produkt_ID) REFERENCES Produkt(ID),
	FOREIGN KEY (Kategori_ID) REFERENCES Kategori(ID)
);

INSERT INTO Kund (Name, Email, Address) VALUES
('Enrique Alvarado', 'enrique.alvarado@example.com', 'Storgatan 1, Stockholm'),
('Elian Alvarado', 'elian.alvarado@example.com', 'Lillgatan 12, Göteborg'),
('Noelia Alvarado', 'noelia.alvarado@example.com', 'mellangatan 4, Malmö'),
('Esperanza Palomino', 'esperanza.palomino@example.com', 'södragatan 7, Uppsala'),
('Kerstin Nilsson', 'kerstin.nilsson@example.com', 'Norragatan 9, Lund');

INSERT INTO Brand (Name) VALUES
('Nike'),
('Levi\'s'),
('Adidas'),
('SweetPants'),
('Zara'),
('H&M');

INSERT INTO Produkt (Name, Storlek, Color, Price, Stock, Brand_ID) VALUES
('T-shirt', 'M', 'Röd', 199.00, 20, 1),  -- Nike
('Jeans', '32', 'Blå', 499.00, 15, (SELECT ID FROM Brand WHERE Name = 'Levi\'s')),
('Hoodie', 'L', 'Grå', 399.00, 25, (SELECT ID FROM Brand WHERE Name = 'Adidas')),
('Sneakers', '42', 'Vit', 799.00, 30, (SELECT ID FROM Brand WHERE Name = 'Nike')),
('Byxor', '38', 'Svart', 399.00, 15, (SELECT ID FROM Brand WHERE Name = 'SweetPants')),
('Shorts', 'M', 'Beige', 299.00, 20, 2), -- Levi's
('Klänning', 'S', 'Blå', 599.00, 18, (SELECT ID FROM Brand WHERE Name = 'Zara')),
('Skjorta', 'M', 'Vit', 349.00, 22, 6);  -- H&M

INSERT INTO Kategori (Name) VALUES
('Casual wear'),
('sportswear'),
('Outwear'),
('Footwear'),
('Formal wear');

INSERT INTO Produkt_Kategori (Produkt_ID, Kategori_ID) VALUES
(1, 1), -- T-shirt i Casual wear
(1, 2), -- T-shirt i Spportswear
(2, 1), -- Jeans i Casual wear
(3, 1), -- Hoodie i Casual wear
(3, 2), -- Hoodie i sportswear
(4, 2), -- Sneakers i sportswear
(4, 4), -- Sneakers i Footwear
(5, 1), -- Byxa i Casual wear
(5, 2), -- Byxa i sportswear
(5, 3), -- Byxa i Outwear
(6, 1), -- Shorts i Casual wear
(6, 2), -- Shorts i Sportswear
(7, 1), -- Klänning i Casual wear
(7, 5), -- Klänning i Formal wear
(8, 5); -- Skjorta i Formal wear

INSERT INTO Orders (Datum, Kund_ID) VALUES
('2024-08-20', 1), -- Enrique Alvarado
('2024-08-21', 2), -- Elian Alvarado
('2024-08-22', 3), -- Noelia Alvarado
('2024-08-23', 4), -- Esperanza Palomino
('2024-08-24', 5), -- Kerstin Nilsson
('2024-08-25', 1), -- Enrique Alvarado
('2024-08-26', 2); -- Elian Alvarado

INSERT INTO Order_Item (Quantity, Orders_ID, Produkt_ID) VALUES
(2, 1, 1), -- Antal 2 st, för Order 1 som tillhör Enrique Alvarado, och produkten är t-shirt
(1, 1, 2), -- Antal 1 st, för Order 1 som tillhör Enrique Alvarado, och produkten är jeans
(1, 2, 3), -- Antal 1 st, för Order 2 som tillhör Elian Alvarado, och produkten är hoodie
(1, 2, 4), -- Antal 1 st, för Order 2 som tillhör Elian Alvarado, och Produkten är sneakers
(1, 3, 5), -- Antal 1 st, för Order 3 som tillhör Noelia Alvarado, och produkten är byxa
(1, 3, 1), -- Antal 1 st, för Order 3 som tillhör Noelia Alvarado, och produkten är t-shirt
(1, 4, 6), -- Antal 1 st, för Order 4 som tillhör Esperanza Palomino, och produkten är shorts
(1, 4, 8), -- Antal 1 st, för Order 4 som tillhör Esperanza Palomino, och produkten är skjorta
(2, 5, 7), -- Antal 2 st, för Order 5 som tillhör Kerstin Nilsson, och produkten är klänning
(1, 5, 5), -- Antal 1 st, för Order 5 som tillhör Kerstin Nilsson, och produkten är byxa
(1, 6, 4), -- Antal 1 st, för Order 6 som tillhör Enrique Alvarado, och produkten är sneakers
(1, 6, 8), -- Antal 1 st, för Order 6 som tillhör Enrique Alvarado, och produkten är skjorta
(1, 7, (SELECT ID FROM produkt WHERE Name = 'Byxor' AND Storlek ='38' AND Color = 'Svart' AND Brand_ID = (SELECT ID FROM Brand WHERE Name = 'SweetPants')));

set sql_safe_updates = 0; -- slippa ha primär-nyckelvärde i where-sats vid tillfrågning.
