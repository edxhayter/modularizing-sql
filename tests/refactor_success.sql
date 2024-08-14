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