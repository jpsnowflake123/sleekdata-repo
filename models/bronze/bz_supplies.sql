{{ sleekdata.incremental_config(unique_key=['SUPPLY_ID','SKU']) }}


with source_supplies
as
(
    select ID as SUPPLY_ID, NAME as SUPPLY_NAME, COST, PERISHABLE, SKU ,
    MD5(CONCAT(NAME,COST,PERISHABLE,SKU)) HASH_DIFF
    from {{source('raw','supplies')}}
)

select * from source_supplies

