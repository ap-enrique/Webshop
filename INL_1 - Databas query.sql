SELECT Kund.name FROM Kund
JOIN Orders ON KUND.ID=Orders.Kund_ID
JOIN Order_Item ON Orders.ID=Order_Item.Order_ID
JOIN Produkt ON Order_Item.Produkt_ID=Produkt.ID
JOIN Brand ON Produkt.Brand_ID=Brand.ID
WHERE Produkt.Name='Byxor' AND Produkt.Storlek='38' AND Produkt.Color='Svart' AND Brand.Name='SweetPants';

-- Vi vill ha namn från Kund tabellen
-- Vi börjar med Tabellen Kund och sedan joina de andra tabeller
-- Först JOIN ör att kombinera matchning mellan Kund och Orders Tabellen och att de har samma KUND ID. För att se beställningar.
-- Andra JOIN adderar kombination matchning med Order_Item Tabellen där Orders ID matchar. För att se produkterna i beställningar.
-- Tredje JOIN adderar kombination matchning med Produkt Tabellen där produkt ID Matchar. För att se information om produkten.
-- Fjärde JOIN adderar kombination matchning med Brand Tabellen där brand ID matchar. För att se Märket som tillhör produkten.