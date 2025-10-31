with bronze as (
    select * from {{ ref('bronze_customer_claims') }}
)
select
    upper(claim_id) as claim_id,
    state,
    REPLACE(cie10_code, '.', '') as cie10_code,
    diagnosis,
    TRY_TO_DATE(occurred_date_raw, 'DD/MM/YYYY')       as occurred_date,
    TRY_TO_DATE(payment_date_raw, 'DD/MM/YYYY')        as payment_date,
    TRY_TO_DATE(first_expense_date_raw, 'DD/MM/YYYY')  as first_expense_date,
    try_to_number(replace(occurred_amount_raw, ',', '.'), 10, 2)  as occurred_amount,
    try_to_number(replace(payment_amount_raw, ',', '.'), 10, 2)   as payment_amount,
    try_to_number(replace(coinsurance_raw, ',', '.'), 10, 2)      as coinsurance,
    try_to_number(replace(tax_recovery_raw, ',', '.'), 10, 2)     as tax_recovery,
    try_to_number(replace(deductible_raw, ',', '.'), 10, 2)       as deductible,
    cause,
    month_code,
    TRY_TO_DATE(accounting_month_raw, 'DD/MM/YYYY')    as accounting_month,
    payment_type,
    provider_class,
    certificate_number
from bronze

