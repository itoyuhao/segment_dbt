{% macro generate_bronze_table(
    source_name,
    source_table,
    unique_key="unique_key",
    unique_keys=None,
    bq_partition_field="_processed_at"
) -%}

{{
    config(
        materialized="table",
        partition_by={
            "field": bq_partition_field,
            "data_type": "timestamp",
            "granularity": "day",
        }
    )
}}

WITH inputs_data AS (
    SELECT
    {%- if unique_keys %}
        {{ unique_keys | join(" || '_' || ") }} AS {{ unique_key }},
    {%- endif %}
        *,
        ROW_NUMBER() OVER (
            PARTITION BY 
            {%- if unique_keys %}
                {{ unique_keys | join(", ") }}
            {%- else %}
                {{ unique_key }}
            {%- endif %}
            ORDER BY _updated_at DESC
        ) as row_num
    FROM {{ source(source_name, source_table) }} AS inputs
    WHERE _processed_at >= '{{ var("data_interval_start") }}'
)

SELECT 
    {%- if unique_keys %}
        {{ unique_key }},
    {%- endif %}
    * EXCEPT(row_num)
FROM inputs_data
WHERE row_num = 1

{%- endmacro %}