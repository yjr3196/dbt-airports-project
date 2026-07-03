-- Test that all airport coordinates are within valid geographic ranges
-- Latitude must be between -90 and 90
-- Longitude must be between -180 and 180
-- This test fails if any rows are returned

select 
    airport_ident,
    airport_lat,
    airport_long,
    airport_name
from {{ref ('silver_airports')}}
where (airport_lat is not null and (airport_lat < -90 OR airport_lat > 90))
   OR (airport_long IS NOT NULL AND (airport_long < -180 OR airport_long > 180))
