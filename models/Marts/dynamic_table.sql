{{ config(
    materialized = 'dynamic_table',
    target_lag = '5 minutes',
    snowflake_warehouse = "TRANSFORM_WH",
    
    refresh_mode = "AUTO"
) }}

select
    n.nation_name,
    count(c.name) as customer_count,
    sum(c.account_balance) as total_balance
from {{ ref('stg_customers') }} c
join {{ ref('stg_nations') }} n
    on c.nation_id = n.nation_id
group by n.nation_name

