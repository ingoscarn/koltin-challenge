with raw as (
    select
        $1::string as id,
        $2::string as certificate_number,
        $3::string as consultation_date_raw,
        $4::string as closure_json,
        $5::string as specialty,
        $6::string as placed_by
    from @KOLTIN_S3_SEMICOLON/consultas_dummy.csv
)

select
    id,
    certificate_number,
    consultation_date_raw,
    closure_json,
    specialty,
    placed_by
from raw
