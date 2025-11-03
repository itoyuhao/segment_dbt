{# doc: https://docs.getdbt.com/docs/build/custom-schemas#how-does-dbt-generate-a-models-schema-name #}

{% macro generate_schema_name(custom_schema_name=none, node=none) -%}
    {%- set schema_suffix = '__DEV' if env_var('ENVIRONMENT', 'development') == 'development' else '' -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema }}{{ schema_suffix }}
    {%- else -%}
        {{ custom_schema_name | trim }}{{ schema_suffix }}
    {%- endif -%}
{%- endmacro %}
