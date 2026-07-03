with silver_runways as (
    select * from {{ref('src_runways')}}
)

select
    runway_id,
    airport_ident,
    runway_length_ft,
    runway_width_ft,
    case 
        when runway_surface is NULL or TRIM (runway_surface) = '' then '__UNKOWNN__'
        else runway_surface
    end as runway_surface,
    runway_lighted,
    runway_closed
from silver_runways