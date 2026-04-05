{{sleekdata.incremental_config()}}

with bz_products
as
(
    select sku from {{ref('bz_products')}} src
    {% if is_incremental() %}
        where not exists (select 1 from {{this}} trg where src.sku=trg.sku)
    {% endif %}
)

select sku,
seq.dwproduct_id.nextval as dwproductid,
current_timestamp() as LastModifiedInMapping,
{{ dbt_utils.generate_surrogate_key(['sku']) }} as product_id_sk
from bz_products src

