{{ config(
    meta={'materialised': 'ephemeral'}
) }}
with suppliers as(
    select 
    -- ids
        s_suppkey as supplier_id,
        s_nationkey as nation_id,

        -- descriptions
        s_name as supplier_name,
        s_address as supplier_address,
        s_phone as phone_number,
        s_comment as comment,

        -- amounts
        s_acctbal as account_balance,
        updated_time
    from {{ source("src", "suppliers") }} s1 join {{ref("suppliers")}} s2 
    on s1.s_name=s2.Sname 
)
select * from suppliers


        