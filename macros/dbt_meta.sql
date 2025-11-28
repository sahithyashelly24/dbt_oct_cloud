{% macro get_invocation_id2() %}
 '{{invocation_id}}':: varchar as dbt_batch_id,
 '{{run_start_at}}'as dbt_batch_ts 
{% endmacro %}