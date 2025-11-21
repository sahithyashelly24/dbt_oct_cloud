with source as (
    select * from {{source('src', 'orders')}}
),

changed as (
    select 
        --ids
        o_orderkey as order_id,
        o_custkey as customer_id,
        --description
        o_comment as comment,
        o_clerk as clerk,
        
        --numbers
        o_totalprice as total_price,

        o_orderstatus as order_status,
        o_orderpriority as order_priority,
        o_shippriority as ship_priority,

        o_orderdate as order_date,
        
    from source
)

select * from changed