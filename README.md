# ETL Pipeline Using FastAPI, AWS EC2, S3, Airflow, and Snowflake

This repository houses the implementation of an ETL (Extract, Transform, Load) pipeline designed to aggregate and process stock data daily. It utilizes FastAPI, AWS EC2, S3, Apache Airflow, and Snowflake to ensure efficient data handling and analysis.

## Overview

The pipeline automates the collection, transformation, and storage of stock data. It starts by gathering data through a FastAPI service/ The data is then stored in PostgreSQL, archived in AWS S3, and finally transferred to Snowflake for in-depth analysis.

## Architecture

![ETL Pipeline Architecture](https://github.com/DipanshuKakshapati/ETL-pipeline-using-FASTAPI-AWS-EC2-S3-AirFlow-and-Snowflake/blob/e8ee56dab91732939f83caa25acba028efd45e2d/assets/etl-diagram.png?raw=true) 

### Component Overview

The ETL pipeline is structured as follows:

- **FastAPI**: Serves as the entry point for data ingestion. Hosted using Docker on AWS EC2, it receives initial data requests and processes them accordingly.
- **Apache Airflow**: Orchestrates the workflow of the ETL tasks, starting with initiating data processing via an API request to the FastAPI server.
- **AWS EC2**: Hosts both the Docker container for FastAPI and the Airflow scheduler and workers.
- **AWS RDS**: Manages the PostgreSQL database where the processed data is initially stored.
- **Amazon S3**: Acts as a storage solution where the processed data is archived for long-term retention.
- **AWS SQS**: Utilized to facilitate the transfer of data from Amazon S3 to Snowflake, triggered by new file uploads in the S3 bucket.
- **Snowflake**: Final destination for data analysis, where data is loaded from S3 through SQS. It allows for extensive data querying and analysis.
- **Looker Studio**: Used for visualization and further analysis of data stored in Snowflake, providing actionable insights through custom dashboards.

This architecture ensures a robust, scalable, and flexible ETL process, leveraging cloud technologies for efficient data handling and analytics.

## Prerequisites

To use this ETL pipeline, I used:
- An AWS account with configured access to EC2, S3, RDS, and SQS.
- A Snowflake account.
- Docker (for FastAPI and Airflow setup).

## Setup and Installation

### FastAPI Setup

![FastAPI](https://github.com/DipanshuKakshapati/ETL-pipeline-using-FASTAPI-AWS-EC2-S3-AirFlow-and-Snowflake/blob/54e6851a1ec4a1d3befcb5b0a46530ef9923a9f6/assets/fastapi.png?raw=true)

1. Cloned the repository.
2. Installed dependencies: `pip install -r requirements.txt`.
3. Hosted the FastAPI server at EC2 instance.
4. Access the FastAPI servicce in EC2 instance public IP address added with :8000 port.

### Airflow Setup

![Airflow](https://github.com/DipanshuKakshapati/ETL-pipeline-using-FASTAPI-AWS-EC2-S3-AirFlow-and-Snowflake/blob/9603642e459feb2e84dab3415ef8790a73a3a6c9/assets/airflow.png?raw=true)

1. Initialized the Airflow environment with Docker (`docker-compose.yml` provided).
2. Started Airflow: `docker-compose up`.
3. Access the Airflow UI at EC2 instance public IP address added with :8080 port.

### AWS Configuration

![Airflow](https://github.com/DipanshuKakshapati/ETL-pipeline-using-FASTAPI-AWS-EC2-S3-AirFlow-and-Snowflake/blob/54e6851a1ec4a1d3befcb5b0a46530ef9923a9f6/assets/aws.png?raw=true)

1. Configured an EC2 instance to host the Airflow scheduler and workers.
2. Set up RDS for PostgreSQL database connectivity.
3. Configure S3 buckets for data archiving.
4. Set up SQS for triggering Snowflake data transfer when new files are uploaded in S3.
5. Populated the `.env` file with the AWS and Snowflake credentials.

### Snowflake Configuration

![Snowflake](https://github.com/DipanshuKakshapati/ETL-pipeline-using-FASTAPI-AWS-EC2-S3-AirFlow-and-Snowflake/blob/9603642e459feb2e84dab3415ef8790a73a3a6c9/assets/snowflake.png?raw=true)

1. Configured storage integrations and other necessary settings in Snowflake.

## Usage

Here are the steps to operate this ETL pipeline:
1. **Initiate Data Processing**: An Airflow DAG task automatically sends API requests to the FastAPI server via the EC2 URL to start the data extraction process. This is part of the scheduled tasks in Airflow, which ensures that data processing begins as configured.
2. **Monitor Tasks**: Access the Airflow UI at EC2 instance public IP address added with :8080 port to monitor the progress of the ETL tasks. You can see the status of each task and debug logs if necessary.
3. **Check Outputs**: After processing, check the AWS S3 bucket for data archives and Snowflake for detailed analysis outputs.
