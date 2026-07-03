
{{ config(materialized='incremental') }}

with silver_airport_comments as (

    select *
    from {{ ref('src_airport_comments') }}

)

select
    comment_id,
    airport_ident,
    comment_timestamp,
    case
        when member_nickname is null then '__UNKNOWN__'
        else member_nickname
    end as member_nickname,
    comment_subject,
    comment_body,
    current_timestamp() as loaded_at
from silver_airport_comments
where comment_body is not null
  and trim(comment_body) != ''

{% if is_incremental() %}
  and comment_id > (
      select coalesce(max(comment_id), 0)
      from {{ this }}
  )
{% endif %}
