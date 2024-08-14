-- Plan is to build this one live

with source as (

    select * from {{ source('stripe', 'payment') }}

),

transformed as (

    select

        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status as payment_status,
        amount / 100 as payment_amount_$,
        created as payment_date,
        _batched_at

    from source

)

select * from transformed