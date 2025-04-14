{{ config(materialized='table') }}

with user_session_channel as (
    select * from {{ ref('user_session_channel') }}
),

session_timestamp as (
    select * from {{ ref('session_timestamp') }}
),

session_combined as (
    select
        usc.session_id,
        usc.user_id,
        usc.channel,
        st.timestamp
    from user_session_channel usc
    join session_timestamp st
        on usc.session_id = st.session_id
)

select
    session_id,
    user_id,
    channel,
    min(timestamp) as session_start,
    max(timestamp) as session_end
from session_combined
group by session_id, user_id, channel
