{% macro generate_bronze(
    source_name,
    source_table,
    unique_key="unique_key",
    unique_keys=None,
    unique_key_type="INT64",
    time_field="_updated_at",
    bq_partition_field="_processed_at"
) -%}

{{
    config(
        materialized="incremental",
        incremental_strategy="merge",
        unique_key=unique_key,
        partition_by={
            "field": bq_partition_field,
            "data_type": "timestamp",
            "granularity": "day",
        },
    )
}}

WITH
    inputs_data AS (
        SELECT
        {%- if unique_keys %}
            {{ unique_keys | join(" || '_' || ") }} AS {{ unique_key }},
        {%- endif %}
            *
        FROM
            {{ source(source_name, source_table) }} AS inputs
        WHERE
        {%- if is_incremental() %}
            _processed_at >= '{{ var("data_interval_start") }}'
        {% else %}
            _processed_at IS NOT NULL
        {%- endif %}
    ),
    outdated_data AS (
        {%- if is_incremental() %}
        SELECT this.{{ unique_key }}
        FROM
            {{ this }} as this
        INNER JOIN
            inputs_data ON this.{{ unique_key }} = inputs_data.{{ unique_key }}
        WHERE NOT (
            inputs_data.{{ time_field }} >= this.{{ time_field }}
            AND inputs_data._processed_at >= this._processed_at
        )
        {% else %}
        SELECT * FROM UNNEST(ARRAY<{{ unique_key_type }}>[]) {{ unique_key }}
        {%- endif %}
    )

SELECT *
FROM
    inputs_data
WHERE
    {{ unique_key }} NOT IN (SELECT {{ unique_key }} FROM outdated_data)
QUALIFY
    ROW_NUMBER() OVER (PARTITION BY {{ unique_key }} ORDER BY _processed_at DESC, {{ time_field }} DESC) = 1

{%- endmacro %}
