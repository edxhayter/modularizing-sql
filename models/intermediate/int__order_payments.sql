-- Leaving this one complete for time-sake, want time to cover the final model along with audit tests and testing in general.

-- staging models used are orders and payments

with orders as(

    select * from {{ ref('stg__jaffle_orders') }}

),

payments as (

    select * from {{ ref('stg__stripe_payments') }}
        
),

-- order level payment information mnight be useful for other projects so down the line it might be worth putting in its own model.
-- so it can be built off of. This change after this refactoring is as easy as ripping the CTE out of here and putting it in as an input CTE above
-- for now we won't as we don't want to clutter our final DAG.

payment_stats as (

    select

        order_id,
        count(payment_id) as num_payments,
        sum(payment_amount_$) as order_spend,
    
    from payments
    where payment_status != 'fail'
    group by order_id

),

add_customer_details as (

    select

        orders.customer_id,

        payment_stats.*

    from orders
    left join payment_stats on orders.order_id = payment_stats.order_id
    -- left join here to write a test on the model to check for NULL in payment stats to flag instances where a customer is missing payment info

),

final as (

    select * from add_customer_details

)

select * from final
 -- where num_payments IS NULL