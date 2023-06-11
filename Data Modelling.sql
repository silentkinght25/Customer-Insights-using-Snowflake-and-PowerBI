
--dept id 39 has duplicate values
SELECT 
  DEPARTMENT_ID
  ,COUNT() AS REC_COUNT
FROM DEPARTMENT
GROUP BY 1
ORDER BY 2 DESC;

--create view for location table 
--the regions present on both states and loc table will only be loaded.
create or replace view location_v as
    select  l.LOCATION_ID,
            l.name,
            l.country,
            l.region,
            l.municipality,
            s.state_code,
            s.state_name,
            l.longitude,
            l.latitude
    from locations l 
    inner join states s on s.region = l.region;

--remove unnecessary rows that are not present in other table
--remove the rows with dept_id 39 as the data is corrupted in dept table
create or replace view items_v as
    select  i.item_id,
            i.item_name,
            i.item_price,
            i.department_id,
            i.category_id
    from items i
     inner join department d on d.department_id=i.department_id
     inner join category c on c.category_id=i.category_id
     where i.department_id  39;

 --remove redundant rows
create or replace view sales_orders_v as
    select  iso.item_id,
            so.channel_code,
            iso.quantity,
            so.location_id,
            so.sales_date,
            iso.order_id
    from sales_orders so
     inner  join items_in_sales_orders iso on iso.sales_order_id = so.sales_order_id
     inner join locations l on l.location_id = so.location_id;


--remove quantity as it has only single value 1 so its redundant
create or replace view item_in_sales_orders_v as
    select  iso.sales_order_id,
            iso.item_id,
            iso.order_id
    from items_in_sales_orders iso
     inner join items_v iv on iv.item_id = iso.item_id
     inner join sales_orders so on so.sales_order_id = iso.sales_order_id;

create or replace view department_v as
    select  from department
    where department_id  39;

create or replace view states_v as    
    select  st.state_code,
            st.state_name,
            st.region
    from states st where st.state_code is not null;





