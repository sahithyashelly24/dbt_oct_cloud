{% macro jodo(col1,col2) %}
    {{col1}} || ' ' || {{col2}}
{% endmacro %}

{% macro showemps() %}
    {% set sql %}
        select EMPLOYEE_NAME
        from {{ ref('stg_employees') }}
    {% endset %}

    {% set results = run_query(sql) %}

    {% if execute %}
        {% for row in results %}
            {{ print(row['EMPLOYEE_NAME']) }}
        {% endfor %}
    {% endif %}
{% endmacro %}


{% macro get_age_group(age_column) %}
    case 
        when {{ age_column }} < 30 then 'YOUNG'
        when {{ age_column }} between 30 and 45 then 'MID'
        else 'SENIOR'
    end
{% endmacro %}

{% macro format_phone_number(column_name) %}
    '(' || SUBSTR({{ column_name }}::varchar, 1, 3) || ') ' ||
    SUBSTR({{ column_name }}::varchar, 4, 3) || ' - ' ||
    SUBSTR({{ column_name }}::varchar, 7, 4)
{% endmacro %}

{% macro format_gender(column_name) %}
    case 
        when upper({{ column_name }}) in ('M', 'MALE') then 'MALE'
        when upper({{ column_name }}) in ('F', 'FEMALE') then 'FEMALE'
        else 'UNKNOWN'
    end
{% endmacro %}



{% macro date_key(column_name) %}
    to_char({{ column_name }}::date, 'YYYYMMDD')
{% endmacro %}

{% macro get_invocation_id() %}
 {{'invocation_id'}}
{% endmacro %}


{% macro create_stage_and_export() %}

    -- Create Stage
    {% do run_query("create stage if not exists mystage_dbt") %}

    -- Export Data
    {% set sql %}
        copy into @mystage_dbt/nation_data.csv
        from {{ ref('stg_nations') }}
        partition by (region_id)
        header = true
        file_format = (type = csv compression = none);
    {% endset %}

    {% do run_query(sql) %}

    {{ return("Stage created + COPY completed") }}

{% endmacro %}