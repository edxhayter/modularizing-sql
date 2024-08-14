SELECT
    c.id AS customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    fo.first_order_date

FROM til_portfolio_projects.jaffle_shop.customers c
LEFT JOIN (
    SELECT 
        o.user_id AS customer_id,
        MIN(o.order_date) AS first_order_date
    FROM til_portfolio_projects.jaffle_shop.orders o
    GROUP BY o.user_id
) AS fo
    ON c.id = fo.customer_id
GROUP BY c.id, c.first_name, c.last_name, fo.first_order_date

-- Stage Tables we will need: stg_orders, stg_customers

with orders as (

    select * from {{ ref('stg__jaffle_orders') }}

),

customers as (

    select * from {{ ref('stg__jaffle_customers') }}

),

customer_first_order as (

    select 

)

customer_details as (

    select



    from


)