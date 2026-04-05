{{sleekdata.incremental_config(unique_key='ORDER_ITEM_ID')}}

with source_order_item
as
(
    select ID as ORDER_ITEM_ID, ORDER_ID, SKU,MD5(CONCAT(ORDER_ID,SKU)) AS hash_diff,CURRENT_TIMESTAMP() AS LOAD_TIMESTAMP 
     from {{source('raw','items')}}
)

select * from source_order_item