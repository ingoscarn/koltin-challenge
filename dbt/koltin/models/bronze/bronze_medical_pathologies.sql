with raw as (
    select
        $1::string as code,
        $2::string as id,
        $3::string as pathology_name
    from @KOLTIN_S3/pathologies.csv
)

select
    code,
    id,
    pathology_name
from raw
