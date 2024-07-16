-- Set the current schema to nepse.curated_zone for stream creation
USE SCHEMA nepse.curated_zone;

-- Create a stream on the curated_stock table to capture new insert operations
CREATE OR REPLACE STREAM curated_stock_stream ON TABLE curated_stock
APPEND_ONLY = True;

-- Create a stream on the curated_date table to capture new insert operations
CREATE OR REPLACE STREAM curated_date_stream ON TABLE curated_date
APPEND_ONLY = True;

-- Create a stream on the curated_price table to capture new insert operations
CREATE OR REPLACE STREAM curated_price_stream ON TABLE curated_price
APPEND_ONLY = True;

-- Create a stream on the curated_security table to capture new insert operations
CREATE OR REPLACE STREAM curated_security_stream ON TABLE curated_security
APPEND_ONLY = True;


