{% macro clean_spaces(field) %}
    REGEXP_REPLACE(TRIM({{ field }}), '\\s+', ' ')
{% endmacro %}


{% macro normalize_empty_text(field) %}
    IFF(
        TRIM(UPPER(NULLIF({{ field }}, ''))) IN ('-', 'N/A', 'NA'),
        'NONE',
        NVL(REGEXP_REPLACE(TRIM({{ field }}), '\\s+', ' '), 'NONE')
    )
{% endmacro %}
