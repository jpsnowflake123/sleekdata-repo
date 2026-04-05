{{ sleekdata.incremental_config() }}

with bz_customers as (
    select customer_id
    from {{ ref('bz_customers') }} src
    {% if is_incremental() %}
        where not exists (
            select 1
            from {{ this }} trg
            where src.customer_id = trg.customer_id
        )
    {% endif %}
)

select
    customer_id,
    seq.dwcustomer_id.nextval as dwcustomerid,
    current_timestamp() as LastModifiedInMapping,
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk
from bz_customers src