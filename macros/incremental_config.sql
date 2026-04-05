{% macro incremental_config(unique_key=None) %}
  {% if unique_key is none %}
    {% set strategy = 'append' %}
  {% else %}
    {% set strategy = 'merge' %}
    {% if unique_key is string %}
      {% set unique_key = [unique_key] %}
    {% endif %}
  {% endif %}

  {{ config(
      materialized='incremental',
      incremental_strategy=strategy,
      unique_key=unique_key,
      on_schema_change='append_new_columns'

  ) }}
{% endmacro %}