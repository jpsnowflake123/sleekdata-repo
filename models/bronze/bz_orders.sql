{{sleekdata.incremental_config('ORDER_ID')}}

with source_orders
as
(
    select * from {{source('raw','orders')}}
)

select ID as ORDER_ID, CUSTOMER CUSTOMER_ID, ORDERED_AT, STORE_ID, SUBTOTAL, TAX_PAID, ORDER_TOTAL,
MD5(CONCAT(CUSTOMER_ID,ORDERED_AT,STORE_ID,SUBTOTAL,TAX_PAID,ORDER_TOTAL)) hash_diff
,CURRENT_TIMESTAMP() AS LOAD_TIMESTAMP  
from source_orders