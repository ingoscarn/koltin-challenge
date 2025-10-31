select
    cc.base_id as customer_id,
    cc.full_name as customer_name,
    mc.consultation_date as consultation_diagnosis_date,
    mc.diagnose_pathology_names as consultation_diagnosis_name,
    floor(datediff(year, to_date(cc.birth_date), mc.consultation_date)) as age_at_consultation_diagnosis,
    cc.age_in_years as current_customer_age
from {{ ref('silver_customer_certificates') }}  cc
left join {{ ref('silver_medical_consultations') }}  mc
    on mc.base_id = cc.base_id
where mc.diagnose_pathology_names is not null
order by customer_id desc