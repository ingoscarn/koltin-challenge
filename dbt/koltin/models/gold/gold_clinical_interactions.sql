select
    cc.certificate_number                      as customer_id,
    cc.email                                   as customer_email,
    cc.age_in_years                            as customer_current_age,
    cc.gender                                  as customer_gender,
    cc.full_name                               as customer_name,
    mc.consultation_date                       as medical_consult_date,
    mc.consultation_observation                as medical_consult_observation,
    mc.diagnose_pathology_names                as medical_consult_diagnoses,
    ccl.claim_id                               as claim_id,
    ccl.occurred_date                          as claim_occurred_date
from {{ ref('silver_customer_certificates') }} cc
left join {{ ref('silver_customer_claims') }} ccl
    on cc.certificate_number = ccl.certificate_number
left join {{ ref('silver_medical_consultations') }} mc
    on mc.base_id = cc.base_id
    order by customer_id asc
