-- configure a packages.yml file to get access to the dbt audit macro
-- dbt deps to install the package to the project.

-- Requries the setting of two arguments which will be our legacy query and the table the final refactored model produces.

with audit_check as (

{% set legacy_query %}
select * from {{ ref('legacy_lifetime_customer_metrics') }}
{% endset %}


{% set refactored_query %}
select * from {{ ref('customer_spend') }}
{% endset %}


{{ audit_helper.compare_queries(
    a_query=legacy_query,
    b_query=refactored_query,
    primary_key="customer_id"
) }}

)

select * from audit_check where percent_of_total != 100