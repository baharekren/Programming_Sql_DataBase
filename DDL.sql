

CREATE DATABASE EShopDB;  -- we create database
USE EShopDB

CREATE TABLE Categories ( -- creating table
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,  -- giving ID because it is necessary
    CategoryName NVARCHAR(100) NOT NULL,       -- category name
    Description NVARCHAR(255) NULL,            -- optional description
    CreatedAt DATETIME DEFAULT GETDATE(),      -- creating date time and by default gatedate we get exact time when it was created
    UpdatedAt DATETIME NULL,                    -- creating last update of date time
    CONSTRAINT UQ_CategoryName UNIQUE (CategoryName)--making category names unique
);

CREATE INDEX IDX_CategoryName ON Categories (CategoryName);



CREATE TABLE Products (  
    ProductID INT IDENTITY(1,1) PRIMARY KEY,    
    ProductName NVARCHAR(100) NOT NULL,         
    Price DECIMAL(18, 2) NOT NULL,              
    StockQuantity INT DEFAULT 0,                
    CategoryID INT,                            
    CreatedAt DATETIME DEFAULT GETDATE(),       
    UpdatedAt DATETIME NULL,                    
    CONSTRAINT FK_Category FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT UQ_ProductName UNIQUE (ProductName),  
    CONSTRAINT CHK_Price_GreaterThanZero CHECK (Price > 0), -- when we create data the price for it have to be bigger than 0
    CONSTRAINT CHK_Stock_GreaterThanZero CHECK (StockQuantity > 0)
);

CREATE INDEX IDX_ProductName ON Products (ProductName);
CREATE INDEX IDX_Price ON Products (Price);
CREATE INDEX IDX_StockQuantity ON Products (StockQuantity);



-- Manipulation of Tables 

ALTER TABLE Categories
ALTER COLUMN CategoryName NVARCHAR(150) NOT NULL;

ALTER TABLE Categories
ADD Status BIT NOT NULL DEFAULT 1

ALTER TABLE Products
ADD Status BIT NOT NULL DEFAULT 1

-- SEED DATA

-- Seeding category
INSERT INTO Categories(CategoryName, Description)
VALUES ('Boxing gloves', 'Best boxing gloves')

INSERT INTO Categories(CategoryName, Description)
VALUES ('Punching bags', 'Best punching bags')

INSERT INTO Categories(CategoryName, Description)
VALUES ('Equipment', 'Best equipmnet')

-- Seeding product
INSERT INTO Products(ProductName, StockQuantity, Price, CategoryID)
VALUES ('Everlast pro box gloves', 200, 12.4, 1)

INSERT INTO Products(ProductName, StockQuantity, Price, CategoryID)
VALUES ('Everlast heavy bag', 200, 15.5, 2)

INSERT INTO Products(ProductName, StockQuantity, Price, CategoryID)
VALUES ('Everlast handwrapped', 300, 11.2, 3)
-- Update record
UPDATE Categories
SET CategoryName ='Protective equipment'
WHERE CategoryID = 3;

select * from Categories