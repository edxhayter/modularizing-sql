-- import CTEs

with customer_info as (

    select * from {{ ref('int__customer_details') }}

),

order_payments as (

    select * from {{ ref('int__order_payments') }}

),

-- aggregate order payments to customer level ready for joining

customer_payments as (

    select 

        order_payments.customer_id,
        sum(order_payments.num_payments) as total_payments,
        count(order_payments.order_id) as total_orders,
        sum(order_payments.order_spend) as total_spend,
        avg(order_payments.order_spend) as avg_order_value

    from order_payments
    group by customer_id

),

final as (

    select

        customer_info.customer_id,
        customer_info.full_name,
        customer_info.first_order_date,

        customer_payments.total_payments,
        customer_payments.total_orders,
        customer_payments.total_spend,
        customer_payments.avg_order_value

    from customer_info
    left join customer_payments on customer_info.customer_id = customer_payments.customer_id
    -- left join to keep customers who are yet to complete a purchase
    having total_orders >= 1
    order by total_spend desc
    -- sort by total_spend for auditing purposes.
)

select * from final