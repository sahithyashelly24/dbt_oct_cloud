with info as(
select
    n.nation_id,
    n.name as n_name,
    r.name as r_name,
    n.region_id,
    n.comment
from {{ ref('stg_nations') }} 
as n
join {{ ref('stg_regions') }} 
as r
on n.region_id = r.region_id
)
select * from info