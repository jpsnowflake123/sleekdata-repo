{{sleekdata.incremental_config()}}

with bz_stores as (
    select order_id from {{ref('bz_orders')}} src
    {% if is_incremental() %}
        where not exists (select 1 from {{this}} trg where src.order_id=trg.order_id)
    {% endif %}
)

select  
        src.order_id,
        seq.dworder_id.nextval as dworderid,
        current_timestamp() as lastmodifiedtimestamp ,
        {{dbt_utils.generate_surrogate_key(['order_id'])}} as order_sk
from bz_stores src

