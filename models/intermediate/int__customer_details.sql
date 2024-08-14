-- Can be the already done example of an intermediary model or a You Do depending on time in session.

-- Stage Tables we will need: stg_orders, stg_customers

with orders as (

    select * from {{ ref('stg__jaffle_orders') }}

),

customers as (

    select * from {{ ref('stg__jaffle_customers') }}

),

-- logic of finding first order as CTE rather than sub query so that it is split out

customer_first_order as (

    select 

        customer_id,
        min(order_date) as first_order_date

    from orders
    group by customer_id

),

-- feature of intermediary model is joining building blocks together.

customer_details as (

    select
        
        customers.customer_id,
        customers.full_name,
        
        customer_first_order.first_order_date

    from customers
    left join customer_first_order on customers.customer_id = customer_first_order.customer_id

),

final as (

    select * from customer_details

)

select * from final