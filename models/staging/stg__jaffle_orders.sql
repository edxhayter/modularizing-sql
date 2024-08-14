-- This staging model can either be included in the starter to avoid repeating or be used as a 'you do' for participants if the session is longer

with source as (

    select * from {{ source('jaffle_shop', 'orders') }}

),

transformed as (

    select

        id as order_id,
        user_id as customer_id,
        order_date,
        status,
        _etl_loaded_at

    from source

)

select * from transformed