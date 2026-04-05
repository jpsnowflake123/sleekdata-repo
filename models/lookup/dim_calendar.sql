{{
    config(
        materialized='table',
        schema='gold'
    )
}}

with date_spine as (

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2020-01-01' as date)",
        end_date="cast('2030-12-31' as date)"
    ) }}

)

select
    date_day,

    -- Day of week (Snowflake: 0=Sunday, 6=Saturday)
    dayofweek(date_day) as day_of_week,

    case 
        when dayofweek(date_day) in (0, 6) then true
        else false
    end as is_weekend

from date_spine