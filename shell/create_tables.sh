#!/bin/sh
#export
LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib
sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"<<EOF
CREATE TABLE retail_store(
        Cash DECIMAL(19, 4),
        Address VARCHAR2(32) PRIMARY KEY
);

CREATE TABLE manager(
        Email VARCHAR2(32) UNIQUE,
        Phone VARCHAR2(16) UNIQUE,
        Address VARCHAR2(32),
        Username VARCHAR2(16) NOT NULL UNIQUE,
        Password VARCHAR2(16) NOT NULL,
        ID VARCHAR2(8) PRIMARY KEY,
        FullName VARCHAR2(16) NOT NULL,
        InvoiceInfo VARCHAR2(16),
        HourlyRate DECIMAL(19, 4) DEFAULT 11.06,
        HoursWorked INT DEFAULT 0,
        CONSTRAINT CHK_Mngr_Credentials_Security CHECK(Username != Password),
        STOREID VARCHAR2(32) REFERENCES retail_store(Address)
);

CREATE TABLE employee(
        Email VARCHAR2(32) UNIQUE,
        Phone VARCHAR2(16) UNIQUE,
        Address VARCHAR2(32),
        Username VARCHAR2(16) NOT NULL UNIQUE,
        Password VARCHAR2(16) NOT NULL,
        ID VARCHAR2(8) PRIMARY KEY,
        FullName VARCHAR2(16) NOT NULL,
        InvoiceInfo VARCHAR2(16),
        HourlyRate DECIMAL(19, 4) DEFAULT 11.06,
        HoursWorked INT DEFAULT 0,
managerID VARCHAR2(8) REFERENCES manager(ID),
        CONSTRAINT CHK_Credentials_Security CHECK(Username != Password AND LENGTH(Username)>3 AND LENGTH(Password)>6),
        STOREID VARCHAR2(32) REFERENCES retail_store(Address)
);

CREATE TABLE admin(
AdminUsername VARCHAR2(16),
AdminPassword  VARCHAR2(16),
        Email VARCHAR2(32) UNIQUE,
        Phone VARCHAR2(16) UNIQUE,
        Address VARCHAR2(32),
        Username VARCHAR2(16) NOT NULL UNIQUE,
        Password VARCHAR2(16) NOT NULL,
        ID VARCHAR2(8) PRIMARY KEY,
        FullName VARCHAR2(16) NOT NULL,
        InvoiceInfo VARCHAR2(16),
        HourlyRate DECIMAL(19, 4) DEFAULT 11.06,
        HoursWorked INT DEFAULT 0,
        CONSTRAINT CHK_Admin_Credentials_Security CHECK(AdminUsername != Username AND AdminUsername != AdminPassword AND LENGTH(Username)>3 AND LENGTH(Password)>6 AND Username != Password AND LENGTH(Username)>3 AND LENGTH(Password)>6)
);


CREATE TABLE transaction(
        ID VARCHAR2(8) PRIMARY KEY,
        RegisterNumber VARCHAR2(8) NOT NULL,
        --Transaction_Date DATE NOT NULL,
        TransactionTime TIMESTAMP NOT NULL,
        PaymentMethod VARCHAR2(32) NOT NULL,
        STOREID VARCHAR2(32) REFERENCES retail_store(Address)
);

CREATE TABLE promotion(
        ID VARCHAR2(8) PRIMARY KEY,
        --StartDate DATE,
        --EndDate DATE,
        StartTime TIMESTAMP,
        EndTime TIMESTAMP,
        DiscountPercentage INT NOT NULL
);

CREATE TABLE tag(
        Name VARCHAR2(32) PRIMARY KEY
);

CREATE TABLE rewards_customer(
        FullName VARCHAR2(16),
        ID VARCHAR2(16) PRIMARY KEY,
        Password VARCHAR2(16) NOT NULL,
        Phone VARCHAR2(16),
        Email VARCHAR2(32) NOT NULL UNIQUE,
        PaymentInfo VARCHAR2(16),
        RewardPoints INT DEFAULT 0,
        CONSTRAINT CHK_Cstmr_Credentials_Security CHECK(LENGTH(Password)>6)
);
CREATE TABLE warehouse(
        Address VARCHAR2(32) PRIMARY KEY
);
CREATE TABLE product(
        Name VARCHAR2(32),
        ID VARCHAR2(8) PRIMARY KEY,
        Price DECIMAL(19, 4) DEFAULT NULL
);

