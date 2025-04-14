{{ config(materialized='table') }}

with user_session_channel as (
    select
        user_id,
        session_id,
        channel
    from analytics.user_session_channel
)

select * from user_session_channel
