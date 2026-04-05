{{sleekdata.incremental_config()}}

with bz_order_items
as
(
    select order_item_id from {{ref('bz_order_items')}} src
    {% if is_incremental() %}
        where not exists (select 1 from {{this}} trg where trg.order_item_id=src.order_item_id)
    {% endif %}
)


select  
        order_item_id,
        seq.dworderitems_id.nextval dworderitemid,
        current_timestamp() lastmodifiedinmapping ,
        {{dbt_utils.generate_surrogate_key(['order_item_id'])}} order_item_id_sk
from bz_order_items src



