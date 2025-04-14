{% snapshot snapshot_session_summary %}

{{
    config(
        target_schema='analytics',
        unique_key='session_id',
        strategy='check',
        check_cols=['session_start', 'session_end']
    )
}}

select * from {{ ref('session_summary') }}

{% endsnapshot %}
