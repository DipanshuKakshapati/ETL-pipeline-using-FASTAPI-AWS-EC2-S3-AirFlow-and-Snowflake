-- Set the current schema to nepse.curated_zone for task creation
USE SCHEMA nepse.curated_zone;

-- Create a task for updating or inserting stock data into the curated_zone
CREATE OR REPLACE TASK curated_stock_task
    WAREHOUSE = COMPUTE_WH
WHEN
    SYSTEM$STREAM_HAS_DATA('nepse.landing_zone.landing_stock_stream')
AS
    MERGE INTO curated_stock
    USING nepse.landing_zone.landing_stock_stream landing_stock_stream ON
    curated_stock.BUSINESS_DATE = landing_stock_stream.BUSINESS_DATE AND
    curated_stock.SECURITY_STOCK_ID = landing_stock_stream.SECURITY_STOCK_ID AND
    curated_stock.PRICE_ID = landing_stock_stream.PRICE_ID
WHEN MATCHED THEN
    UPDATE SET
        curated_stock fields from the stream
    WHEN NOT MATCHED THEN
    INSERT new records into curated_stock from the stream;

-- Create a task for updating or inserting date data into the curated_zone
CREATE OR REPLACE TASK curated_date_task
    WAREHOUSE = COMPUTE_WH
WHEN
    SYSTEM$STREAM_HAS_DATA('nepse.landing_zone.landing_date_stream')
AS
    MERGE INTO curated_date
    USING nepse.landing_zone.landing_date_stream landing_date_stream ON
    curated_date.BUSINESS_DATE = landing_date_stream.BUSINESS_DATE
WHEN MATCHED THEN
    UPDATE SET
        curated_date fields from the stream
    WHEN NOT MATCHED THEN
    INSERT new records into curated_date from the stream;

-- Create a task for updating or inserting price data into the curated_zone
CREATE OR REPLACE TASK curated_price_task
    WAREHOUSE = COMPUTE_WH
WHEN
    SYSTEM$STREAM_HAS_DATA('nepse.landing_zone.landing_price_stream')
AS
    MERGE INTO curated_price
    USING nepse.landing_zone.landing_price_stream landing_price_stream ON
    curated_price.PRICE_ID = landing_price_stream.PRICE_ID
WHEN MATCHED THEN
    UPDATE SET
        curated_price fields from the stream
    WHEN NOT MATCHED THEN
    INSERT new records into curated_price from the stream;

-- Create a task for updating or inserting security data into the curated_zone
CREATE OR REPLACE TASK curated_security_task
    WAREHOUSE = COMPUTE_WH
WHEN
    SYSTEM$STREAM_HAS_DATA('nepse.landing_zone.landing_security_stream')
AS
    MERGE INTO curated_security
    USING nepse.landing_zone.landing_security_stream landing_security_stream ON
    curated_security.SECURITY_STOCK_ID = landing_security_stream.SECURITY_STOCK_ID
WHEN MATCHED THEN
    UPDATE SET
        curated_security fields from the stream
    WHEN NOT MATCHED THEN
    INSERT new records into curated_security from the stream;

-- Display all tasks to verify creation
SHOW TASKS;

-- Resume all tasks to start processing data transfers
ALTER TASK curated_stock_task RESUME;
ALTER TASK curated_date_task RESUME;
ALTER TASK curated_price_task RESUME;
ALTER TASK curated_security_task RESUME;

-- Retrieve and display the history of task executions for monitoring purposes
SELECT * 
FROM TABLE(information_schema.task_history())
WHERE NAME IN ('CURATED_STOCK_TASK', 'CURATED_DATE_TASK', 'CURATED_PRICE_TASK', 'CURATED_SECURITY_TASK')
ORDER BY SCHEDULED_TIME;
