CREATE DATABASE InventoryDB;
USE InventoryDB;
-- Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    ContactEmail VARCHAR(100),
    PhoneNumber VARCHAR(20)
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Inventory Table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    QuantityInStock INT DEFAULT 0,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    OrderDate DATE NOT NULL,
    Quantity INT NOT NULL,
    Type ENUM('Purchase', 'Restock') NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- Insert Suppliers
INSERT INTO Suppliers (Name, ContactEmail, PhoneNumber)
VALUES 
('Tech Supplies Co.', 'contact@techsupplies.com', '123-456-7890'),
('Office Depot', 'sales@officedepot.com', '987-654-3210');

-- Insert Products
INSERT INTO Products (Name, Description, Price, SupplierID)
VALUES 
('Wireless Mouse', 'Ergonomic wireless mouse', 15.99, 1),
('Keyboard', 'Mechanical keyboard', 29.99, 2);

-- Insert Inventory
INSERT INTO Inventory (ProductID, QuantityInStock)
VALUES 
(1, 100),
(2, 75);

-- Insert Orders
INSERT INTO Orders (ProductID, OrderDate, Quantity, Type)
VALUES 
(1, '2025-05-10', 10, 'Purchase'),
(2, '2025-05-12', 15, 'Restock');
SELECT p.Name, i.QuantityInStock, i.LastUpdated
FROM Products p
JOIN Inventory i ON p.ProductID = i.ProductID;
SELECT o.OrderID, p.Name AS Product, o.Type, o.Quantity, o.OrderDate
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID;
-- Deduct 5 from Wireless Mouse
UPDATE Inventory
SET QuantityInStock = QuantityInStock - 5,
    LastUpdated = CURRENT_TIMESTAMP
WHERE ProductID = 1;
-- Add 20 to Keyboard
UPDATE Inventory
SET QuantityInStock = QuantityInStock + 20,
    LastUpdated = CURRENT_TIMESTAMP
WHERE ProductID = 2;
