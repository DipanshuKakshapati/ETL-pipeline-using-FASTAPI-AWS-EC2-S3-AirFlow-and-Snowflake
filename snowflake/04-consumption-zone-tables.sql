-- Set the current schema to nepse.consumption_zone for table creation
USE SCHEMA nepse.consumption_zone;

-- Create a table for dimensional date data with autoincremented serial number
CREATE OR REPLACE TABLE date_dim (
    SN_BUSINESS_DATE_ID INT AUTOINCREMENT,
    BUSINESS_DATE DATE PRIMARY KEY,
    YEAR INT,
    MONTH INT,
    WEEK INT,
    DAY INT
) comment = 'this is a date_dim table in consumption schema';

-- Create a table for dimensional price data with autoincremented serial number
CREATE OR REPLACE TABLE price_dim (
    SN_PRICE_ID INT AUTOINCREMENT,
    SECURITY_ID VARCHAR,
    OPEN_PRICE FLOAT,
    HIGH_PRICE FLOAT,
    LOW_PRICE FLOAT,
    CLOSE_PRICE FLOAT,
    LAST_UPDATED_PRICE VARCHAR,
    PREVIOUS_DAY_PRICE FLOAT,
    PRICE_ID VARCHAR PRIMARY KEY
) comment = 'this is a price_dim table in consumption schema';

-- Create a table for dimensional security data with autoincremented serial number
CREATE OR REPLACE TABLE security_dim (
    SN_SECURITY_ID INT AUTOINCREMENT,
    SECURITY_ID VARCHAR,
    MARCKET_CAPITALIZATION FLOAT,
    FIFTY_TWO_WEEKS_HIGH FLOAT,
    FIFTY_TWO_WEEKS_LOW FLOAT,
    SECURITY_STOCK_ID VARCHAR PRIMARY KEY
) comment = 'this is a security_dim table in consumption schema';

-- Create a table for factual stock data that links to the dimensional tables
CREATE OR REPLACE TABLE stock_fact (
    SN_STOCK_ID INT AUTOINCREMENT,
    SECURITY_ID VARCHAR,
    BUSINESS_DATE DATE FOREIGN KEY REFERENCES date_dim(BUSINESS_DATE),
    TOTAL_TRADED_QUANTITY NUMBER,
    CLOSE_PRICE FLOAT,
    LAST_UPDATED_PRICE VARCHAR,
    TOTAL_TRADES NUMBER,
    AVERAGE_TRADED_PRICE FLOAT,
    SECURITY_STOCK_ID VARCHAR FOREIGN KEY REFERENCES security_dim(SECURITY_STOCK_ID),
    PRICE_ID VARCHAR FOREIGN KEY REFERENCES price_dim(PRICE_ID),
    GBD_ADDED_TIMESTAMP TIMESTAMP_TZ default CONVERT_TIMEZONE('Asia/Kathmandu', current_timestamp()),
    GBD_UPDATED_TIMESTAMP TIMESTAMP_TZ default CONVERT_TIMEZONE('Asia/Kathmandu', current_timestamp()),
    GBD_ACTIVE_FLAG VARCHAR(1) default 'Y',
    GBD_ADDRESS VARCHAR default 'NEPAL'
) comment = 'this is a stock_fact table in consumption schema';

-- Display all tables in the current schema to verify creation
SHOW TABLES;



