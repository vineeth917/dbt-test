{{ config(materialized='table') }}

with base as (
  select
    date,
    symbol,
    close
  from {{ ref('stg_stock_prices') }}
),

ma as (
  select
    date,
    symbol,
    close,
    avg(close) over (
      partition by symbol
      order by date
      rows between 19 preceding and current row
    ) as ma_20,
    avg(close) over (
      partition by symbol
      order by date
      rows between 49 preceding and current row
    ) as ma_50
  from base
),

rsi_calc as (
  select
    date,
    symbol,
    close,
    ma_20,
    ma_50,
    close - lag(close) over (partition by symbol order by date) as change,
    greatest(close - lag(close) over (partition by symbol order by date), 0) as gain,
    greatest(lag(close) over (partition by symbol order by date) - close, 0) as loss
  from ma
),

rsi as (
  select
    date,
    symbol,
    ma_20,
    ma_50,
    round(
      100 - (100 / (
        1 + (
          sum(gain) over (
            partition by symbol
            order by date
            rows between 13 preceding and current row
          ) / nullif(sum(loss) over (
            partition by symbol
            order by date
            rows between 13 preceding and current row
          ), 0)
        )
      )),
      2
    ) as rsi_14
  from rsi_calc
)

select
  date,
  symbol,
  ma_20,
  ma_50,
  rsi_14
from rsi
order by symbol, date
