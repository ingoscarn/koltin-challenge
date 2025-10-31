with raw as (
    select
        $1::string as id,
        $2::string as full_name,
        $3::string as email,
        $4::string as age,
        $5::string as city,
        $6::string as birth_date,
        $7::string as certificate_number,
        $8::string as gender
    from @KOLTIN_S3/certificate_dummy.csv
)

select
    id,
    full_name,
    email,
    age,
    city,
    birth_date,
    certificate_number,
    gender
from raw
