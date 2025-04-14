{{ config(materialized='table') }}

with session_timestamp as (
    select
        session_id,
        timestamp
    from analytics.session_timestamp
)

select * from session_timestamp
