USE SCHEMA nepse.landing_zone;

-- Create and list the stage for stock data
CREATE OR REPLACE STAGE delta_stock_s3
    URL = 's3://nepse-fact-table'
    CREDENTIALS = (AWS_KEY_ID = '<AWS_KEY_ID>' 
                   AWS_SECRET_KEY = '<AWS_SECRET_KEY>'
                   AWS_TOKEN = '<AWS_TOKEN>')
    FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1)
    COMMENT = 'feed fact_table files';
    
LIST @delta_stock_s3;

-- Create and list the stage for date data
CREATE OR REPLACE STAGE delta_date_s3
    url = 's3://nepse-date-dimension'
    CREDENTIALS = (AWS_KEY_ID = '<AWS_KEY_ID>' 
                   AWS_SECRET_KEY = '<AWS_SECRET_KEY>'
                   AWS_TOKEN = '<AWS_TOKEN>')
    FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1)
    COMMENT = 'feed date_dim files';

LIST @delta_date_s3;

-- Create and list the stage for price data
CREATE OR REPLACE STAGE delta_price_s3
    url = 's3://nepse-price-dimension'
    CREDENTIALS = (AWS_KEY_ID = '<AWS_KEY_ID>' 
                   AWS_SECRET_KEY = '<AWS_SECRET_KEY>'
                   AWS_TOKEN = '<AWS_TOKEN>')
    FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1)
    COMMENT = 'feed price_dim files';

LIST @delta_price_s3;

-- Create and list the stage for security data
CREATE OR REPLACE STAGE delta_security_s3
    url = 's3://nepse-security-dimension'
    CREDENTIALS = (AWS_KEY_ID = '<AWS_KEY_ID>' 
                   AWS_SECRET_KEY = '<AWS_SECRET_KEY>'
                   AWS_TOKEN = '<AWS_TOKEN>')
    FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ',' SKIP_HEADER = 1)
    COMMENT = 'feed security_dim files';

LIST @delta_security_s3;

-- Display all stages
SHOW stages;
