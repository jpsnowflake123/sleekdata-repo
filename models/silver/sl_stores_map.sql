{{sleekdata.incremental_config()}}

with bz_stores
as
(
    select store_id from {{ref('bz_stores')}}
)

select store_id,seq.dwstore_id.nextval as dwstoreid, current_timestamp() as lastmodifiedinmapping 
from bz_stores src
{% if is_incremental() %}
  where not exists (select 1 from {{this}} trg where src.store_id=trg.store_id)
{% endif %}

