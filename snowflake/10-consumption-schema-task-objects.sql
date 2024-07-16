-- Set the current schema to nepse.consumption_zone for task creation
USE SCHEMA nepse.consumption_zone;

-- Create a task for merging stock fact data into the consumption layer when new data is available
CREATE OR REPLACE TASK consumption_stock_fact_task
    WAREHOUSE = compute_wh
WHEN
    SYSTEM$STREAM_HAS_DATA('nepse.curated_zone.curated_stock_stream')
AS
    MERGE INTO stock_fact
    USING nepse.curated_zone.curated_stock_stream curated_stock_stream ON
    stock_fact.BUSINESS_DATE = curated_stock_stream.BUSINESS_DATE AND
    stock_fact.SECURITY_STOCK_ID = curated_stock_stream.SECURITY_STOCK_ID AND
    stock_fact.PRICE_ID = curated_stock_stream.PRICE_ID
WHEN MATCHED THEN
    UPDATE existing records in stock_fact
    WHEN NOT MATCHED THEN
    INSERT new records into stock_fact;

-- Create a task for merging date dimension data into the consumption layer
CREATE OR REPLACE TASK consumption_date_dim_task
    WAREHOUSE = compute_wh
WHEN
    SYSTEM$STREAM_HAS_DATA('nepse.curated_zone.curated_date_stream')
AS
    MERGE INTO date_dim
    USING nepse.curated_zone.curated_date_stream curated_date_stream ON
    date_dim.BUSINESS_DATE = curated_date_stream.BUSINESS_DATE
WHEN MATCHED THEN
    UPDATE existing records in date_dim
    WHEN NOT MATCHED THEN
    INSERT new records into date_dim;

-- Create a task for merging price dimension data into the consumption layer
CREATE OR REPLACE TASK consumption_price_dim_task
    WAREHOUSE = COMPUTE_WH
WHEN
    SYSTEM$STREAM_HAS_DATA('nepse.curated_zone.curated_price_stream')
AS
    MERGE INTO price_dim
    USING nepse.curated_zone.curated_price_stream curated_price_stream ON
    price_dim.PRICE_ID = curated_price_stream.PRICE_ID
WHEN MATCHED THEN
    UPDATE existing records in price_dim
    WHEN NOT MATCHED THEN
    INSERT new records into price_dim;

-- Create a task for merging security dimension data into the consumption layer
CREATE OR REPLACE TASK consumption_security_dim_task
    WAREHOUSE = COMPUTE_WH
WHEN
    SYSTEM$STREAM_HAS_DATA('nepse.curated_zone.curated_security_stream')
AS
    MERGE INTO security_dim
    USING nepse.curated_zone.curated_security_stream curated_security_stream ON
    security_dim.SECURITY_STOCK_ID = curated_security_stream.SECURITY_STOCK_ID
WHEN MATCHED THEN
    UPDATE existing records in security_dim
    WHEN NOT MATCHED THEN
    INSERT new records into security_dim;

-- Display all tasks to verify creation
SHOW TASKS;

-- Resume all tasks to start processing data transfers
ALTER TASK consumption_stock_fact_task RESUME;
ALTER TASK consumption_date_dim_task RESUME;
ALTER TASK consumption_price_dim_task RESUME;
ALTER TASK consumption_security_dim_task RESUME;

-- Retrieve and display the history of task executions for monitoring purposes
SELECT * 
FROM TABLE(information_schema.task_history())
WHERE NAME IN ('CONSUMPTION_STOCK_FACT_TASK', 'CONSUMPTION_DATE_DIM_TASK', 'CONSUMPTION_PRICE_DIM_TASK', 'CONSUMPTION_SECURITY_DIM_TASK')
ORDER BY SCHEDULED_TIME;
