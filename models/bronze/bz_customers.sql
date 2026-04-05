{{sleekdata.incremental_config(unique_key='CUSTOMER_ID')}}

with source_customers
as
(
    select raw.ID CUSTOMER_ID, raw.NAME CUSTOMER_NAME,
    MD5(CONCAT(CUSTOMER_NAME)) AS hash_diff,
    CURRENT_TIMESTAMP() AS LOAD_TIMESTAMP 
    from {{ source('raw','customers') }} raw

)

select * from source_customers src