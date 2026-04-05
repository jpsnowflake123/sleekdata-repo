{{sleekdata.incremental_config('STORE_ID')}}

with source_stores
as(
    select * from {{source('raw','stores')}}
)

select ID as STORE_ID, NAME as STORE_NAME, OPENED_AT, TAX_RATE ,
MD5(CONCAT(STORE_NAME,OPENED_AT,TAX_RATE)) HASH_DIFF
from source_stores