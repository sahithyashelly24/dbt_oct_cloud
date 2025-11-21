with
    c as (
        select
            customer_id,
            nation_id,
            name as customer_name,
            address,
            phone_number,
            account_balance,
            market_segment,
            comment
        from {{ ref('stg_customers') }}
    ),

    n as (
        select
            nation_id,
            name as nation_name,
            region_id,
            updated_at as nation_updated_at
        from {{ ref('stg_nations') }}
    ),

    r as (
        select
            region_id,
            name as region_name,
            comment as region_comment
        from {{ ref('stg_regions') }}
    )

select
    -- Customer attributes
    c.customer_id,
    c.customer_name,
    c.address,
    c.phone_number,
    c.account_balance,
    c.market_segment,

    -- Nation attributes
    n.nation_name,
    n.region_id,

    -- Region attributes
    r.region_name,
    r.region_comment

from c
join n on c.nation_id = n.nation_id
join r on n.region_id = r.region_id