{% snapshot stock_summary_snapshot %}

{%- set source_relation = ref('stock_summary') -%}

{%- set unique_key = 'symbol' -%}

snapshot stock_summary_snapshot {
  config(
    target_schema='snapshots',
    unique_key=unique_key,
    strategy='timestamp',
    updated_at='load_timestamp'
  )

  select * from {{ source_relation }}
}

{% endsnapshot %}