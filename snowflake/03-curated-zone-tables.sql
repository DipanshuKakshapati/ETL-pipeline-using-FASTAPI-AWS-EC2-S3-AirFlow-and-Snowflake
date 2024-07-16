-- Set the current schema to nepse.curated_zone for table creation
USE SCHEMA nepse.curated_zone;

-- Create a transient table for date data with autoincremented serial number
CREATE OR REPLACE TRANSIENT TABLE curated_date (
    SN_BUSINESS_DATE_ID INT AUTOINCREMENT,
    BUSINESS_DATE DATE PRIMARY KEY,
    YEAR INT,
    MONTH INT,
    WEEK INT,
    DAY INT
) comment = 'this is a curated_date table in curated schema';

-- Create a transient table for price data with autoincremented serial number
CREATE OR REPLACE TRANSIENT TABLE curated_price (
    SN_PRICE_ID INT AUTOINCREMENT,
    SECURITY_ID VARCHAR,
    OPEN_PRICE FLOAT,
    HIGH_PRICE FLOAT,
    LOW_PRICE FLOAT,
    CLOSE_PRICE FLOAT,
    LAST_UPDATED_PRICE VARCHAR,
    PREVIOUS_DAY_PRICE FLOAT,
    PRICE_ID VARCHAR PRIMARY KEY
) comment = 'this is a curated_price table in curated schema';

-- Create a transient table for security data with autoincremented serial number
CREATE OR REPLACE TRANSIENT TABLE curated_security (
    SN_SECURITY_ID INT AUTOINCREMENT,
    SECURITY_ID VARCHAR,
    MARCKET_CAPITALIZATION FLOAT,
    FIFTY_TWO_WEEKS_HIGH FLOAT,
    FIFTY_TWO_WEEKS_LOW FLOAT,
    SECURITY_STOCK_ID VARCHAR PRIMARY KEY
) comment = 'this is a curated_security table in curated schema';

-- Create a transient table for stock data that links to other curated tables
CREATE OR REPLACE TRANSIENT TABLE curated_stock (
    SN_STOCK_ID INT AUTOINCREMENT,
    SECURITY_ID VARCHAR,
    BUSINESS_DATE DATE FOREIGN KEY REFERENCES curated_date(BUSINESS_DATE),
    TOTAL_TRADED_QUANTITY NUMBER,
    CLOSE_PRICE FLOAT,
    LAST_UPDATED_PRICE VARCHAR,
    TOTAL_TRADES NUMBER,
    AVERAGE_TRADED_PRICE FLOAT,
    SECURITY_STOCK_ID VARCHAR FOREIGN KEY REFERENCES curated_security(SECURITY_STOCK_ID),
    PRICE_ID VARCHAR FOREIGN KEY REFERENCES curated_price(PRICE_ID)
) comment = 'this is a curated_stock table in curated schema';

-- Display all tables in the current schema to verify creation
SHOW TABLES;
