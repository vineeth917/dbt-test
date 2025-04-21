{{ config(materialized='table') }}

with price_changes as (
    select 
        symbol,
        date,
        close,
        lag(close) over (partition by symbol order by date) as prev_close,
        rsi_14,
        current_timestamp() as load_timestamp
    from {{ ref('ma_rsi') }}
),

returns as (
    select 
        symbol,
        rsi_14,
        case when prev_close != 0 then round((close - prev_close)/prev_close * 100, 2) else null end as price_change_pct,
        load_timestamp
    from price_changes
)

select * from returns
