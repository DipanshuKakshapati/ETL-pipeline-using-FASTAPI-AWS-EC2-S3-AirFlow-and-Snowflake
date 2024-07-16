-- Set the current schema to nepse.landing_zone for stream creation
USE SCHEMA nepse.landing_zone;

-- Create a stream on the landing_stock table to capture new insert operations
CREATE OR REPLACE STREAM landing_stock_stream ON TABLE landing_stock
APPEND_ONLY = True;

-- Create a stream on the landing_date table to capture new insert operations
CREATE OR REPLACE STREAM landing_date_stream ON TABLE landing_date
APPEND_ONLY = True;

-- Create a stream on the landing_price table to capture new insert operations
CREATE OR REPLACE STREAM landing_price_stream ON TABLE landing_price
APPEND_ONLY = True;

-- Create a stream on the landing_security table to capture new insert operations
CREATE OR REPLACE STREAM landing_security_stream ON TABLE landing_security
APPEND_ONLY = True;

-- Display all stream objects to verify creation
SHOW STREAMS;

    