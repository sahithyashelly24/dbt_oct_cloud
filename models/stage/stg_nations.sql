{{
    config(
        access= 'public',
        alias=this.name+var('v_id')
    )
}}


with nation as (
select  
    n_nationkey as nation_id,
    n_name as nation_name,
    n_regionkey as region_id,
    '{{invocation_id}}' as invocation_id,
    {{ get_invocation_id2() }} 


from {{source ('src', 'nations')}}
)
select * from nation