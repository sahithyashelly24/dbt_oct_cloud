with emp as (
    select * from {{source('src2','stg_employees')}}
)

select
    EMPLOYEE_ID,
    {{jodo('EMPLOYEE_FIRST_NAME','EMPLOYEE_LAST_NAME')}} as EMPLOYEE_NAME,
    EMPLOYEE_ADDRESS,
    EMPLOYEE_CITY,
    EMPLOYEE_STATE,
    EMPLOYEE_ZIP_CODE,
    EMPLOYEE_MOBILE,
    {{ format_phone_number('EMPLOYEE_MOBILE') }} as EMP_FIXEDLINE,
    EMPLOYEE_EMAIL,
    {{ format_gender('EMPLOYEE_GENDER') }} as EMPLOYEE_GENDER,
    EMPLOYEE_AGE,

    -- AGE GROUP using macro
    {{ get_age_group('EMPLOYEE_AGE') }} as AGE_GROUP,

    POSITION_TYPE,
    DEALERSHIP_ID,
    DEALERSHIP_MANAGER,

    SALARY as EMPLOYEE_SALARY,
    REGION as EMPLOYEE_REGION,

    {{ date_key('HIRE_DATE') }} as HIRED_DATE_KEY,
    {{ date_key('DATE_ENTERED') }} as INSERT_DK,
    {{ date_key('current_timestamp()') }} as UPDATE_DK

from emp







