with bronze as (
    select * from {{ ref('bronze_medical_consultations') }}
),

base as (
    select
        try_cast(id as int)                          as id,
        try_cast(certificate_number as int)          as certificate_number,
        to_date(consultation_date_raw, 'YYYY-MM-DD') as consultation_date,
        try_parse_json(closure_json)                 as full_medical_closure,
        {{ normalize_empty_text("full_medical_closure:\"dayNote\":\"consultationObservation\"::string") }} as consultation_observation,
        {{ normalize_empty_text("full_medical_closure:\"patientGoal\"::string") }} as consult_patient_goal,
        {{ normalize_empty_text("full_medical_closure:\"specialistGoal\"::string") }} as consult_specialist_goal,
        full_medical_closure:"pauseConsultations"::string as pause_consultations,
        full_medical_closure:"patientDiagnoses" as patient_diagnoses_array,
        specialty,
        try_cast(placed_by as int) as placed_by
    from bronze
),

exploded as (
    select
        b.*,
        f.value:"patientDiagnose"::string as patient_diagnose
    from base b,
         lateral flatten(input => b.patient_diagnoses_array) f
),
joined as (
    select
        e.*,
        p.pathology_name,
        p.cie10_code
    from exploded e
    left join {{ ref('silver_medical_pathologies') }} p
        on e.patient_diagnose = p.pathology_id
)
select
    id,
    certificate_number as base_id,
    consultation_date,
    consultation_observation,
    consult_patient_goal,
    consult_specialist_goal,
    pause_consultations,
    coalesce(listagg(distinct cie10_code, ','), 'NONE')      as diagnose_pathology_ids,
    coalesce(listagg(distinct pathology_name, ','), 'NONE')  as diagnose_pathology_names,
    specialty,
    placed_by
from joined
group by
    id,
    certificate_number,
    consultation_date,
    consultation_observation,
    consult_patient_goal,
    consult_specialist_goal,
    pause_consultations,
    specialty,
    placed_by
