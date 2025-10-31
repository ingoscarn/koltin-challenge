with bronze as (
    select * from {{ ref('bronze_customer_certificate_terms') }}
)

select
    try_cast(id as int)                     as id,
    try_cast(certificate_number as int)     as base_id,
    to_date(start_date_raw, 'YYYY-MM-DD')   as start_date,
    to_date(end_date_raw, 'YYYY-MM-DD')     as end_date,
    datediff(day, start_date, end_date)     as validity_days,
    datediff(month, start_date, end_date)   as validity_months,
    case when end_date > current_date() then true else false end as is_active
from bronze
