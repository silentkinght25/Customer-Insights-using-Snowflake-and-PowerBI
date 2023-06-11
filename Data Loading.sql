--Switch to role accountadmin 
--to create specific role
Use role accountadmin;

--Create warehouse
--ELT_WH for ELT process
--PowerBI_WH for visulation process
create or replace warehouse ELT_WH
with warehouse_size = "X-SMALL"
auto_suspend = 120
auto_resume = TRUE
initially_suspended = TRUE;

create or replace warehouse POWERBI_WH
with warehouse_size = "X-SMALL"
auto_suspend = 120
auto_resume = TRUE
initially_suspended = TRUE;

--Grant all access to sysadmin for both warehouse
GRANT all on warehouse elt_wh to role sysadmin;
GRANT all on warehouse powerbi_wh to role sysadmin;

--create powerBi role
create or replace role powerbi_role;

--grant access of powerbi_wh to powerbi role
grant all on warehouse powerbi_wh to role powerbi_role;

--grant sysadmin to have all privileges of powerBi role
grant role powerbi_role to role sysadmin;

--create a new user
create or replace user powerbi
password = "ashwani"
default_role = powerbi_role
default_warehouse = powerbi_wh
default_namespace = lab_dw.public

--grant rolw to newly created user
grant role powerbi_role to user powerbi;

use role sysadmin;

--create a database
create database if not exists lab_db;

grant usage on database lab_db to role powerbi_role;

--use lab_db database 
use lab_db.public;
use warehouse elt_wh;

--create a external stage schema
create or replace schema external_stage;

--create a external stage
create or replace stage LAB_DB.external_stage.lab_data_stage
url = 'azure://powersnowinsight.blob.core.windows.net/lab-data'
credentials=(azure_sas_token='sp=racwdl&st=2023-06-09T11:45:30Z&se=2023-06-11T19:45:30Z&spr=https&sv=2022-11-02&sr=c&sig=OtyzdIXnZPWXcPnDKcgR4oI%2FGHTUVYGWjBQZg%2F0Spl4%3D');

--view files in stage
list @lab_data_stage;

--create file format to load data in snowflake db
create or replace file format CSV_file_format
type = 'CSV'
FIELD_DELIMITER = ','
skip_header = 0
null_if = ('null','NULL','N/A','NA')
EMPTY_FIELD_AS_NULL = TRUE

list @lab_data_stage/category


--Create table structures for the data files in stage
CREATE OR REPLACE TABLE CATEGORY (
	CATEGORY_ID NUMBER(38,0),
	CATEGORY_NAME VARCHAR(50)
);

CREATE OR REPLACE TABLE CHANNELS (
	CHANNEL_ID NUMBER(38,0),
	CHANNEL_NAME VARCHAR(50)
);

CREATE OR REPLACE TABLE DEPARTMENT (
	DEPARTMENT_ID NUMBER(38,0),
	DEPARTMENT_NAME VARCHAR(50)
);

