{% docs bronze_customer_certificates %}
Datos crudos de certificados cargados directamente desde **certificate_dummy.csv**.  
Este modelo contiene información sin procesar ni tipificar de los certificados.
{% enddocs %}

{% docs bronze_customer_certificates__id %}
Identificador único en bruto del certificado.
{% enddocs %}

{% docs bronze_customer_certificates__full_name %}
Nombre completo del titular del certificado, tal como aparece en el archivo fuente CSV.
{% enddocs %}

{% docs bronze_customer_certificates__email %}
Dirección de correo electrónico del titular del certificado en formato sin procesar.
{% enddocs %}

{% docs bronze_customer_certificates__age %}
Edad del titular del certificado (cadena de texto, aún no convertida a número).
{% enddocs %}

{% docs bronze_customer_certificates__city %}
Ciudad de residencia.
{% enddocs %}

{% docs bronze_customer_certificates__birth_date %}
Fecha de nacimiento del titular del certificado como texto (YYYY-MM-DD).
{% enddocs %}

{% docs bronze_customer_certificates__certificate_number %}
Número de certificado en formato texto.
{% enddocs %}

{% docs bronze_customer_certificates__gender %}
Género del titular del certificado (cadena sin procesar).
{% enddocs %}

---

{% docs bronze_customer_claims %}
Datos crudos de siniestros cargados desde **claims_dummy.csv**.  
Contiene campos financieros y diagnósticos en formato sin tipificar.
{% enddocs %}

{% docs bronze_customer_claims__claim_id %}
Identificador en bruto del siniestro.
{% enddocs %}

{% docs bronze_customer_claims__state %}
Provincia o región asociada al siniestro.
{% enddocs %}

{% docs bronze_customer_claims__cie10_code %}
Código diagnóstico CIE-10 proveniente de la fuente original.
{% enddocs %}

{% docs bronze_customer_claims__diagnosis %}
Descripción del diagnóstico según se registró en el archivo fuente.
{% enddocs %}

{% docs bronze_customer_claims__occurred_date_raw %}
Fecha del evento ocurrido en formato DD/MM/YYYY.
{% enddocs %}

{% docs bronze_customer_claims__payment_date_raw %}
Fecha del pago en formato DD/MM/YYYY.
{% enddocs %}

{% docs bronze_customer_claims__first_expense_date_raw %}
Fecha del primer gasto relacionado con el siniestro.
{% enddocs %}

{% docs bronze_customer_claims__occurred_amount_raw %}
Monto del evento en formato texto, posiblemente usando coma como separador decimal.
{% enddocs %}

{% docs bronze_customer_claims__payment_amount_raw %}
Monto del pago en formato texto, sin procesar.
{% enddocs %}

{% docs bronze_customer_claims__coinsurance_raw %}
Monto de coaseguro en texto.
{% enddocs %}

{% docs bronze_customer_claims__tax_recovery_raw %}
Monto de IVA recuperado en texto.
{% enddocs %}

{% docs bronze_customer_claims__deductible_raw %}
Monto del deducible aplicado al siniestro, en texto.
{% enddocs %}

{% docs bronze_customer_claims__cause %}
Causa reportada del siniestro (por ejemplo, enfermedad o accidente).
{% enddocs %}

{% docs bronze_customer_claims__month_code %}
Código de mes contable en formato YYYYMM.
{% enddocs %}

{% docs bronze_customer_claims__accounting_month_raw %}
Mes contable en formato texto (DD/MM/YYYY).
{% enddocs %}

{% docs bronze_customer_claims__payment_type %}
Tipo de pago (por ejemplo, directo o reembolso).
{% enddocs %}

{% docs bronze_customer_claims__provider_class %}
Nombre del proveedor o clínica en formato sin procesar.
{% enddocs %}

{% docs bronze_customer_claims__certificate_number %}
Número de certificado relacionado con el siniestro (texto).
{% enddocs %}

---

{% docs bronze_customer_certificate_terms %}
Datos crudos de periodos de certificados cargados desde **terms_dummy.csv**, con información de vigencia y cobertura.
{% enddocs %}

{% docs bronze_customer_certificate_terms__id %}
Identificador del registro de vigencia.
{% enddocs %}

{% docs bronze_customer_certificate_terms__certificate_number %}
Número de certificado asociado al periodo de vigencia (texto).
{% enddocs %}

{% docs bronze_customer_certificate_terms__start_date_raw %}
Fecha de inicio del periodo de vigencia (texto, YYYY-MM-DD).
{% enddocs %}

{% docs bronze_customer_certificate_terms__end_date_raw %}
Fecha de finalización del periodo de vigencia (texto, YYYY-MM-DD).
{% enddocs %}

---

{% docs bronze_medical_pathologies %}
Datos crudos de referencia de patologías médicas (catálogo CIE-10) cargados desde **pathologies.csv**.
{% enddocs %}

{% docs bronze_medical_pathologies__code %}
Código CIE-10 como texto (por ejemplo, A000, A001).
{% enddocs %}

{% docs bronze_medical_pathologies__id %}
Identificador numérico interno en formato texto.
{% enddocs %}

{% docs bronze_medical_pathologies__pathology_name %}
Nombre o descripción de la patología según se proporcionó en el CSV original.
{% enddocs %}

---

{% docs bronze_medical_consultations %}
Datos crudos de consultas médicas cargados desde **consultas_dummy.csv**, un archivo delimitado por punto y coma con campos JSON embebidos.
{% enddocs %}

{% docs bronze_medical_consultations__id %}
Identificador único en bruto de la consulta médica.
{% enddocs %}

{% docs bronze_medical_consultations__certificate_number %}
Número de certificado vinculado a la consulta (texto).
{% enddocs %}

{% docs bronze_medical_consultations__consultation_date_raw %}
Fecha de la consulta en texto (YYYY-MM-DD).
{% enddocs %}

{% docs bronze_medical_consultations__closure_json %}
Campo JSON que contiene notas y observaciones médicas estructuradas.
{% enddocs %}

{% docs bronze_medical_consultations__specialty %}
Especialidad médica registrada en la consulta.
{% enddocs %}

{% docs bronze_medical_consultations__placed_by %}
Identificador de la persona o médico que programó o registró la consulta.
{% enddocs %}
