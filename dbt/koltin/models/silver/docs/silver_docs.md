{% docs silver_medical_pathologies %}
Contiene las patologías médicas limpias y normalizadas desde la capa bronze.  
Los códigos CIE-10 se transforman a mayúsculas y los nombres de patologías se estandarizan para mantener consistencia en los análisis clínicos.
{% enddocs %}

{% docs pathology_id %}
Identificador único del registro.
{% enddocs %}

{% docs cie10_code %}
Código CIE-10 de la patología, normalizado a mayúsculas y sin puntos.
{% enddocs %}

{% docs pathology_name %}
Nombre de la patología con formato capitalizado y limpieza de espacios dobles.
{% enddocs %}

---

{% docs silver_medical_consultations %}
Modelo que representa las consultas médicas normalizadas.  
Extrae información estructurada del cierre médico (`full_medical_closure`) y permite relacionar objetivos, observaciones y diagnósticos con cada paciente.
{% enddocs %}

{% docs consultations_id %}
Identificador único de la consulta médica.
{% enddocs %}

{% docs certificate_number %}
Número de certificado del asegurado vinculado a la consulta o siniestro.
{% enddocs %}

{% docs consultation_date %}
Fecha en la que se llevó a cabo la consulta médica.
{% enddocs %}

{% docs consultation_observation %}
Texto clínico de observaciones durante la consulta, limpio de valores vacíos y caracteres no válidos.
{% enddocs %}

{% docs consult_patient_goal %}
Objetivo de salud definido por el paciente durante la consulta.
{% enddocs %}

{% docs consult_specialist_goal %}
Meta clínica o plan establecido por el especialista.
{% enddocs %}

{% docs pause_consultations %}
Indicador que muestra si las consultas fueron pausadas o suspendidas temporalmente.
{% enddocs %}

{% docs diagnose_pathology_ids %}
Lista de códigos CIE-10 separados por coma, que representan los diagnósticos asociados a la consulta.
{% enddocs %}

{% docs diagnose_pathology_names %}
Lista de nombres de patologías separados por coma, correspondientes a los diagnósticos de la consulta.
{% enddocs %}

{% docs specialty %}
Especialidad médica que atendió la consulta (por ejemplo, medicina general, cardiología, pediatría, etc.).
{% enddocs %}

{% docs placed_by %}
Identificador del médico o usuario que registró la consulta.
{% enddocs %}

---

{% docs silver_customer_claims %}
Modelo de siniestros médicos (claims) asociados a certificados.  
Normaliza montos, fechas y códigos de diagnóstico para análisis de uso y costos médicos.
{% enddocs %}

{% docs claim_id %}
Identificador único del siniestro médico.
{% enddocs %}

{% docs diagnosis %}
Descripción del diagnóstico médico asociado al siniestro.
{% enddocs %}

{% docs occurred_date %}
Fecha en la que ocurrió el evento médico o siniestro.
{% enddocs %}

{% docs payment_date %}
Fecha en la que se realizó el pago del siniestro.
{% enddocs %}

{% docs first_expense_date %}
Fecha del primer gasto médico asociado al siniestro.
{% enddocs %}

{% docs occurred_amount %}
Monto total ocurrido en el evento médico.
{% enddocs %}

{% docs payment_amount %}
Monto total pagado por el siniestro.
{% enddocs %}

{% docs coinsurance %}
Monto de coaseguro aplicado al siniestro.
{% enddocs %}

{% docs tax_recovery %}
Monto de IVA recuperado asociado al siniestro.
{% enddocs %}

{% docs deductible %}
Monto del deducible aplicado.
{% enddocs %}

{% docs cause %}
Causa del siniestro (por ejemplo, enfermedad, accidente, etc.).
{% enddocs %}

{% docs provider_class %}
Clasificación del proveedor o clínica que atendió el caso.
{% enddocs %}

---

{% docs silver_customer_certificates %}
Contiene los datos personales y de identificación de los certificados médicos de los clientes.  
Cada registro representa un asegurado y su certificado vigente.
{% enddocs %}

{% docs certificate_id %}
Identificador interno único del certificado.
{% enddocs %}

{% docs full_name %}
Nombre completo del titular del certificado.
{% enddocs %}

{% docs email %}
Correo electrónico del asegurado.
{% enddocs %}

{% docs age %}
Edad del asegurado.
{% enddocs %}

{% docs city %}
Ciudad de residencia del asegurado.
{% enddocs %}

{% docs birth_date %}
Fecha de nacimiento del asegurado.
{% enddocs %}

{% docs gender %}
Género del asegurado.
{% enddocs %}

{% docs age_in_years %}
Edad aqtual del asegurado expresada en años completos.
{% enddocs %}

---

{% docs silver_customer_certificate_terms %}
Modelo que define los periodos de vigencia de cada certificado médico.  
Permite calcular la duración de cobertura en días y meses.
{% enddocs %}

{% docs certificate_terms_id %}
Identificador único del periodo de vigencia.
{% enddocs %}

{% docs start_date %}
Fecha de inicio de la vigencia del certificado.
{% enddocs %}

{% docs end_date %}
Fecha de finalización de la vigencia del certificado.
{% enddocs %}

{% docs validity_days %}
Duración de la vigencia del certificado expresada en días.
{% enddocs %}

{% docs validity_months %}
Duración de la vigencia del certificado expresada en meses.
{% enddocs %}

{% docs is_active %}
Indicador booleano que señala si el certificado está actualmente activo (true) o ha expirado
(false).
{% enddocs %}