CREATE OR REPLACE TABLE ITEMS (
	ITEM_ID NUMBER(38,0),
	ITEM_NAME VARCHAR(250),
	ITEM_PRICE FLOAT,
	DEPARTMENT_ID NUMBER(38,0),
	CATEGORY_ID NUMBER(38,0),
	TMP_ITEM_ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE SALES_ORDERS (
	SALES_ORDER_ID NUMBER(38,0),
	CHANNEL_CODE NUMBER(38,0),
	CUSTOMER_ID NUMBER(38,0),
	PAYMENT_ID NUMBER(38,0),
	EMPLOYEE_ID NUMBER(38,0),
	LOCATION_ID NUMBER(38,0),
	SALES_DATE TIMESTAMP_NTZ(9),
	TMP_ORDER_ID FLOAT,
	TMP_ORDER_DOW NUMBER(38,0),
	TMP_USER_ID NUMBER(38,0)
);


CREATE OR REPLACE TABLE ITEMS_IN_SALES_ORDERS (
	SALES_ORDER_ID NUMBER(38,0),
	ITEM_ID NUMBER(38,0),
	ORDER_ID NUMBER(38,0),
	PROMOTION_ID NUMBER(38,0),
	QUANTITY FLOAT,
	REORDERED NUMBER(38,0),
	TMP_ORDER_ID FLOAT,
	TMP_PRODUCT_ID NUMBER(38,0)
);

CREATE OR REPLACE TABLE LOCATIONS (
	LOCATION_ID NUMBER(38,0),
	NAME VARCHAR(100),
	GEO2 VARCHAR(250),
	GEO GEOGRAPHY,
	LAT FLOAT,
	LONG FLOAT,
	COUNTRY VARCHAR(200),
	REGION VARCHAR(100),
	MUNICIPALITY VARCHAR(200),
	LONGITUDE FLOAT,
	LATITUDE FLOAT
);

CREATE OR REPLACE TABLE STATES (
	STATE_CODE NUMBER(38,0),
	STATE_NAME VARCHAR(250),
	REGION VARCHAR(250),
	STATE_GEO VARCHAR(16777216)
);

--Grant powerbi_role access to this schema and tables
grant usage on schema lab_db.public to role powerbi_role;
grant select on all tables in schema lab_db.public to role powerbi_role;

list @LAB_DB.external_stage.lab_data_stage

--Load category data from stage into category table
copy into LAB_DB.EXTERNAL_STAGE.CATEGORY
from @LAB_DB.external_stage.lab_data_stage
file_format = (format_name = CSV_FILE_FORMAT)
pattern = '.*category.*'

--view the data loaded in category table
select * from LAB_DB.EXTERNAL_STAGE.CATEGORY;



--Load and view CHANNELS data from stage into CHANNELS table
copy into LAB_DB.EXTERNAL_STAGE.CHANNELS
from @LAB_DB.external_stage.lab_data_stage
file_format = (format_name = CSV_FILE_FORMAT)
pattern = '.*channels.*';

select * from LAB_DB.EXTERNAL_STAGE.CHANNELS;



--Load and view DEPARTMENT data from stage into DEPARTMENT table
copy into LAB_DB.EXTERNAL_STAGE.DEPARTMENT
from @LAB_DB.external_stage.lab_data_stage
file_format = (format_name = CSV_FILE_FORMAT)
pattern = '.*department.*';

select * from LAB_DB.EXTERNAL_STAGE.DEPARTMENT;



--Load and view ITEMS data from stage into ITEMS table
copy into LAB_DB.EXTERNAL_STAGE.ITEMS
from @LAB_DB.external_stage.lab_data_stage/items/
file_format = (format_name = CSV_FILE_FORMAT);

select * from LAB_DB.EXTERNAL_STAGE.ITEMS;



--Load and view LOCATIONS data from stage into LOCATIONS table
copy into LAB_DB.EXTERNAL_STAGE.LOCATIONS
from @LAB_DB.external_stage.lab_data_stage
file_format = (format_name = CSV_FILE_FORMAT)
pattern = '.*locations.*';

select * from LAB_DB.EXTERNAL_STAGE.LOCATIONS;



--Load and view STATES data from stage into STATES table
copy into LAB_DB.EXTERNAL_STAGE.STATES
from @LAB_DB.external_stage.lab_data_stage
file_format = (format_name = CSV_FILE_FORMAT)
pattern = '.*states.*';

select * from LAB_DB.EXTERNAL_STAGE.STATES;


--near 200 files are there each of size 100 mb approx
LIST @LAB_DATA_STAGE/items_in_sales_orders/;

--let us load 1 file to check the time it takes to load
--using our ELT_WH warehouse of x-small size
--items_in_sales_orders/items_in_sales_orders_0_0_0.csv.gz
--it takes 22 secs to run 1st file 
copy into LAB_DB.EXTERNAL_STAGE.ITEMS_IN_SALES_ORDERS
from @LAB_DB.EXTERNAL_STAGE.LAB_DATA_STAGE/items_in_sales_orders/items_in_sales_orders_0_0_0.csv.gz
file_format = (format_name = CSV_FILE_FORMAT);

select * from ITEMS_IN_SALES_ORDERS;

--increase the wareshouse size for faster loading
--2X warehouse consumes 32 credits/hr
alter warehouse ELT_WH set warehouse_size = '2X-LARGE';

--load and view rest data into ITEMS_IN_SALES_ORDERS table
--time taken around 50 seconds
copy into LAB_DB.EXTERNAL_STAGE.ITEMS_IN_SALES_ORDERS
from @LAB_DB.EXTERNAL_STAGE.LAB_DATA_STAGE/items_in_sales_orders
file_format = (format_name = CSV_FILE_FORMAT);

select * from ITEMS_IN_SALES_ORDERS;



list @LAB_DB.EXTERNAL_STAGE.LAB_DATA_STAGE/sales_orders;

--Load and view STATES data from stage into STATES table
copy into LAB_DB.EXTERNAL_STAGE.SALES_ORDERS
from @LAB_DB.EXTERNAL_STAGE.LAB_DATA_STAGE/sales_orders
file_format = (format_name = CSV_FILE_FORMAT);

select * from SALES_ORDERS;

--reset the warehouse size to save credits
alter warehouse ELT_WH set warehouse_size = 'X-SMALL'

--afterloading check load history to see whether the data loaded
--has any error or all tables loaded successfully
select * from LAB_DB.INFORMATION_SCHEMA.LOAD_HISTORY
where error_count <> 0

select trunc(TO_DATE(sales_date),'MONTH'), so.* from SALES_ORDERS so where trunc(TO_DATE(sales_date),'MONTH') = trunc(to_date('2017-01-15'),'MONTH');

alter table sales_orders cluster by (month(sales_date))

select * from LAB_DB.INFORMATION_SCHEMA.TABLES;