CREATE TABLE employee_shift(
        ID VARCHAR2(8) PRIMARY KEY,
        StartTime TIMESTAMP, -- DEFAULT '09:00:00',
        EndTime TIMESTAMP, -- DEFAULT '17:00:00',
        STOREID VARCHAR2(32) REFERENCES retail_store(Address)
);

/*Relationship tables*/

/*What employees are assigned to a shift?*/
CREATE TABLE employee_shift_employee(
        ShiftID VARCHAR(8) REFERENCES employee_shift(ID),
        EmployeeID VARCHAR2(8) REFERENCES employee(ID),
        AssignedTask VARCHAR2(64),
        PRIMARY KEY(ShiftID, EmployeeID)
);

/*What warehouses are authorized to stock inventory of a store?*/
CREATE TABLE warehouse_retail_store(
        StoreLocation VARCHAR2(32) REFERENCES retail_store(Address),
        WarehouseLocation VARCHAR2(32) REFERENCES warehouse(Address),
        PRIMARY KEY(StoreLocation, WarehouseLocation)
);

/*What products are contained at a store location?*/
CREATE TABLE retail_store_product(
        StoreLocation VARCHAR2(32) REFERENCES retail_store(Address),
        ProductID VARCHAR2(8) REFERENCES product(ID),
        Quantity INT DEFAULT 0,
        CONSTRAINT CHK_Retail_Quantity CHECK (Quantity>=0),
        PRIMARY KEY(StoreLocation, ProductID)
);

/*What products are contained at a warehouse?*/
CREATE TABLE warehouse_product(
        WarehouseLocation VARCHAR2(32) REFERENCES warehouse(Address),
        ProductID VARCHAR2(8) REFERENCES product(ID),
        Quantity INT DEFAULT 0,
        CONSTRAINT CHK_Warehouse_Quantity CHECK (Quantity>=0),
        PRIMARY KEY(WarehouseLocation, ProductID)
);

/*What products were included in a transaction?*/
CREATE TABLE transaction_product(
        TransactionID VARCHAR2(8) REFERENCES transaction(ID),
        ProductID VARCHAR2(8) REFERENCES product(ID),
        Quantity INT DEFAULT 0,
        CONSTRAINT CHK_Quantity CHECK (Quantity>=0),
        PRIMARY KEY(TransactionID, ProductID),
        CUSTOMER VARCHAR2(16) REFERENCES rewards_customer(ID)
);

/*What discounts were applied to a transaction?*/
CREATE TABLE transaction_promotion(
        TransactionID VARCHAR2(8) REFERENCES transaction(ID),
        PromotionID VARCHAR2(8) REFERENCES promotion(ID),
        PRIMARY KEY(TransactionID, PromotionID)
);

/*What types of products does a discount affect?*/
CREATE TABLE promotion_tag(
        PromotionID VARCHAR2(8) REFERENCES promotion(ID),
        Tag VARCHAR2(32) REFERENCES tag(name),
        PRIMARY KEY(PromotionID, Tag)
);

/*What type of product is this?*/
CREATE TABLE product_tag(
        ProductID VARCHAR2(8) REFERENCES product(ID),
        Tag VARCHAR2(32) REFERENCES tag(name),
        PRIMARY KEY(ProductID, Tag)
);

/*views*/

DROP VIEW experienced_employees;
CREATE VIEW experienced_employees(ID, Name, Store, Hours) AS
(SELECT ID, FullName, STOREID, HoursWorked
FROM employee
WHERE HoursWorked > 199);

DROP VIEW need_restock;
CREATE VIEW need_restock(StoreLocation, ProductID, Quantity)
AS (SELECT StoreLocation, ProductID, Quantity
FROM retail_store_product
WHERE Quantity <= 50);

DROP VIEW active_promotions;
CREATE VIEW active_promotions(PromotionID, Percentage, EndsOn)
AS (SELECT p.ID, p.DiscountPercentage, p.EndTime
FROM promotion p
WHERE (SELECT CURRENT_TIMESTAMP FROM dual) > p.StartTime
AND (SELECT CURRENT_TIMESTAMP FROM dual) < p.EndTime);

exit;
EOF
