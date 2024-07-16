-- Set the current schema to nepse.landing_zone
USE SCHEMA nepse.landing_zone;

-- Create a transient table for storing date-related data
CREATE OR REPLACE TRANSIENT TABLE landing_date (
    BUSINESS_DATE VARCHAR PRIMARY KEY,
    YEAR VARCHAR,
    MONTH VARCHAR,
    WEEK VARCHAR,
    DAY VARCHAR
) comment = 'this is a landing_date table in landing schema';

-- Create a transient table for storing price-related data
CREATE OR REPLACE TRANSIENT TABLE landing_price (
    SECURITY_ID VARCHAR,
    OPEN_PRICE VARCHAR,
    HIGH_PRICE VARCHAR,
    LOW_PRICE VARCHAR,
    CLOSE_PRICE VARCHAR,
    LAST_UPDATED_PRICE VARCHAR,
    PREVIOUS_DAY_PRICE VARCHAR,
    PRICE_ID VARCHAR PRIMARY KEY
) comment = 'this is a landing_price table in landing schema';

-- Create a transient table for storing security information
CREATE OR REPLACE TRANSIENT TABLE landing_security (
    SECURITY_ID VARCHAR,
    MARCKET_CAPITALIZATION VARCHAR,
    FIFTY_TWO_WEEKS_HIGH VARCHAR,
    FIFTY_TWO_WEEKS_LOW VARCHAR,
    SECURITY_STOCK_ID VARCHAR PRIMARY KEY
) comment = 'this is a landing_security table in landing schema';

-- Create a transient table for storing stock transaction data
CREATE OR REPLACE TRANSIENT TABLE landing_stock (
    SECURITY_ID VARCHAR,
    BUSINESS_DATE VARCHAR FOREIGN KEY REFERENCES landing_date(BUSINESS_DATE),
    TOTAL_TRADED_QUANTITY VARCHAR,
    CLOSE_PRICE VARCHAR,
    LAST_UPDATED_PRICE VARCHAR,
    TOTAL_TRADES VARCHAR,
    AVERAGE_TRADED_PRICE VARCHAR,
    SECURITY_STOCK_ID VARCHAR FOREIGN KEY REFERENCES landing_security(SECURITY_STOCK_ID),
    PRICE_ID VARCHAR FOREIGN KEY REFERENCES landing_price(PRICE_ID)
) comment = 'this is a landing_stock table in landing schema';

-- Define a file format for CSV files
CREATE OR REPLACE FILE FORMAT my_csv
    TYPE = 'CSV'
    COMPRESSION = 'AUTO'
    FIELD_DELIMITER = ','
    RECORD_DELIMITER = '\n'
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
    NULL_IF = ('\\N');

-- Create a staging area for loading data files
CREATE OR REPLACE STAGE landing_stage;

-- Copy data into landing_stock from a CSV file stored in a stage
COPY INTO landing_stock
FROM '@"NEPSE"."LANDING_ZONE"."LANDING_STAGE"/NEPSE Fact Table 13.csv'
FILE_FORMAT = (FORMAT_NAME = my_csv)
ON_ERROR = 'CONTINUE';

-- Copy data into landing_date from a CSV file stored in a stage
COPY INTO landing_date
FROM '@"NEPSE"."LANDING_ZONE"."LANDING_STAGE"/date_test.csv'
FILE_FORMAT = (FORMAT_NAME = my_csv)
ON_ERROR = 'CONTINUE';

-- Copy data into landing_price from a CSV file stored in a stage
COPY INTO landing_price
FROM '@"NEPSE"."LANDING_ZONE"."LANDING_STAGE"/price_test.csv'
FILE_FORMAT = (FORMAT_NAME = my_csv)
ON_ERROR = 'CONTINUE';

-- Copy data into landing_security from a CSV file stored in a stage
COPY INTO landing_security
FROM '@"NEPSE"."LANDING_ZONE"."LANDING_STAGE"/security_test.csv'
FILE_FORMAT = (FORMAT_NAME = my_csv)
ON_ERROR = 'CONTINUE';

-- Show all tables in the current schema
SHOW TABLES;
