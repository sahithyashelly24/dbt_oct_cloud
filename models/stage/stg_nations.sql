{{
    config(
        access= 'public',
        alias=this.name+var('v_id')
    )
}}


with nation as (
select  
    n_nationkey::varchar as nation_id,
    n_name as nation_name,
    n_regionkey as region_id

from {{source ('src', 'nations')}}
)
select * from nation