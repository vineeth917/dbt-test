# DBT Project: Session Summary Pipeline

This project was built using DBT with Snowflake as the data warehouse.

## 📦 Models
### Input Models
- `user_session_channel`: Contains user, session, and channel info
- `session_timestamp`: Contains session timestamps

### Output Model
- `session_summary`: Combines both sources to compute session start/end per user

## 🔁 Snapshot
- Snapshots the output of `session_summary` to track changes in session duration

## ✅ Tests
Applied on `session_summary.session_id`:
- `not_null`
- `unique`

## 🔗 GitHub Repo
> https://github.com/vineeth917/dbt-test

## 🛠 Technologies
- dbt Cloud
- Snowflake
- GitHub

