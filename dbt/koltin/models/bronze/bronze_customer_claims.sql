with raw as (
    select
        $1::string  as claim_id,
        $2::string  as state,
        $3::string  as cie10_code,
        $4::string  as diagnosis,
        $5::string  as occurred_date_raw,
        $6::string  as payment_date_raw,
        $7::string  as first_expense_date_raw,
        $8::string  as occurred_amount_raw,
        $9::string  as payment_amount_raw,
        $10::string as coinsurance_raw,
        $11::string as tax_recovery_raw,
        $12::string as deductible_raw,
        $13::string as cause,
        $14::string as month_code,
        $15::string as accounting_month_raw,
        $16::string as payment_type,
        $17::string as provider_class,
        $18::string as certificate_number
    from @KOLTIN_S3/claims_dummy.csv
)
select
    claim_id,
    state,
    cie10_code,
    diagnosis,
    occurred_date_raw,
    payment_date_raw,
    first_expense_date_raw,
    occurred_amount_raw,
    payment_amount_raw,
    coinsurance_raw,
    tax_recovery_raw,
    deductible_raw,
    cause,
    month_code,
    accounting_month_raw,
    payment_type,
    provider_class,
    certificate_number
from raw
