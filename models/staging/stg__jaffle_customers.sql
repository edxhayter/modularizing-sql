-- Documented staging model so we do not have to repeat the process during the demo.
-- Bring in the source at the start for quick reference of where data comes from for this model

with source as (

    select * from {{ source('jaffle_shop', 'customers') }}

),

-- simple transformations, renaming of fields, you could add a test model to ensure a column name does not change fixed casting of data types.

transformed as (

    select

        id as customer_id,
        first_name,
        last_name,
        first_name || ' ' || last_name as full_name

    from source

)

-- dbt encourages models to end with a select * from a 'final' CTE or sometimes for these staging models a 'transformed' CTE

select * from transformed