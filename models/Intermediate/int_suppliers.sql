{#with
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
            nation_name,
            region_id
        from {{ ref('stg_nations') }}
    ),

    reg as (
        select
            region_id,
            region_name,
            region_comment
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
    --nat.nation_name,
    --nat.region_id,

    -- Region
    reg.region_name,
    reg.region_comment

from sup
join nat on sup.nation_id = nat.nation_id
join reg on nat.region_id = reg.region_id#}



with supp as 
(select * from {{ref('stg_suppliers')}}),
nation as 
(select * from {{ref('stg_nations')}}),
region as
(select * from {{ref('stg_regions')}})

select 
supp.* exclude nation_id,
nation.nation_name as nation,region.region_name as region
from supp
join nation on supp.nation_id=nation.nation_id
join region on nation.region_id=region.region_id