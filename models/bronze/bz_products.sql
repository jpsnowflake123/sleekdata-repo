{{sleekdata.incremental_config('SKU')}}

with source_product
as
(
    select SKU, NAME PRODUCT_NAME, TYPE PRODUCT_TYPE, PRICE, DESCRIPTION, 
    MD5(CONCAT(PRODUCT_NAME,PRODUCT_TYPE,PRICE,DESCRIPTION)) HASH_DIFF,
    CURRENT_TIMESTAMP() AS LOAD_TIMESTAMP 
    from {{source('raw','products')}}
)

select * from source_product