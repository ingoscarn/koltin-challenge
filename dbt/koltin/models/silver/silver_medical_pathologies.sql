with raw as (
    select * from {{ ref('bronze_medical_pathologies') }}
)

select
    try_cast(id as int) as pathology_id,
    upper(trim(code)) as cie10_code,
    initcap({{ clean_spaces('pathology_name') }}) as pathology_name
from raw