with claims_summary as (
    select
        certificate_number,
        count(*) as total_claims,
        max(occurred_date) as last_claim_date
    from {{ ref('silver_customer_claims') }}
    group by certificate_number
),

consultations_summary as (
    select
        base_id as base_id,
        count(*) as total_consultations,
        max(consultation_date) as last_consultation_date
    from {{ ref('silver_medical_consultations') }}
    group by base_id
)

select
    cc.base_id                                 as customer_id,
    cc.full_name                               as customer_name,
    cc.email                                   as customer_email,
    cc.city                                    as customer_city,
    cc.gender                                  as customer_gender,
    cc.birth_date                              as customer_birth_date,
    cc.age_in_years                            as customer_current_age,
    coalesce(cs.total_claims, 0)               as total_claims,
    cs.last_claim_date                         as last_claim_date,
    coalesce(ms.total_consultations, 0)        as total_consultations,
    ms.last_consultation_date                  as last_consultation_date
from {{ ref('silver_customer_certificates') }} cc
left join claims_summary cs
    on cc.certificate_number = cs.certificate_number
left join consultations_summary ms
    on cc.base_id = ms.base_id
order by cc.base_id
