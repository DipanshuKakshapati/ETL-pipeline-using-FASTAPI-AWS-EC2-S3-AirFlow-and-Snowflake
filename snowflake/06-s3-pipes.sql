-- Set the current schema to nepse.landing_zone for Snowpipe creation
USE SCHEMA nepse.landing_zone;

-- Create a Snowpipe for automatically ingesting data into landing_stock from S3
CREATE OR REPLACE PIPE stock_pipe
AUTO_INGEST = True
as
    COPY INTO landing_stock FROM @delta_stock_s3
    FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',', SKIP_HEADER = 1)
    ON_ERROR = 'CONTINUE';

-- Create a Snowpipe for automatically ingesting data into landing_date from S3
CREATE OR REPLACE PIPE date_pipe
AUTO_INGEST = True
as
    COPY INTO landing_date FROM @delta_date_s3
    FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',', SKIP_HEADER = 1)
    ON_ERROR = 'CONTINUE';

-- Create a Snowpipe for automatically ingesting data into landing_price from S3
CREATE OR REPLACE PIPE price_pipe
AUTO_INGEST = True
as
    COPY INTO landing_price FROM @delta_price_s3
    FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',', SKIP_HEADER = 1)
    ON_ERROR = 'CONTINUE';

-- Create a Snowpipe for automatically ingesting data into landing_security from S3
CREATE OR REPLACE PIPE security_pipe
AUTO_INGEST = True
as
    COPY INTO landing_security FROM @delta_security_s3
    FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',', SKIP_HEADER = 1)
    ON_ERROR = 'CONTINUE';

-- Display all Snowpipe objects to verify creation
SHOW PIPES;

-- Retrieve and display the operational status of the stock_pipe
SELECT SYSTEM$PIPE_STATUS('stock_pipe');

-- Retrieve and display the operational status of the date_pipe
SELECT SYSTEM$PIPE_STATUS('date_pipe');

-- Retrieve and display the operational status of the price_pipe
SELECT SYSTEM$PIPE_STATUS('price_pipe');

-- Retrieve and display the operational status of the security_pipe
SELECT SYSTEM$PIPE_STATUS('security_pipe');
