with raw as (
    select
        $1::string as id,
        $2::string as certificate_number,
        $3::string as start_date_raw,
        $4::string as end_date_raw
    from @KOLTIN_S3/terms_dummy.csv
)

select
    id,
    certificate_number,
    start_date_raw,
    end_date_raw
from raw
