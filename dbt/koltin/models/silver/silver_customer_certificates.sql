with bronze as (
    select * from {{ ref('bronze_customer_certificates') }}
)
select
    try_cast(id as int)                     as base_id,
    full_name,
    email,
    try_cast(age as int)                    as age,
    city,
    to_date(birth_date, 'YYYY-MM-DD')       as birth_date,
    certificate_number,
    gender,
    floor(datediff(year, to_date(birth_date), current_date())) as age_in_years
from bronze