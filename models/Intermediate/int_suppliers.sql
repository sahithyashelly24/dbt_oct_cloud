with
    sup as (
        select
            supplier_id,
            nation_id,
            supplier_name,
            supplier_address,
            phone_number,
            comment,
            account_balance,
            updated_time
        from {{ ref('stg_suppliers') }}
    ),

    nat as (
        select
            nation_id,
            name as nation_name,
            region_id,
            updated_at as nation_updated_at
        from {{ ref('stg_nations') }}
    ),

    reg as (
        select
            region_id,
            name as region_name,
            comment as region_comment
        from {{ ref('stg_regions') }}
    )

select
    -- Supplier
    sup.supplier_id,
    sup.supplier_name,
    sup.supplier_address,
    sup.phone_number,
    sup.account_balance,

    -- Nation
    nat.nation_name,
    nat.region_id,

    -- Region
    reg.region_name,
    reg.region_comment

from sup
join nat on sup.nation_id = nat.nation_id
join reg on nat.region_id = reg.region_id