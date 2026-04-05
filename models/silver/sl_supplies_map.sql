{{sleekdata.incremental_config()}}

with bz_supplies 
as (
    select supply_id,sku from {{ref('bz_supplies')}} src
    {% if is_incremental() %}
        where not exists (select 1 from {{this}} trg where trg.supply_id=src.supply_id and trg.sku=src.sku)
    {% endif %}
)

select seq.dwsupply_id.nextval as dwsupplyid,
sku,
supply_id,
current_timestamp() lastmodifiedinmapping,
{{ dbt_utils.generate_surrogate_key(['supply_id','sku'])}} supply_id_sk
from bz_supplies